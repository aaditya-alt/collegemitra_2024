import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:collegemitra/src/features/authentication/controllers/profile_controller.dart';
import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String? email;
  const UpdateProfileScreen({super.key, required this.email});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final controller = Get.put(ProfileController());
  @override
  void initState() {
    controller.startLoading();
    _fetchUserData();
    super.initState();
  }

  Future<void> _fetchUserData() async {
    try {
      UserModel user = await controller.getUserData(widget.email);
      controller.fullName.text = user.fullName.toString();
      controller.email.text = user.email.toString();
      controller.phoneNo.text = user.phoneNo.toString();
      controller.imageLink.text = user.imageLink.toString();
      controller.password.text = user.password.toString();
      controller.id.text = user.id.toString();
      controller.role.text = user.role.toString();
    } catch (e) {
      debugPrint("Error fetching user data: ${e.toString()}");
    } finally {
      controller.stopLoading();
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        controller.startLoading();
        setState(() {});
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profile_photos/${pickedFile.path.split('/').last}');
        // UploadTask uploadTask = storageReference.putFile(imagePath);
        await storageReference.putFile(File(pickedFile.path));
        //TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String downloadURL = await storageReference.getDownloadURL();

        // Update the imageLink controller with the download URL
        setState(() {
          controller.imageLink.text = downloadURL;
          controller.stopLoading();
        });
      }
    } catch (e) {
      debugPrint(
          "Error during picking photo for updating profile: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tEditProfile,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _pickImage(),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                  image: CachedNetworkImageProvider(
                                      controller.imageLink.text))),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: isDark
                                    ? tPrimaryColor
                                    : tPrimaryColor.shade300,
                              ),
                              child: const Icon(LineAwesomeIcons.camera,
                                  size: 20.0, color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Column(
                    children: [
                      TextFormField(
                        controller: controller.fullName,
                        decoration: const InputDecoration(
                            label: Text(tFullName),
                            prefixIcon: Icon(Icons.person_outline_rounded)),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      TextFormField(
                        controller: controller.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            label: Text(tEmail),
                            prefixIcon: Icon(Icons.email_outlined)),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      TextFormField(
                        controller: controller.phoneNo,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            label: Text(tPhoneNo),
                            prefixIcon: Icon(Icons.call_end_rounded)),
                      ),
                      const SizedBox(height: tFormHeight),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(isDark
                                ? tPrimaryColor
                                : tPrimaryColor.shade300),
                          ),
                          onPressed: () async {
                            controller.startLoading();
                            setState(() {});

                            final userData = UserModel(
                              id: controller.id.text,
                              email: controller.email.text.trim(),
                              password: controller.password.text.trim(),
                              fullName: controller.fullName.text.trim(),
                              phoneNo: controller.phoneNo.text.trim(),
                              role: controller.role.text,
                              imageLink: controller.imageLink.text.trim(),
                            );

                            await controller.updateRecord(userData, context);

                            // ignore: use_build_context_synchronously

                            controller.stopLoading();

                            setState(() {});
                          },
                          child: controller.isLoading.value
                              ? Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        strokeWidth: 4,
                                      ),
                                      const SizedBox(width: 7),
                                      Text("Loading...",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ],
                                  ),
                                )
                              : Text(tEditProfile,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                        ),
                      ),
                      const SizedBox(height: tFormHeight),
                    ],
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: controller.isLoading.value,
            child: Container(
              color:
                  Colors.black.withOpacity(0.5), // Adjust the opacity as needed
              child: Center(
                child: Image.asset(
                  "assets/gif/loader.gif",
                  width: MediaQuery.of(context).size.width / 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

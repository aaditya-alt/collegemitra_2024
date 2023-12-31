import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/blogs_section.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/testimonials.dart';
import 'package:hive/hive.dart';

class BlogSectionAdapter extends TypeAdapter<blogSection> {
  @override
  final typeId = 0; // Unique identifier for the type

  @override
  blogSection read(BinaryReader reader) {
    return blogSection(
      image: reader.read(),
      title: reader.read(),
      subTitle: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, blogSection obj) {
    writer.write(obj.image);
    writer.write(obj.title);
    writer.write(obj.subTitle);
  }
}

class TestimonialAdapter extends TypeAdapter<Testimonial> {
  @override
  final typeId = 1; // Unique identifier for the type

  @override
  Testimonial read(BinaryReader reader) {
    return Testimonial(
      image: reader.read(),
      name: reader.read(),
      designation: reader.read(),
      review: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Testimonial obj) {
    writer.write(obj.image);
    writer.write(obj.name);
    writer.write(obj.designation);
    writer.write(obj.review);
  }
}

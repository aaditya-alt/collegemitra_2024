import 'package:flutter/material.dart';

class ParallaxImages extends StatelessWidget {
  const ParallaxImages({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/images/premium_panel/first.png',
      'assets/images/premium_panel/second.png',
      'assets/images/premium_panel/first.png'
    ];
    return SizedBox(
      height: 260,
      child: PageView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return _buildImage(imagePaths[index], index);
        },
      ),
    );
  }

  Widget _buildImage(String imagePath, int index) {
    return Transform.scale(
      scale: 1.0 - 0.5 * 0.2,
      child: Image.asset(
        imagePath,
        height: 230,
        fit: BoxFit.contain,
      ),
    );
  }
}

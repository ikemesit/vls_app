import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String imageUrl;
  final String headline;
  final String? content;

  const CarouselItem({
    super.key,
    required this.imageUrl,
    required this.headline,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      height: 300.0,
      width: MediaQuery.of(context).size.width,
    );
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   margin: const EdgeInsets.symmetric(horizontal: 0),
    //   decoration: BoxDecoration(
    //     color: Colors.black,
    //     image: DecorationImage(image: new Image.network(imageUrl),
    //   ),
    //   child: Stack(
    //     children: [
    //       Positioned(
    //         child: Container(
    //           width: double.infinity,
    //           height: double.infinity,
    //           decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //               colors: [Colors.black.withAlpha(50), Colors.transparent],
    //               begin: Alignment.bottomCenter,
    //               end: Alignment.topCenter,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

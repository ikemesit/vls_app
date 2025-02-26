import 'package:flutter/material.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          Positioned(
            top: 200.0,
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: Text(
              headline.toUpperCase(),
              style: TTextTheme.darkTextTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}

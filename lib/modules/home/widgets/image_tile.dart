import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageTile extends StatelessWidget {
  final String image;
  final String title;
  const ImageTile({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: CustomColors.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(image),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

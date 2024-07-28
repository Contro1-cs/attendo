import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:flutter/material.dart';

class GeneralButton extends StatefulWidget {
  final String title;
  final Widget icon;
  final Widget trailingIcon;
  final void Function()? onPressed;
  const GeneralButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon = const SizedBox(),
    this.trailingIcon = const Icon(
      Icons.arrow_forward_ios,
      color: CustomColors.white,
      size: 18,
    ),
  });

  @override
  State<GeneralButton> createState() => _GeneralButtonState();
}

class _GeneralButtonState extends State<GeneralButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          backgroundColor: CustomColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.icon,
            const SizedBox(width: 10),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                color: CustomColors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Spacer(),
            widget.trailingIcon,
          ],
        ),
      ),
    );
  }
}

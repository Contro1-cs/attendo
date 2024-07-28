import 'package:attendo/modules/home/screens/announcements_screen.dart';
import 'package:attendo/modules/home/screens/paycheck_screen.dart';
import 'package:attendo/modules/home/screens/stastistics_screen.dart';
import 'package:attendo/modules/shared/widgets/buttons.dart';
import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:attendo/modules/shared/widgets/transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "General",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.black,
            ),
          ),
          const SizedBox(height: 10),
          GeneralButton(
            onPressed: () {
              rightSlideTransition(context, const PaycheckScreen());
            },
            title: "Paycheck",
            icon: SvgPicture.asset("assets/icons/money.svg"),
          ),
          GeneralButton(
            onPressed: () {
              rightSlideTransition(context, const AnnouncementsScreen());
            },
            title: "Announcements",
            icon: SvgPicture.asset("assets/icons/megaphone.svg"),
          ),
          GeneralButton(
            onPressed: () {
              rightSlideTransition(context, const StastisticsScreen());
            },
            title: "Statistics",
            icon: SvgPicture.asset("assets/icons/graph.svg"),
          ),
        ],
      ),
    );
  }
}

import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MonthlyCalendarView extends StatefulWidget {
  const MonthlyCalendarView({super.key});

  @override
  State<MonthlyCalendarView> createState() => _MonthlyCalendarViewState();
}

class _MonthlyCalendarViewState extends State<MonthlyCalendarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.primary.withOpacity(0.3)),
        color: CustomColors.primary10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: CustomColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SvgPicture.asset("assets/icons/calendar.svg"),
              ),
              const SizedBox(width: 10),
              const Text(
                'Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemCount: 20,
              itemBuilder: (context, index) {
                return Column(
                  children: List.generate(
                    6,
                    (index) => Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: CustomColors.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      margin: const EdgeInsets.all(4),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

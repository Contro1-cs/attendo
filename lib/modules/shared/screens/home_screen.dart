import 'package:attendo/modules/shared/screens/monthly_calendar_view.dart';
import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Attendo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const MonthlyCalendarView(),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: CustomColors.darkBlue),
              ),
            )
          ],
        ),
      ),
    );
  }
}

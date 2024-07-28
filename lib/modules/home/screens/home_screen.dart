import 'package:attendo/modules/home/widgets/clock_in_out.dart';
import 'package:attendo/modules/home/widgets/general_section.dart';
import 'package:attendo/modules/home/widgets/image_tile.dart';
import 'package:attendo/modules/home/widgets/monthly_calendar_view.dart';
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
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MonthlyCalendarView(),
              SizedBox(height: 10),
              ClockInOut(),
              SizedBox(height: 20),
              Row(
                children: [
                  ImageTile(
                    image: "assets/icons/illustration1.svg",
                    title: "Apply for leave",
                  ),
                  ImageTile(
                    image: "assets/icons/illustration2.svg",
                    title: "Take a sick leave",
                  ),
                  ImageTile(
                    image: "assets/icons/illustration3.svg",
                    title: "Leaves History",
                  ),
                ],
              ),
              SizedBox(height: 20),
              GeneralSection(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

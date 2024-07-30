import 'package:attendo/modules/admin/screens/admin_dashboard.dart';
import 'package:attendo/modules/home/widgets/clock_in_out.dart';
import 'package:attendo/modules/home/widgets/general_section.dart';
import 'package:attendo/modules/home/widgets/monthly_calendar_view.dart';
import 'package:attendo/modules/onboarding/screens/login.dart';
import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:attendo/modules/shared/widgets/transitions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAdmin = false;

  createMyTeam() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("admin").doc(uid).set({
      "admin": uid,
      "createdAt": DateTime.now().toIso8601String(),
    }).then((value) {
      rightSlideTransition(context, const AdminDashboard());
    });
  }

  checkExistingTeam() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("admin").doc(uid).get().then((value) {
      if (value.exists) {
        setState(() {
          isAdmin = true;
        });
      }
    });
  }

  @override
  void initState() {
    checkExistingTeam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Attendo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: SvgPicture.asset(
              "assets/icons/settings.svg",
              height: 20,
            ),
          ),
        ],
      ),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: CustomColors.primary,
              ),
              child: Center(
                child: Text(
                  'Attendo',
                  style: TextStyle(
                    color: CustomColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: SvgPicture.asset("assets/icons/person.svg", height: 24),
              title: const Text(
                'Profile',
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: SvgPicture.asset("assets/icons/team.svg", height: 24),
              title: Text(
                isAdmin ? 'My team' : 'Create my team',
              ),
              onTap: () {
                if (!isAdmin) {
                  createMyTeam();
                } else {
                  rightSlideTransition(context, const AdminDashboard());
                }
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: const Icon(
                Icons.logout_rounded,
                color: CustomColors.red,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: CustomColors.red,
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MonthlyCalendarView(),
              const SizedBox(height: 10),
              const ClockInOut(),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: CustomColors.redBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_outward_rounded,
                            color: CustomColors.red,
                            size: 24,
                          ),
                          Text(
                            "Apply for leave",
                            style: TextStyle(
                              color: CustomColors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: CustomColors.greenBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.history_rounded,
                            color: CustomColors.green,
                            size: 24,
                          ),
                          Text(
                            "View leave history",
                            style: TextStyle(
                              color: CustomColors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const GeneralSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

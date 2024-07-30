import 'package:attendo/modules/admin/screens/manage_team.dart';
import 'package:attendo/modules/home/screens/home_screen.dart';
import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:attendo/modules/shared/widgets/transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          'Attendo Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //open menu
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                items: [
                  const PopupMenuItem(
                    value: 1,
                    child: Text(
                      'Manage Team',
                      style: TextStyle(
                        color: CustomColors.black,
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 2,
                    child: Text(
                      'Leave Dashboard',
                      style: TextStyle(
                        color: CustomColors.red,
                      ),
                    ),
                  ),
                ],
                elevation: 8.0,
              ).then((value) {
                switch (value) {
                  case 1:
                    rightSlideTransition(context, const ManageTeam());
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                    break;
                  default:
                }
              });
            },
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: const Center(
        child:  Text('Admin Dashboard'),
      ),
    );
  }
}

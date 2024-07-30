import 'package:attendo/modules/admin/screens/employee_details.dart';
import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:attendo/modules/shared/widgets/transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/employee_model.dart';

class ManageTeam extends StatefulWidget {
  const ManageTeam({super.key});

  @override
  State<ManageTeam> createState() => _ManageTeamState();
}

class _ManageTeamState extends State<ManageTeam> {
  TextEditingController _searchController = TextEditingController();
  List<EmployeeModel> _filteredEmployees = const [];
  List<EmployeeModel> employees = const [
    EmployeeModel(
      id: '1',
      name: 'John Doe',
      email: "john.doe@example.com",
      role: "Frontend developer",
      phone: "+91 1234567890",
      salary: 100000,
    ),
    EmployeeModel(
      id: '2',
      name: 'Jane Smith',
      email: "jane.smith@example.com",
      role: "Backend developer",
      phone: "+91 9876543210",
      salary: 120000,
    ),
    EmployeeModel(
      id: '3',
      name: 'Alex Johnson',
      email: "alex.johnson@example.com",
      role: "UI/UX designer",
      phone: "+91 5555555555",
      salary: 80000,
    ),
    EmployeeModel(
      id: '4',
      name: 'Sarah Williams',
      email: "sarah.williams@example.com",
      role: "Full-stack developer",
      phone: "+91 9999999999",
      salary: 150000,
    ),
  ];

  @override
  void initState() {
    _filteredEmployees = employees;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Team'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primary,
        onPressed: () {
          //add new member
        },
        child: const Icon(
          Icons.add_rounded,
          color: CustomColors.white,
          size: 28,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _filteredEmployees = employees
                      .where((element) =>
                          element.name
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          element.role
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: CustomColors.primary10,
                hintText: 'Search by name, role',
                hintStyle: const TextStyle(
                  color: CustomColors.placeholder,
                ),
                prefixIcon: SvgPicture.asset(
                  "assets/icons/search.svg",
                  fit: BoxFit.scaleDown,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredEmployees.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    rightSlideTransition(context,
                        EmployeeDetails(employee: _filteredEmployees[index]));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: CustomColors.placeholder, width: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _filteredEmployees[index].name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.black,
                              ),
                            ),
                            Text(
                              _filteredEmployees[index].role,
                              style: const TextStyle(
                                fontSize: 12,
                                color: CustomColors.placeholder,
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: CustomColors.placeholder,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:attendo/modules/admin/models/employee_model.dart';
import 'package:attendo/modules/admin/screens/employee_stastistics.dart';
import 'package:attendo/modules/shared/widgets/buttons.dart';
import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeDetails extends StatefulWidget {
  final EmployeeModel employee;
  const EmployeeDetails({super.key, required this.employee});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  formatSalary(int salary) {
    if (salary > 999999) {
      return "${(salary / 1000000).toStringAsFixed(1)}M";
    }
    if (salary > 99999) {
      return "${(salary / 1000).toStringAsFixed(0)}K";
    } else {
      return salary.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          widget.employee.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: CustomColors.greenBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Cost To Company",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: CustomColors.green,
                          ),
                        ),
                        Text(
                          "\$${formatSalary(widget.employee.salary)}",
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const EmployeeStastistics(),
            const SizedBox(height: 20),
            GeneralButton(
              icon: SvgPicture.asset("assets/icons/coins.svg"),
              title: "Cost Breakdown",
              onPressed: () {},
            ),
            GeneralButton(
              icon: SvgPicture.asset("assets/icons/edit.svg"),
              title: "Edit Details",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:attendo/modules/home/models/income_model.dart';
import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:flutter/material.dart';

class PaycheckScreen extends StatefulWidget {
  const PaycheckScreen({super.key});

  @override
  State<PaycheckScreen> createState() => _PaycheckScreenState();
}

class _PaycheckScreenState extends State<PaycheckScreen> {
  final int _baseSalary = 10321;
  int _totalIncome = 0;
  List<IncomeModel> income = [];

  paycheckOptions() {
    //create a menu item list
    final List<String> options = ['Option 1', 'Option 2'];
    //show the menu
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: options.map((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    ).then((String? value) {
      if (value != null) {
        //perform the action based on the selected option
        switch (value) {
          case 'Option 1':
            //perform action 1
            break;
          case 'Option 2':
            //perform action 2
            break;
        }
      }
    });
  }

  String formatSalary(int num) {
    String formattedSalary = num.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return formattedSalary;
  }

  calculateTotalPay(List<IncomeModel> income) {
    setState(() {
      _totalIncome = income.fold(
        0,
        (previousValue, element) {
          if (element.type == "INCOME") {
            return previousValue + element.amount;
          } else {
            return previousValue - element.amount;
          }
        },
      );
    });
  }

  @override
  void initState() {
    income = [
      IncomeModel(type: "INCOME", amount: _baseSalary, label: "Base income"),
      const IncomeModel(type: "DEDUCTION", amount: 823, label: "Leaves"),
      const IncomeModel(type: "INCOME", amount: 80, label: "Overtime"),
      const IncomeModel(type: "DEDUCTION", amount: 120, label: "Insurance"),
    ];
    calculateTotalPay(income);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text('Paycheck'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              paycheckOptions();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: CustomColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Base Salary',
                    style: TextStyle(
                      color: CustomColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AnimatedTextKit(
                        pause: const Duration(milliseconds: 100),
                        totalRepeatCount: 2,
                        animatedTexts: [
                          TyperAnimatedText(
                            "\$${formatSalary(_baseSalary)}",
                            textStyle: const TextStyle(
                              height: 1.1,
                              color: CustomColors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                      const Text(
                        "  /mo",
                        style: TextStyle(
                          color: CustomColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "This month",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CustomColors.black,
              ),
            ),
            const SizedBox(height: 4),
            ListView.builder(
              shrinkWrap: true,
              itemCount: income.length,
              itemBuilder: (context, index) => Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CustomColors.placeholder,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      income[index].label,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      income[index].type == "INCOME"
                          ? "+\$${formatSalary(income[index].amount)}"
                          : "-\$${formatSalary(income[index].amount)}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 16,
                        color: income[index].type == "INCOME"
                            ? const Color(0XFF87C661)
                            : CustomColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 60,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: CustomColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20,
                      color: CustomColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AnimatedTextKit(
                    pause: const Duration(milliseconds: 300),
                    totalRepeatCount: 2,
                    animatedTexts: [
                      TyperAnimatedText(
                        "\$${formatSalary(_totalIncome)}",
                        textAlign: TextAlign.end,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

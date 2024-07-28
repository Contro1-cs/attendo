import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StastisticsScreen extends StatefulWidget {
  const StastisticsScreen({super.key});

  @override
  State<StastisticsScreen> createState() => _StastisticsScreenState();
}

class _StastisticsScreenState extends State<StastisticsScreen> {
  double insuranceVal = 0;
  double benifitsVal = 0;
  double taxVal = 0;
  double inHandVal = 0;

  Map<String, double> salaryBreakdown = {
    "base": 10344,
    "insurance": 420,
    "benifits": 1055,
    "tax": 1299,
  };

  Map<String, double> stats = {
    "overall": 99,
    "attendancePercentile": 99.9,
    "attendance": 98.8,
    "avgTakeHome": 9975,
    "medianLeaves": 1.9,
    "medianLate": 0.5,
    "medianSickLeaves": 0.2,
  };

  void setPieChartValues() {
    setState(() {
      insuranceVal =
          (salaryBreakdown['insurance']! / salaryBreakdown['base']!) * 100;
      benifitsVal =
          (salaryBreakdown['benifits']! / salaryBreakdown['base']!) * 100;
      taxVal = (salaryBreakdown['tax']! / salaryBreakdown['base']!) * 100;
      inHandVal = 100 - insuranceVal - benifitsVal - taxVal;
    });
  }

  @override
  void initState() {
    setPieChartValues();
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
            const Text('Stastistics'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        //Attendance
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: CustomColors.primary10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Avg. attendance",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "${stats['attendance']}%",
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (stats['attendance'] != null &&
                                  stats['attendance']! > 90)
                                Text(
                                  "This places you in the top ${(100 - stats['attendancePercentile']!).toStringAsFixed(1)}% globally!",
                                  style: const TextStyle(fontSize: 12),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        //Avg Salary
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: CustomColors.primary10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Avg. take home",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "\$${stats['avgTakeHome']?.toInt()}",
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        //Overall Score
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: CustomColors.primary10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Overall Score",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                stats['overall']!.toStringAsFixed(0),
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        if (stats['medianLeaves'] != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.primary10,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Median leaves",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${stats['medianLeaves']?.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        height: 1.2,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      " /mo",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),
                        if (stats['medianLate'] != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.primary10,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Median late",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${stats['medianLate']?.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        height: 1.2,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      " /mo",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),
                        if (stats['medianSickLeaves'] != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.primary10,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Sick leaves",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${stats['medianSickLeaves']?.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        height: 1,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      " /mo",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                "Salary Breakdown",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 180,
                      width: 180,
                      child: PieChart(
                        PieChartData(
                          titleSunbeamLayout: true,
                          sectionsSpace: 0,
                          centerSpaceRadius: 50,
                          sections: [
                            PieChartSectionData(
                              showTitle: false,
                              color: Colors.green,
                              value: insuranceVal,
                              title: '${insuranceVal.toStringAsFixed(0)}%',
                              radius: 20,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              color: Colors.red,
                              value: benifitsVal,
                              title: '${benifitsVal.toStringAsFixed(0)}%',
                              radius: 20,
                              titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              color: Colors.blue[900],
                              value: taxVal,
                              title: '${taxVal.toStringAsFixed(0)}%',
                              radius: 20,
                              titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              color: Colors.purple,
                              value: inHandVal,
                              title: '${inHandVal.toStringAsFixed(0)}%',
                              radius: 20,
                              titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLegendItem(
                          '${insuranceVal.toStringAsFixed(1)}% Insurance',
                          Colors.green,
                        ),
                        _buildLegendItem(
                          '${benifitsVal.toStringAsFixed(1)}% Benifits',
                          Colors.red,
                        ),
                        _buildLegendItem(
                          '${taxVal.toStringAsFixed(1)}% Tax',
                          Colors.blue[900]!,
                        ),
                        _buildLegendItem(
                          '${inHandVal.toStringAsFixed(1)}% In Hand',
                          Colors.purple,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

// Helper method for legend items
  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

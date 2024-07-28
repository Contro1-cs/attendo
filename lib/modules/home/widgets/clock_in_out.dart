import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:attendo/modules/shared/widgets/snackbars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

class ClockInOut extends StatefulWidget {
  const ClockInOut({super.key});

  @override
  State<ClockInOut> createState() => _ClockInOutState();
}

class _ClockInOutState extends State<ClockInOut> {
  bool clockedIn = false;
  TextEditingController _pinContoller = TextEditingController();

  checkClockIn() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference<Map<String, dynamic>> thisMonth = FirebaseFirestore
        .instance
        .collection('attendance')
        .doc(uid)
        .collection(DateTime.now().year.toString())
        .doc(DateTime.now().month.toString());

    thisMonth.get().then((response) {
      if (response.exists) {
        if (response.data()![DateTime.now().day.toString()] != null) {
          if (response.data()![DateTime.now().day.toString()]
              ['validateClockin']) {
            setState(() {
              clockedIn = true;
            });
          }
        }
      }
    });
  }

  clockoutSession() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference<Map<String, dynamic>> thisMonth = FirebaseFirestore
        .instance
        .collection('attendance')
        .doc(uid)
        .collection(DateTime.now().year.toString())
        .doc(DateTime.now().month.toString());

    thisMonth.get().then((response) {
      if (response.exists) {
        thisMonth.update({
          DateTime.now().day.toString(): {
            ...response.data()![DateTime.now().day.toString()],
            "clockout": DateTime.now().toIso8601String(),
            "validateClockout": true,
            "sessionLength": DateTime.now()
                .difference(DateTime.parse(
                    response.data()![DateTime.now().day.toString()]['clockin']))
                .inMinutes,
          }
        });
      }
    }).then((value) {
      successSnackBar(context,
          'Clocked out at ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}');
      setState(() {
        clockedIn = false;
      });
    });
  }

  clockinSession() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference<Map<String, dynamic>> thisMonth = FirebaseFirestore
        .instance
        .collection('attendance')
        .doc(uid)
        .collection(DateTime.now().year.toString())
        .doc(DateTime.now().month.toString());

    thisMonth.get().then((response) {
      if (response.exists) {
        thisMonth.set({
          DateTime.now().day.toString(): {
            "clockin": DateTime.now().toIso8601String(),
            "validateClockin": true,
            "day": DateFormat('EEEE').format(DateTime.now()),
          }
        });
      }
    }).then((value) {
      successSnackBar(context,
          'Clocked in at ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}');
      setState(() {
        clockedIn = true;
      });
    });
  }

  clockInBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Enter your PIN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Pinput(
                      controller: _pinContoller,
                      autofocus: true,
                      length: 4,
                      obscureText: true,
                      defaultPinTheme: const PinTheme(
                        height: 60,
                        width: 50,
                        textStyle: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primary,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: CustomColors.primary10,
                        ),
                      ),
                      focusedPinTheme: const PinTheme(
                        height: 60,
                        width: 50,
                        textStyle: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primary,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: CustomColors.primary,
                        ),
                      ),
                      onCompleted: (pin) {
                        if (clockedIn) {
                          clockoutSession();
                        } else {
                          clockinSession();
                        }
                        _pinContoller.clear();
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  @override
  void initState() {
    checkClockIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return clockedIn
        ? Container(
            padding: const EdgeInsets.fromLTRB(10, 16, 16, 10),
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: CustomColors.darkBlue),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/logout.svg"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ongoing session",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1)),
                          builder: (context, snapshot) {
                            return Row(
                              children: [
                                Text(
                                  DateFormat('EEEE').format(DateTime.now()),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  "|",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.access_time, size: 12),
                                const SizedBox(width: 2),
                                Text(
                                  "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _pinContoller.clear();
                        clockInBottomSheet();
                      },
                      child: const Row(
                        children: [
                          Text(
                            "Clock out",
                            style: TextStyle(
                              color: CustomColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.logout, color: CustomColors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.fromLTRB(10, 16, 16, 10),
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: CustomColors.darkBlue),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/secure_login.svg"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatDate(
                        DateTime.now(),
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1)),
                          builder: (context, snapshot) {
                            return Row(
                              children: [
                                Text(
                                  DateFormat('EEEE').format(DateTime.now()),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  "|",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.access_time, size: 12),
                                const SizedBox(width: 2),
                                Text(
                                  "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _pinContoller.clear();
                        clockInBottomSheet();
                      },
                      child: Row(
                        children: [
                          const Text(
                            "Clock in",
                            style: TextStyle(
                              color: CustomColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 6),
                          SvgPicture.asset("assets/icons/login.svg"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}

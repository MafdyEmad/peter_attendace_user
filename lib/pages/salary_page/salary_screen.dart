import 'package:attendance/component/alert_dialog.dart';
import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/mails_page/mails_screen.dart';
import 'package:attendance/pages/salary_page/salary_screen_cubit.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/deductions.dart';
import '../sign_in_page/sign_in_cubit/sign_in_cubit.dart';

class SalaryScreen extends StatelessWidget {
  const SalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              indicatorColor: switchColor,
              tabs: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event_available_sharp,
                      color: primaryTextColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Vacations",
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: primaryFontSize,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "-",
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: primaryFontSize,
                      ),
                    ),
                    Icon(
                      Icons.attach_money,
                      color: primaryTextColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Deductions",
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: primaryFontSize,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
        body: TabBarView(
          children: [
            MailsScreen(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 15,
                    child: StreamBuilder<List<Deductions>>(
                      stream: SalaryScreenCubit.get(context).getData(
                        LoginScreenCubit.get(context).getCurrentUser()?.uid,
                      ),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data?.length == 0) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Image.asset('assets/no_data.png'),
                                ),
                                const Text(
                                  'No data',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryTextColor,
                                    fontSize: secondaryFontSize,
                                  ),
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                showMyDialog(
                                    backgroundColor: secondaryColor,
                                    context: context,
                                    barrierDismissible: true,
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "From:",
                                          style: TextStyle(
                                            color: switchColor,
                                            fontSize: primaryFontSize,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          snapshot.data[index].from,
                                          style: const TextStyle(
                                            color: primaryTextColor,
                                            fontSize: primaryFontSize,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        const Text(
                                          "Reason:",
                                          style: TextStyle(
                                            color: switchColor,
                                            fontSize: primaryFontSize,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Reason: ${snapshot.data[index].reason}",
                                          style: const TextStyle(
                                            color: primaryTextColor,
                                            fontSize: primaryFontSize,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        const Text(
                                          "Deductions",
                                          style: TextStyle(
                                            color: switchColor,
                                            fontSize: primaryFontSize,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          snapshot.data[index].amount
                                              .toString(),
                                          maxLines: 1,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.red,
                                            fontSize: primaryFontSize,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        const Text(
                                          "Date",
                                          style: TextStyle(
                                            color: switchColor,
                                            fontSize: primaryFontSize,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          DateFormat('yyyy-MM-dd HH:mm').format(
                                              snapshot.data[index].date
                                                  .toDate()),
                                          maxLines: 1,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: primaryTextColor,
                                            fontSize: primaryFontSize,
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                              title: Text(
                                snapshot.data[index].from,
                                style: const TextStyle(
                                  color: primaryTextColor,
                                  fontSize: primaryFontSize,
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data[index].reason,
                                maxLines: 1,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: secondaryTextColor,
                                  fontSize: primaryFontSize,
                                ),
                              ),
                              trailing: Text(
                                snapshot.data[index].amount.toString(),
                                maxLines: 1,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.red,
                                  fontSize: secondaryFontSize,
                                ),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Image.asset('assets/error.png'),
                                ),
                                const Text(
                                  'An error occurred',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryTextColor,
                                    fontSize: secondaryFontSize,
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return const Center(
                            child:
                                CircularProgressIndicator(color: switchColor));
                      },
                    ),
                  ),
                  // const Spacer(),
                  // Expanded(
                  //   flex: 1,
                  //   child: StreamBuilder(
                  //     stream: SalaryScreenCubit.get(context).getTotalSalary(),
                  //     builder: (context, snapshout) {
                  //       if (snapshout.hasData) {
                  //         return Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 "Total salary : ${snapshout.data!.get("total salary")} EGP",
                  //                 style: const TextStyle(
                  //                     color: primaryTextColor,
                  //                     fontSize: primaryFontSize),
                  //               ),
                  //             ),
                  //             Expanded(
                  //               child: Text(
                  //                 "Total working hours : ${(snapshout.data!.get("total working hours") / 60).toInt()} : ${(snapshout.data!.get("total working hours") % 60).toInt()}",
                  //                 style: const TextStyle(
                  //                     color: primaryTextColor,
                  //                     fontSize: primaryFontSize),
                  //               ),
                  //             ),
                  //           ],
                  //         );
                  //       } else if (snapshout.hasError) {
                  //         return const Text(
                  //           "There is an error",
                  //           style: TextStyle(
                  //               color: primaryTextColor,
                  //               fontSize: primaryFontSize),
                  //         );
                  //       } else {
                  //         return const Text(
                  //           "Loading..",
                  //           style: TextStyle(
                  //               color: primaryTextColor,
                  //               fontSize: primaryFontSize),
                  //         );
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

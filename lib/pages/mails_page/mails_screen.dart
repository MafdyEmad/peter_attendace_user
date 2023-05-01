import 'package:attendance/component/mail_info_card.dart';
import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:attendance/component/alert_dialog.dart';
import 'package:attendance/component/mail_widget.dart';
import 'package:attendance/models/mail_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'mails_page_cubit/mails_page_cubit_screen_cubit.dart';
import 'mails_page_cubit/mails_page_cubit_screen_states.dart';

class MailsScreen extends StatelessWidget {
  MailsScreen({super.key});
  final messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MailsScreenCubit, MailsScreenState>(
      listener: (context, state) {
        if (state is MailScreenSendMailLoadingState) {
          Navigator.pop(context);
          showMyDialog(
            backgroundColor: Colors.transparent,
            barrierColor: const Color.fromARGB(100, 0, 0, 0),
            context: context,
            barrierDismissible: false,
            content: WillPopScope(
              onWillPop: LoginScreenCubit.get(context).onWillPop,
              child: const Center(
                child: CircularProgressIndicator(color: switchColor),
              ),
            ),
          );
        } else if (state is MailScreenSendMailSuccessState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(
              context,
              content: const Center(
                child: Text(
                  "Message sent",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: secondaryFontSize,
                  ),
                ),
              ),
            ),
          );
        } else if (state is MailScreenSendMailFailedState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(
              context,
              content: const Center(
                child: Text(
                  "Faild to send the Message",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: secondaryFontSize,
                  ),
                ),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder<List<Mail>>(
          stream: MailsScreenCubit.get(context)
              .getData(LoginScreenCubit.get(context).getCurrentUser()?.uid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data?.length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Image.asset('assets/no_data.png'),
                    ),
                  ),
                  const Text(
                    'No data',
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: primaryFontSize,
                    ),
                  )
                ],
              );
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Container(
                    height: 6,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      // color: secondaryColor,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          showMyDialog(
                            backgroundColor: secondaryColor,
                            context: context,
                            barrierDismissible: true,
                            title: const Center(
                              child: Text(
                                'Mail Informations',
                                style: TextStyle(
                                  color: primaryTextColor,
                                  fontSize: primaryFontSize,
                                ),
                              ),
                            ),
                            content: MailInfo(
                              message: snapshot.data[index].content,
                              isApproved: snapshot.data[index].isApproved,
                              endTime: snapshot.data[index].vacationToDate,
                              startTime: snapshot.data[index].vacationFromDate,
                              date: snapshot.data[index].sendDate,
                            ),
                          );
                        },
                        child: Ink(
                            child: MyMail(
                          to: snapshot.data[index].to,
                          isApproved: snapshot.data[index].isApproved,
                          content: snapshot.data[index].content,
                          sendDate: snapshot.data[index].sendDate,
                        )),
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset('assets/error.png'),
                    ),
                  ),
                  const Text(
                    'An error occurred',
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: primaryFontSize,
                    ),
                  )
                ],
              );
            }
            return const Center(
                child: CircularProgressIndicator(color: switchColor));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showMyDialog(
              backgroundColor: secondaryColor,
              context: context,
              barrierDismissible: true,
              title: const Text(
                'Send Message to Admin',
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: primaryFontSize,
                ),
              ),
              content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.7,
                        child: SfDateRangePicker(
                          monthViewSettings:
                              const DateRangePickerMonthViewSettings(
                            viewHeaderStyle: DateRangePickerViewHeaderStyle(
                              textStyle: TextStyle(color: secondaryTextColor),
                            ),
                          ),
                          yearCellStyle: DateRangePickerYearCellStyle(
                            disabledDatesTextStyle: TextStyle(
                              color: secondaryTextColor.withAlpha(100),
                            ),
                            textStyle: const TextStyle(
                              color: primaryTextColor,
                            ),
                          ),
                          headerStyle: const DateRangePickerHeaderStyle(
                            textStyle: TextStyle(
                              color: primaryTextColor,
                            ),
                          ),
                          monthCellStyle: DateRangePickerMonthCellStyle(
                            leadingDatesTextStyle: const TextStyle(
                              color: primaryTextColor,
                            ),
                            disabledDatesTextStyle: TextStyle(
                              color: secondaryTextColor.withAlpha(100),
                            ),
                            textStyle: const TextStyle(
                              color: primaryTextColor,
                            ),
                          ),
                          todayHighlightColor: Colors.transparent,
                          rangeSelectionColor:
                              const Color.fromARGB(250, 250, 204, 21)
                                  .withAlpha(100),
                          startRangeSelectionColor: switchColor,
                          endRangeSelectionColor:
                              const Color.fromARGB(255, 255, 35, 101),
                          selectionMode:
                              DateRangePickerSelectionMode.extendableRange,
                          showActionButtons: true,
                          minDate: DateTime.now(),
                          onSubmit: (time) {
                            if (time != null) {
                              final timeRange = time as PickerDateRange;
                              if (timeRange.startDate != null &&
                                  timeRange.endDate != null) {
                                MailsScreenCubit.get(context).getVacation(
                                  from: timeRange.startDate,
                                  to: timeRange.endDate,
                                );
                              } else if (timeRange.startDate != null) {
                                MailsScreenCubit.get(context).getVacation(
                                  from: timeRange.startDate,
                                  to: timeRange.startDate,
                                );
                              }
                            }
                          },
                          onCancel: () {
                            MailsScreenCubit.get(context).cancelVacation();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Start time : ",
                            style: TextStyle(
                              color: primaryTextColor,
                              fontSize: secondaryFontSize,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<MailsScreenCubit,
                                  MailsScreenState>(
                                builder: (context, state) => Center(
                                  child: Text(
                                    DateFormat("yyyy-MM-dd").format(
                                      MailsScreenCubit.get(context)
                                          .vacatioFromDAte,
                                    ),
                                    style: const TextStyle(
                                      color: primaryTextColor,
                                      fontSize: secondaryFontSize,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "End time : ",
                            style: TextStyle(
                              color: primaryTextColor,
                              fontSize: secondaryFontSize,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<MailsScreenCubit,
                                  MailsScreenState>(
                                builder: (context, state) => Center(
                                  child: Text(
                                    DateFormat("yyyy-MM-dd").format(
                                      MailsScreenCubit.get(context)
                                          .vacatioToDAte,
                                    ),
                                    style: const TextStyle(
                                      color: primaryTextColor,
                                      fontSize: secondaryFontSize,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        "Message : ",
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: secondaryFontSize,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please type somthing";
                          } else {
                            return null;
                          }
                        },
                        controller: messageController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(
                          color: primaryTextColor,
                          fontSize: secondaryFontSize,
                        ),
                        cursorColor: secondaryTextColor,
                        decoration: const InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: secondaryTextColor)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: secondaryTextColor)),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 97, 97, 97),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                MailsScreenCubit.get(context).vacatioFromDAte =
                                    DateTime.now();
                                MailsScreenCubit.get(context).vacatioToDAte =
                                    DateTime.now();

                                messageController.text = "";
                              },
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  color: primaryTextColor,
                                  fontSize: secondaryFontSize,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: switchColor),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await MailsScreenCubit.get(context)
                                      .senMailToAdmin(context,
                                          uid: LoginScreenCubit.get(context)
                                              .getCurrentUser()
                                              ?.uid,
                                          content: messageController.text,
                                          dateFrom:
                                              MailsScreenCubit.get(context)
                                                  .vacatioFromDAte,
                                          dateTo: MailsScreenCubit.get(context)
                                              .vacatioToDAte);
                                  messageController.text = "";
                                }
                              },
                              child: const Text(
                                'Submt',
                                style: TextStyle(
                                  color: primaryTextColor,
                                  fontSize: secondaryFontSize,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          backgroundColor: switchColor,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

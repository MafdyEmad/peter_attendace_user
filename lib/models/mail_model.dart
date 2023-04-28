import 'package:cloud_firestore/cloud_firestore.dart';

class Mail {
  final userDocUid;
  final adminDocUid;
  final sendDate;
  final from;
  final to;
  final content;
  final senderName;
  final vacationToDate;
  final vacationFromDate;
  final isApproved;

  Mail({
    this.adminDocUid,
    this.userDocUid,
    this.senderName,
    this.isApproved,
    this.vacationToDate,
    this.vacationFromDate,
    this.sendDate,
    this.from,
    this.to,
    this.content,
    // this.docUid,
  });

  factory Mail.fromJson(Map<String, dynamic> jsonData) {
    return Mail(
      adminDocUid: jsonData['admin doc uid'] as String,
      userDocUid: jsonData['user doc uid'] as String,
      senderName: jsonData['senderName'] as String,
      isApproved: jsonData['is approved'] as String,
      sendDate: jsonData['send date'] as Timestamp,
      from: jsonData['from'] as String,
      to: jsonData['to'] as String,
      content: jsonData['content'] as String,
      vacationFromDate: jsonData['vacation from date'] as Timestamp,
      vacationToDate: jsonData['vacation to date'] as Timestamp,
    );
  }
  Map<String, dynamic> toJson() => {
        'is approved': isApproved,
        'user doc uid': userDocUid,
        'admin doc uid': adminDocUid,
        'send date': sendDate,
        'senderName': senderName,
        'from': from,
        'to': to,
        'content': content,
        'vacation from date': vacationFromDate,
        'vacation to date': vacationToDate,
      };
}

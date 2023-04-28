import 'package:cloud_firestore/cloud_firestore.dart';

class Deductions {
  final docUid;
  final date;
  final reason;
  final from;

  final amount;
  Deductions({
    this.docUid,
    this.reason,
    this.from,
    this.amount,
    this.date,
  });

  factory Deductions.fromJson(Map<String, dynamic> jsonData) {
    return Deductions(
      docUid: jsonData['doc uid'] as String,
      date: jsonData['date'] as Timestamp,
      reason: jsonData["reason"] as String,
      from: jsonData['from'] as String,
      amount: jsonData['amount'] as double,
    );
  }
  Map<String, dynamic> toJson() => {
        'doc uid': docUid,
        'date': date,
        'reason': reason,
        'from': from,
        'amount': amount,
      };
}

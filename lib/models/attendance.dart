import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  final docUid;
  final date;
  final isClockIn;
  final clockInLocation;
  final clockOutLocation;
  final clockInDate;
  final clockOutDate;
  final workingHours;
  Attendance(
      {this.docUid,
      this.date,
      this.workingHours,
      this.isClockIn,
      this.clockInLocation,
      this.clockOutLocation,
      this.clockInDate,
      this.clockOutDate});

  factory Attendance.fromJson(Map<String, dynamic> jsonData) {
    return Attendance(
      docUid: jsonData['doc uid'] as String,
      date: jsonData['date'] as String,
      workingHours: jsonData["working hours"] as String,
      isClockIn: jsonData['is clock in'] as bool,
      clockInLocation: jsonData['clock in location'],
      clockOutLocation: jsonData['clock out location'] as GeoPoint,
      clockInDate: jsonData['clock in date'] as Timestamp,
      clockOutDate: jsonData['clock out date'] as Timestamp,
    );
  }
  Map<String, dynamic> toJson() => {
        'is clock in': isClockIn,
        'date': date,
        "working hours": workingHours ?? "--,--",
        'clock in location': clockInLocation,
        'clock out location': clockOutLocation ?? const GeoPoint(0, 0),
        'clock in date': clockInDate,
        'clock out date': clockOutDate ?? Timestamp.now(),
        'doc uid': docUid
      };
}

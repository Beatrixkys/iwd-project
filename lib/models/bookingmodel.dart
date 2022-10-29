import 'package:cloud_firestore/cloud_firestore.dart';

class BookingData {
  final String bookingId;
  final String serviceId;
  final String servicename;
  final Timestamp date;

  final String time;

  BookingData({
    required this.bookingId,
    required this.serviceId,
    required this.servicename,
    required this.date,
    required this.time,
  });
}

//editing etc

class AppointmentData {
  final String aptId;
  final String servicename;
  final Timestamp date;
  final String report;
  final String file;
  //final String attachment;
  AppointmentData({
    required this.aptId,
    required this.servicename,
    required this.date,
    required this.report,
    required this.file, 
  });
}

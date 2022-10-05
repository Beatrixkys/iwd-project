import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bookingmodel.dart';
import '../models/servicemodel.dart';
import '../models/usermodel.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);
  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("user");

  final CollectionReference<Map<String, dynamic>> bookingCollection =
      FirebaseFirestore.instance.collection("booking");

  final CollectionReference<Map<String, dynamic>> enquiryCollection =
      FirebaseFirestore.instance.collection("enquiry");
  Future<void> saveUser(String name, String email, String number) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'email': email, 'number': number});
  }

  Future<void> addBooking(
      String servicename, String serviceid, String time, Timestamp date) async {
    //doc will create a new uid of Database service
    return await bookingCollection
        .doc(uid)
        .collection('bookingdetails')
        .doc()
        .set({
      'serviceId': serviceid,
      'servicename': servicename,
      'date': date,
      'time': time,
    });
  }

  Future<void> updateBooking(
      String bid, String servicename, String time, Timestamp date) async {
    //doc will create a new uid of Database service
    return await bookingCollection
        .doc(uid)
        .collection('bookingdetails')
        .doc(bid)
        .update({
      'servicename': servicename,
      'date': date,
      'time': time,
    });
  }

  Future<void> deleteBooking(String docid) async {
    //doc will create a new uid of Database service
    return await bookingCollection
        .doc(uid)
        .collection('bookingdetails')
        .doc(docid)
        .delete();
  }

  Future<void> addApt(String servicename, Timestamp date) async {
    //doc will create a new uid of Database service
    return await bookingCollection.doc(uid).collection('aptdetails').doc().set({
      'servicename': servicename,
      'date': date,
      'report': "No Report Yet",
    });
  }

  Future<void> updateApt(String report, String aptid) async {
    //doc will create a new uid of Database service
    return await bookingCollection
        .doc(uid)
        .collection('aptdetails')
        .doc(aptid)
        .update({
      'report': report,
    });
  }

  Future<void> addEnquiry(
      String ename, String eemail, String enumber, String enquiry) async {
    //doc will create a new uid of Database service
    return await enquiryCollection.doc(uid).set({
      'enquiries': FieldValue.arrayUnion([
        {
          'ename': ename,
          'eemail': eemail,
          'enumber': enumber,
          'enquiry': enquiry,
        }
      ])
    }, SetOptions(merge: true));
  }

  MyUserData _userFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return MyUserData(
      uid: snapshot.id,
      name: data['name'],
      email: data['email'],
      number: data['number'],
    );
  }

//Create a SINGLE user stream
  //stream qui récupre le user courant donc
  // besoin de doc(uid)
  Stream<MyUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<BookingData> _bookingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BookingData(
        bookingId: doc.id,
        date: (doc.data() as dynamic)['date'] ?? Timestamp.now(),
        servicename: (doc.data() as dynamic)['servicename'] ?? '',
        serviceId: (doc.data() as dynamic)['serviceId'] ?? '',
        time: (doc.data() as dynamic)['time'] ?? '',
      );
    }).toList();
  }

  Stream<List<BookingData>> get booking {
    final CollectionReference<Map<String, dynamic>> bookingdetailsCollection =
        bookingCollection.doc(uid).collection("bookingdetails");

    return bookingdetailsCollection.snapshots().map(_bookingListFromSnapshot);
  }

  List<AppointmentData> _aptListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AppointmentData(
        aptId: doc.id,
        date: (doc.data() as dynamic)['date'] ?? Timestamp.now(),
        servicename: (doc.data() as dynamic)['servicename'] ?? '',
        report: (doc.data() as dynamic)['report'] ?? '',
      );
    }).toList();
  }

  Stream<List<AppointmentData>> get apt {
    final CollectionReference<Map<String, dynamic>> aptdetailsCollection =
        bookingCollection.doc(uid).collection("aptdetails");

    return aptdetailsCollection.snapshots().map(_aptListFromSnapshot);
  }
}

class ServiceDatabase {
  final String sid;

  ServiceDatabase(this.sid);
  final CollectionReference<Map<String, dynamic>> serviceCollection =
      FirebaseFirestore.instance.collection("service");

  List<ServiceData> _serviceListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ServiceData(
        serviceid: doc.id,
        details: (doc.data() as dynamic)['details'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        name: (doc.data() as dynamic)['name'] ?? '',
        number: (doc.data() as dynamic)['number'] ?? '',
        availability: (doc.data() as dynamic)['availability'] ?? [],
      );
    }).toList();
  }

  Stream<List<ServiceData>> get service {
    return serviceCollection.snapshots().map(_serviceListFromSnapshot);
  }

  ServiceData _serviceFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("service not found");
    return ServiceData(
      serviceid: snapshot.id,
      details: data['details'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      number: data['number'] ?? '',
      availability: data['availability'] ?? [],
    );
  }

//Create a SINGLE user stream
  //stream qui récupre le user courant donc
  // besoin de doc(uid)
  Stream<ServiceData> get singleservice {
    return serviceCollection.doc(sid).snapshots().map(_serviceFromSnapshot);
  }
}

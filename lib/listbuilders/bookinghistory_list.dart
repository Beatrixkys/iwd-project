import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/card.dart';
import '../models/bookingmodel.dart';

class BookingList extends StatefulWidget {
  final String uid;
  const BookingList({super.key, required this.uid});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  @override
  Widget build(BuildContext context) {
    final booking = Provider.of<List<BookingData>>(context);

    return ListView.builder(
      itemBuilder: (context, index) {
        return BookingHistoryCard(booking: booking[index], uid: widget.uid);
      },
      itemCount: booking.length,
    );
  }
}

class AptHistoryList extends StatefulWidget {
  final String uid;
  const AptHistoryList({super.key, required this.uid});

  @override
  State<AptHistoryList> createState() => _AptHistoryListState();
}

class _AptHistoryListState extends State<AptHistoryList> {
  @override
  Widget build(BuildContext context) {
    final apt = Provider.of<List<AppointmentData>>(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        return AptHistoryCard(
          apt: apt[index],uid:widget.uid, 
        );
      },
      itemCount: apt.length,
    );
  }
}

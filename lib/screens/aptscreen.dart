import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website_wireframe/components/card.dart';
import 'package:website_wireframe/listbuilders/bookinghistory_list.dart';
import 'package:website_wireframe/services/database.dart';

import '../components/buttons.dart';
import '../components/drawer.dart';
import '../components/footer.dart';
import '../components/header.dart';
import '../models/bookingmodel.dart';

class AptScreen extends StatelessWidget {
  const AptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    final controller = ScrollController();

    return MultiProvider(
      providers: [
        StreamProvider<List<BookingData>>.value(
            value: DatabaseService(uid).booking, initialData: const []),
        StreamProvider<List<AppointmentData>>.value(
            value: DatabaseService(uid).apt, initialData: const []),
      ],
      child: Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          elevation: 0.0,
          actions: const [ChangeThemeButton()],
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              StaticHeader(
                  height: MediaQuery.of(context).size.height * 0.35,
                  title: 'Appointments',
                  image: "assets/cover1.jpeg"),
              const TitleCard(title: "Upcoming Appointments"),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: BookingList(
                    uid: uid,
                  )),
              const TitleCard(title: "History of Appointments"),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AptHistoryList(
                    uid: uid,
                  )),
                  const Footer(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.chat_bubble),
        ),
      ),
    );
  }
}

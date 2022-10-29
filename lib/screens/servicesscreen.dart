import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website_wireframe/listbuilders/service_list.dart';
import 'package:website_wireframe/models/servicemodel.dart';
import 'package:website_wireframe/services/database.dart';

import '../components/buttons.dart';
import '../components/drawer.dart';
import '../components/footer.dart';
import '../components/header.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final controller = ScrollController();
    return StreamProvider<List<ServiceData>>.value(
      initialData: const [],
      value: ServiceDatabase("").service,
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
                  title: 'Select A Service!',
                  image: "assets/cover3.jpeg"),

              //Filter Tab

              //Segregate Services by Categories
              //Category Title
              //List of Services
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ServiceList(
                    uid: uid,
                  )),

                  const Footer(),

              //Footer
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

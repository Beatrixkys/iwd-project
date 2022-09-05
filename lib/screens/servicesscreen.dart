import 'package:flutter/material.dart';
import 'package:website_wireframe/listbuilders/service_list.dart';

import '../components/buttons.dart';
import '../components/drawer.dart';
import '../components/header.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return Scaffold(
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
                title: 'Service Screen',
                image: "assets/cover3.jpeg"),

            //Filter Tab

            //Segregate Services by Categories
            //Category Title
            //List of Services
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                child: const ServiceList()),

            //Footer
          ],
        ),
      ),
    );
  }
}

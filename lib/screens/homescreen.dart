import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website_wireframe/components/card.dart';
import 'package:website_wireframe/components/drawer.dart';
import 'package:website_wireframe/constant.dart';

import '../components/buttons.dart';
import '../listbuilders/service_list.dart';
import '../models/servicemodel.dart';
import '../services/database.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    final List<String> imgList = [
      'assets/cover1.jpeg',
      'assets/cover2.jpeg',
      'assets/cover3.jpeg'
    ];

    final List<String> imgTitle = [
      'Welcome Back!',
      'Make Doctor Bookings',
      'Check Appointment Histories'
    ];

    final List<Widget> imageSliders = imgList
        .map((item) => ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width),
                Center(
                  child: Text(
                    imgTitle[imgList.indexOf(item)],
                    style: kTitleCardTextStyle,
                  ),
                ),
              ],
            )))
        .toList();

    final controller = ScrollController();
    return MultiProvider(
        providers: [
          StreamProvider<List<ServiceData>>.value(
              value: ServiceDatabase("").service, initialData: const []),
        ],
        builder: (context, snapshot) {
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
                  CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.4,
                      autoPlay: true,
                      //aspectRatio: 1.0,
                      enlargeCenterPage: true,
                    ),
                    items: imageSliders,
                  ),

                  space,
                  const TitleBtnCard(),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ServiceList(uid: uid)),
                  //Big Card navigation List
                  //About Us Column
                  //Categorical Service List
                  //Footer
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.chat_bubble),
            ),
          );
        });
  }
}

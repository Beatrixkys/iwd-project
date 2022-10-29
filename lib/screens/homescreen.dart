import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website_wireframe/components/card.dart';
import 'package:website_wireframe/components/drawer.dart';
import 'package:website_wireframe/constant.dart';

import '../components/buttons.dart';
import '../components/footer.dart';
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

    final List<String> routes = ['/', '/services', '/form'];

    final List<Widget> imageSliders = imgList
        .map((item) => ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, routes[imgList.indexOf(item)]);
              },
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
              ),
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
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: const EdgeInsets.all(20),
                    child: const Center(
                        child: Text(
                      "Experiencing Symptoms? \n \nNeed A General Check?",
                      style: kTitleTextStyle,
                    )),
                  ),

                  const TitleBtnCard(),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ServiceList(uid: uid)),
                  //Big Card navigation List
                  //About Us Column

                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height,
                          child: Image.asset(
                            "hospital2.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: const [
                              Text(
                                "About Us",
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                              space,
                              Text(
                                "Lorem ipsum dolor sit amet,",
                                style: kSubTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Categorical Service List
                  //Footer

                  const Footer(),
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

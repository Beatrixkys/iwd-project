import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:website_wireframe/components/drawer.dart';
import 'package:website_wireframe/constant.dart';

import '../components/buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/cover1.jpeg',
      'assets/cover2.jpeg',
      'assets/cover3.jpeg'
    ];

    final List<String> imgTitle = [
      'Text Remark 1',
      'Text Remark 2',
      'Text Remark 3'
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
                    style: kHeadingTextStyle,
                  ),
                ),
              ],
            )))
        .toList();

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
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.4,
                autoPlay: true,
                //aspectRatio: 1.0,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),

            //Big Card navigation List
            //About Us Column
            //Categorical Service List
            //Footer
          ],
        ),
      ),
    );
  }
}

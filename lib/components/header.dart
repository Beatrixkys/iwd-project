import 'package:flutter/material.dart';

import '../constant.dart';

class MyHeader extends StatelessWidget {
  final double height;
  final Widget child;
  const MyHeader({
    Key? key,
    required this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0),
      )),
      height: height,
      width: width,
      child: child,
    );
  }
}

class StaticHeader extends StatelessWidget {
  final double height;
  final String title;
  final String image;
  const StaticHeader({
    Key? key,
    required this.height,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
      height: height,
      width: width,
      child: Center(
        child: Text(
          title,
          style: kHeadingTextStyle,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:website_wireframe/constant.dart';

class RoundText extends StatelessWidget {
  const RoundText({Key? key, required this.content}) : super(key: key);

  final String? content;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), border: Border.all()),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
          child: Text(
            content!,
            style: kTitleTextStyle,
          )),
    );
  }
}

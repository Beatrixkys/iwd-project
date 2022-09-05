import 'package:flutter/material.dart';
import 'package:website_wireframe/constant.dart';
import 'package:website_wireframe/models/usermodel.dart';

import '../models/servicemodel.dart';
import 'popup.dart';

class ServiceCard extends StatelessWidget {
  final ServiceData service;
  final MyUserData user;

  const ServiceCard({Key? key, required this.service, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: ((context) => FormPopUp(
                  service: service,
                  user: user,
                )));
      },
      child: Tooltip(
        message: "Click to Book",
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          padding: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColor,
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),

          //!TODO Change to a
          child: Column(
            children: <Widget>[
              Image.asset("assets/persona.png",
                  height: MediaQuery.of(context).size.height * 0.06),
              Text(
                service.name,
                style: kTitleTextStyle,
              ),
              Text(
                (service.number),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                (service.email),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              smallSpace,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.03,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) => AptPopUp(
                              service: service,
                              user: user,
                            )));
                  },
                  style: kButtonStyle,
                  child: const Text(
                    'Details',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

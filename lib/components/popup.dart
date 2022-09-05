import 'package:flutter/material.dart';
import 'package:website_wireframe/components/form.dart';
import 'package:website_wireframe/models/servicemodel.dart';

import '../constant.dart';
import '../models/usermodel.dart';

class AptPopUp extends StatelessWidget {
  final ServiceData service;
  final MyUserData user;

  const AptPopUp({
    Key? key,
    required this.service,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: (Text(
          service.name,
          style: kTitleTextStyle,
        )),
      ),
      content: Column(
        children: [
          Image.asset("assets/persona.png", height: 100),
          Text(
            service.email,
            style: kTitleTextStyle,
          ),
          Text(service.number),
          space,
          const Divider(
            thickness: 2.0,
          ),
          Text(service.details, style: kSubTextStyle),
          Row(
            children: [
              const Spacer(),
              FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.local_phone,
                    color: Theme.of(context).primaryColorDark,
                  )),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Icon(
                  Icons.local_post_office,
                  color: Theme.of(context).primaryColorDark,
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Close"),
        ),
      ],
    );
  }
}

class FormPopUp extends StatelessWidget {
  const FormPopUp({Key? key, required this.service, required this.user})
      : super(key: key);

  final ServiceData service;
  final MyUserData user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: (Text(
          "Book an Appointment",
          style: kTitleTextStyle,
        )),
      ),
      content: Form(
        child: Column(
          children: [
            BookingForm(user: user, service: service),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Close"),
        ),
      ],
    );
  }
}

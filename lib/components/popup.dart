import 'package:flutter/material.dart';
import 'package:website_wireframe/components/form.dart';
import 'package:website_wireframe/models/servicemodel.dart';

import '../constant.dart';
import '../models/bookingmodel.dart';

class AptPopUp extends StatelessWidget {
  final ServiceData service;

  const AptPopUp({
    Key? key,
    required this.service,
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
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Close",
            style: kTitleTextStyle,
          ),
        ),
      ],
    );
  }
}

class FormPopUp extends StatelessWidget {
  const FormPopUp({Key? key, required this.service, required this.uid})
      : super(key: key);

  final ServiceData service;
  final String uid;

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
            BookingForm(uid: uid, service: service),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Close",
            style: kTitleTextStyle,
          ),
        ),
      ],
    );
  }
}


class EditFormPopUp extends StatelessWidget {
  const EditFormPopUp({Key? key, required this.booking, required this.uid})
      : super(key: key);

  final BookingData booking;
  final String uid;

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
            EditBookingForm(uid: uid, booking: booking),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Close",
            style: kTitleTextStyle,
          ),
        ),
      ],
    );
  }
}



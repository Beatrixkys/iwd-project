import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:website_wireframe/components/round_element.dart';
import 'package:website_wireframe/components/text_field.dart';
import 'package:website_wireframe/models/usermodel.dart';
import 'package:website_wireframe/services/validator.dart';
import '../constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/servicemodel.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({
    Key? key,
    required this.user,
    required this.service,
  }) : super(key: key);

  final MyUserData user;
  final ServiceData service;

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
//Form
  final _formKey = GlobalKey<FormState>();
  final servicenameController = TextEditingController();
  //late final bookingnameController = TextEditingController(text: bookingname);
  final numberController = TextEditingController();
  final enquiryController = TextEditingController();

  final val = Validator();

  @override
  Widget build(BuildContext context) {
    DateTime? dateTime;
    String bookingname = widget.user.name;
    TextEditingController bookingnameController =
        TextEditingController(text: bookingname);

    return Form(
      key: _formKey,
      child: Column(
        children: [
//SERVICE NAME

          const Text(
            "Service to Book",
            style: kSubTextStyle,
            textAlign: TextAlign.left,
          ),
          RoundText(content: widget.service.name),
          space,

          RoundTextField(
              controller: bookingnameController,
              title: "Booking Name",
              hinttext: bookingname,
              onSaved: (String? value) {
                bookingname != value;
              },
              validator: val.nameVal),

          space,
          const Text(
            'Choose Appointment Date ',
            style: kSubTextStyle,
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton.icon(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    lastDate: DateTime(2030));

                if (newDate == null) return;

                setState(() => dateTime = newDate);
              },
              icon: const Icon(Icons.calendar_today, size: 50),
              label: Text(
                dateTime == null
                    ? 'Select Date'
                    : DateFormat('dd/MM/yyyy').format(dateTime!).toString(),
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ),

          space,

          //save button
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.1,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Timestamp aptdate = Timestamp.fromDate(dateTime!);

                  //controller.text
                }
              },
              style: kButtonStyle,
              child: const Text(
                'Submit',
                style: kButtonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({
    Key? key,
    required this.user,
  }) : super(key: key);

  final MyUserData user;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
//Form
  final _formKey = GlobalKey<FormState>();

  final enquiryController = TextEditingController();

  final val = Validator();

  @override
  Widget build(BuildContext context) {
    String name = widget.user.name;
    String email = widget.user.email;
    String number = widget.user.number;
    String enquiry = "";

    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController numberController =
        TextEditingController(text: number);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
//SERVICE NAME

//BOOKING NAME

            RoundTextField(
                controller: nameController,
                title: "Name",
                hinttext: widget.user.name,
                onSaved: (String? value) {
                  name != value;
                },
                validator: val.nameVal),
            space,
            RoundTextField(
                controller: emailController,
                title: "Email",
                hinttext: widget.user.email,
                onSaved: (String? value) {
                  email != value;
                },
                validator: val.emailVal),
            space,
            RoundTextField(
                controller: numberController,
                title: "Number",
                hinttext: widget.user.number,
                onSaved: (String? value) {
                  number != value;
                },
                validator: val.phoneVal),
            space,
            RoundTextField(
                controller: emailController,
                title: "Enquiry",
                hinttext: enquiry,
                onSaved: (String? value) {
                  enquiry != value;
                },
                validator: val.phoneVal),
            space,
            //save button
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                style: kButtonStyle,
                child: const Text(
                  'Submit',
                  style: kButtonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



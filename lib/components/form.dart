import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:website_wireframe/components/round_element.dart';
import 'package:website_wireframe/components/text_field.dart';
import 'package:website_wireframe/models/usermodel.dart';
import 'package:website_wireframe/services/database.dart';
import 'package:website_wireframe/services/validator.dart';
import '../constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bookingmodel.dart';
import '../models/servicemodel.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({
    Key? key,
    required this.uid,
    required this.service,
  }) : super(key: key);

  final String uid;
  final ServiceData service;

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
//Form
  final _formKey = GlobalKey<FormState>();

  final val = Validator();

  DateTime? dateTime;
  String time = "";

  @override
  Widget build(BuildContext context) {
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
          const Text(
            'Choose Appointment Date ',
            style: kSubTextStyle,
          ),
          datePicker(),
          Text(
            'Choose Appointment Time: $time',
            style: kSubTextStyle,
          ),
          timeList(),
          space,
          saveBtn(),
        ],
      ),
    );
  }

  Widget timeList() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor,
                border: Border.all(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      time = widget.service.availability[index];
                    });
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.amber;
                      }
                      return null;
                    }),
                  ),
                  child: Text(widget.service.availability[index],
                      style: kButtonTextStyle)),
            );
          },
          itemCount: widget.service.availability.length,
        ),
      ),
    );
  }

  Widget datePicker() {
    return Padding(
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
    );
  }

  Widget saveBtn() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.1,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Timestamp aptdate = Timestamp.fromDate(dateTime!);
            time;
            widget.service.name;

            if (time != "") {
              await DatabaseService(widget.uid).addBooking(
                  widget.service.name, widget.service.serviceid, time, aptdate);
            }

            if (!mounted) return;
            Navigator.pop(context);
          }
        },
        style: kButtonStyle,
        child: const Text(
          'Submit',
          style: kButtonTextStyle,
        ),
      ),
    );
  }
}

class EditBookingForm extends StatefulWidget {
  const EditBookingForm({
    Key? key,
    required this.uid,
    required this.booking,
  }) : super(key: key);

  final String uid;
  final BookingData booking;

  @override
  State<EditBookingForm> createState() => _EditBookingFormState();
}

class _EditBookingFormState extends State<EditBookingForm> {
//Form
  final _formKey = GlobalKey<FormState>();

  final val = Validator();

  DateTime? dateTime;
  String time = "";

  @override
  Widget build(BuildContext context) {
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
          RoundText(content: widget.booking.servicename),

          space,
          const Text(
            'Choose Appointment Date ',
            style: kSubTextStyle,
          ),
          datePicker(),
          Text(
            'Choose Appointment Time: $time',
            style: kSubTextStyle,
          ),
          timeList(),
          space,
          saveBtn(),
        ],
      ),
    );
  }

  Widget timeList() {
    return StreamBuilder<ServiceData>(
        stream: ServiceDatabase(widget.booking.serviceId).singleservice,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var serviceData = snapshot.data!;
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              time = serviceData.availability[index];
                            });
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.amber;
                              }
                              return null;
                            }),
                          ),
                          child: Text(serviceData.availability[index],
                              style: kButtonTextStyle)),
                    );
                  },
                  itemCount: serviceData.availability.length,
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget datePicker() {
    return Padding(
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
    );
  }

  Widget saveBtn() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.1,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Timestamp aptdate = Timestamp.fromDate(dateTime!);

            if (time != "") {
              time = widget.booking.time;
            }

            if (dateTime == null) {
              aptdate = widget.booking.date;
            }

            await DatabaseService(widget.uid).updateBooking(
                widget.booking.bookingId,
                widget.booking.servicename,
                time,
                aptdate);

            if (!mounted) return;
            Navigator.pop(context);
          }
        },
        style: kButtonStyle,
        child: const Text(
          'Submit',
          style: kButtonTextStyle,
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
//Form
  final _formKey = GlobalKey<FormState>();

  final enquiryController = TextEditingController();

  final val = Validator();

  @override
  void dispose() {
    enquiryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String enquiry = "";

    return StreamBuilder<MyUserData>(
        stream: DatabaseService(widget.uid).user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userData = snapshot.data!;

            TextEditingController nameController =
                TextEditingController(text: userData.name);
            TextEditingController emailController =
                TextEditingController(text: userData.email);
            TextEditingController numberController =
                TextEditingController(text: userData.number);
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RoundTextField(
                        controller: nameController,
                        title: "Name",
                        hinttext: userData.name,
                        onSaved: (String? value) {
                          userData.name != value;
                        },
                        validator: val.nameVal),
                    space,
                    RoundTextField(
                        controller: emailController,
                        title: "Email",
                        hinttext: userData.email,
                        onSaved: (String? value) {
                          userData.email != value;
                        },
                        validator: val.emailVal),
                    space,
                    RoundTextField(
                        controller: numberController,
                        title: "Number",
                        hinttext: userData.number,
                        onSaved: (String? value) {
                          userData.number != value;
                        },
                        validator: val.phoneVal),
                    space,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: TextFormField(
                        maxLines: 20,
                        decoration: InputDecoration(
                          hintText: "Insert Enquiry Here",
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Enquiry",
                        ),
                        //initialValue: hinttext,
                        onSaved: (String? value) {
                          enquiry != value;
                        },
                        controller: enquiryController,
                        validator: val.nameVal,
                      ),
                    ),
                    space,
                    //save button
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ElevatedButton(
                        onPressed: () async {
                          var enquire = enquiryController.text;
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(widget.uid).addEnquiry(
                                userData.name,
                                userData.email,
                                userData.number,
                                enquiryController.text);
                            showDialog(
                                context: context,
                                builder: ((context) => AlertDialog(
                                      title:
                                          const Text("You added an enquiry!"),
                                      content: Text(
                                          "Name: ${userData.name} \n Enquiry: $enquire "),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Close"))
                                      ],
                                    )));

                            enquiryController.clear(); 
                          }

                          //TODO! Update Enquiry Form
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
          return const Center(child: CircularProgressIndicator());
        });
  }
}

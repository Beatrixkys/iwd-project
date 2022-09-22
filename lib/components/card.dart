import 'package:flutter/material.dart';
import 'package:website_wireframe/constant.dart';
import 'package:website_wireframe/models/bookingmodel.dart';
import 'package:website_wireframe/services/database.dart';

import '../models/servicemodel.dart';
import '../services/validator.dart';
import 'popup.dart';

//Title Cards
class TitleBtnCard extends StatelessWidget {
  const TitleBtnCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Text(
            "Book A Service Today!",
            style: kTitleCardTextStyle,
          ),
          const Spacer(),
          TextButton(onPressed: () {}, child: const Text("See More"))
        ],
      ),
    );
  }
}

class TitleCard extends StatelessWidget {
  final String title;
  const TitleCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        title,
        style: kTitleCardTextStyle,
      ),
    );
  }
}

//Service Card to Book
class ServiceCard extends StatelessWidget {
  final ServiceData service;
  final String uid;

  const ServiceCard({Key? key, required this.service, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: ((context) => FormPopUp(
                  service: service,
                  uid: uid,
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

//Service History Cards

class BookingHistoryCard extends StatelessWidget {
  final String uid;
  final BookingData booking;
  const BookingHistoryCard(
      {super.key, required this.booking, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      child: Row(children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Service Name",
                style: kHeadingTextStyle,
              ),
              Text(
                booking.servicename,
                style: kTitleTextStyle,
              ),
              space,
              const Text(
                "Date",
                style: kHeadingTextStyle,
              ),
              Text(
                booking.date.toDate().toString(),
                style: kTitleTextStyle,
              ),
              space,
              const Text(
                "Time",
                style: kHeadingTextStyle,
              ),
              Text(
                booking.time,
                style: kTitleTextStyle,
              ),
            ],
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.1,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    await DatabaseService(uid)
                        .addApt(booking.servicename, booking.date);
                    await DatabaseService(uid).deleteBooking(booking.bookingId);
                  },
                  child: const Icon(Icons.check),
                ),
                FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return EditFormPopUp(booking: booking, uid: uid);
                        });
                    //!TODO show pop up to edit booking
                  },
                  child: const Icon(Icons.edit),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    await DatabaseService(uid).deleteBooking(booking.bookingId);
                  },
                  child: const Icon(Icons.delete),
                ),
              ],
            ))
      ]),
    );
  }
}

class AptHistoryCard extends StatelessWidget {
  final String uid;
  final AppointmentData apt;
  const AptHistoryCard({super.key, required this.apt, required this.uid});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String report = "";
    TextEditingController reportController =
        TextEditingController(text: report);
    final val = Validator();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      child: Row(children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Service Name:",
                style: kHeadingTextStyle,
              ),
              Text(
                apt.servicename,
                style: kTitleTextStyle,
              ),
              space,
              const Text(
                "Date",
                style: kHeadingTextStyle,
              ),
              Text(
                apt.date.toDate().toString(),
                style: kTitleTextStyle,
              ),
              space,
              const Divider(),
              const Text(
                "Results:",
                style: kHeadingTextStyle,
              ),
              Text(
                apt.report,
                style: kSubTextStyle,
              ),
            ],
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.1,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Center(
                              child: (Text(
                                "Update Report",
                                style: kTitleTextStyle,
                              )),
                            ),
                            content: Form(
                              key: formKey,
                              child: Column(children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: TextFormField(
                                    maxLines: 20,
                                    decoration: InputDecoration(
                                      hintText: "Insert Report Here",
                                      contentPadding: const EdgeInsets.all(15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelText: "Report",
                                    ),
                                    //initialValue: hinttext,
                                    onSaved: (String? value) {
                                      report != value;
                                    },
                                    controller: reportController,
                                    validator: val.nameVal,
                                  ),
                                ),
                                space,
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        var report = reportController.text;
                                        await DatabaseService(uid)
                                            .updateApt(report, apt.aptId);
                                      }

                                      Navigator.pop(context);
                                    },
                                    style: kButtonStyle,
                                    child: const Text(
                                      'Submit',
                                      style: kButtonTextStyle,
                                    ),
                                  ),
                                ),
                              ]),
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
                        });
                    //!TODO show pop up to edit booking
                  },
                  child: const Icon(Icons.edit),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.download),
                ),
              ],
            ))
      ]),
    );
  }
}

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:website_wireframe/components/form.dart';
import 'package:website_wireframe/models/servicemodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website_wireframe/services/database.dart';
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
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              FloatingActionButton(
                  onPressed: () {
                    Uri url = Uri.parse('tel:${service.number}');
                    _launchUrl(url);
                  },
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.local_phone,
                    color: Theme.of(context).primaryColorDark,
                  )),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  Uri url = Uri.parse('mailto:${service.email}');
                  _launchUrl(url);
                },
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Icon(
                  Icons.local_post_office,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
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

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
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

class UploadPopUp extends StatefulWidget {
  const UploadPopUp({Key? key, required this.apt, required this.uid})
      : super(key: key);

  final AppointmentData apt;
  final String uid;

  @override
  State<UploadPopUp> createState() => _UploadPopUpState();
}

class _UploadPopUpState extends State<UploadPopUp> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    Uint8List? file = pickedFile!.bytes;
    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTask = ref.putData(file!);

    final snapshot = await uploadTask!.whenComplete(() => null);

    final urlDownload = await snapshot.ref.getDownloadURL();

    await DatabaseService(widget.uid).uploadFile(urlDownload, widget.apt.aptId);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: (Text(
          "Upload a Report",
          style: kTitleTextStyle,
        )),
      ),
      content: Column(
        children: [
          if (pickedFile != null)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Center(child: Text(pickedFile!.name)),
            ),
          space,
          ElevatedButton(
            onPressed: () {
              selectFile();
            },
            style: kButtonStyle,
            child: const Text(
              "Select File",
              style: kButtonTextStyle,
            ),
          ),
          space,
          FloatingActionButton.large(
            onPressed: () {
              uploadFile();
            },
            child: const Icon(Icons.upload_file),
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

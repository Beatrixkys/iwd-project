import 'package:flutter/material.dart';
import 'package:website_wireframe/components/form.dart';

import '../components/buttons.dart';
import '../components/drawer.dart';
import '../components/header.dart';
import '../models/usermodel.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyUserData user = MyUserData(
      uid: "111",
      name: "Beatrix",
      email: "b@mail.com",
      number: "1234567",
    );
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
            StaticHeader(
                height: MediaQuery.of(context).size.height * 0.35,
                title: 'Enquiry Form',
                image: "assets/cover1.jpeg"),

            //Contact Form
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
              child: ContactForm(user: user),
            ),
            //Feedback
          ],
        ),
      ),
    );
  }
}

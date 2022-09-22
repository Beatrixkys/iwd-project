import 'package:flutter/material.dart';
import 'package:website_wireframe/components/loading.dart';

import '../components/text_field.dart';
import '../constant.dart';
import '../services/auth.dart';
import '../services/validator.dart';

//build the personas choice
//build the authentication screen

//toggle register or login
//admin persona

//use provider to segregate users

//To Do
/* 
1. Edit contact page for cohesiveness 
2. Add authentication functions for two different personas  
3. add Database 

*/
class RegisterLoginScreen extends StatefulWidget {
  const RegisterLoginScreen({Key? key}) : super(key: key);

  @override
  State<RegisterLoginScreen> createState() => _RegisterLoginScreenState();
}

class _RegisterLoginScreenState extends State<RegisterLoginScreen> {
  final AuthService _auth = AuthService();
  String email = "";
  String password = "";
  String name = "";
  String number = "";

  final val = Validator();

//Form
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  bool showSignIn = true;
  bool loading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState!.reset();

      emailController.text = '';
      passwordController.text = '';
      nameController.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Material(
            child: Container(
              margin: const EdgeInsets.all(80),
              padding: const EdgeInsets.all(80),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Container(
                padding: const EdgeInsets.all(30),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.2,
                color: Theme.of(context).colorScheme.secondary,
                child: Column(
                  children: [
                    Icon(
                      Icons.local_hospital,
                      size: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      showSignIn ? "Register" : "Login",
                      style: TextStyle(
                        fontSize: 40,
                        decoration: TextDecoration.none,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    space,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (showSignIn == false)
                                Column(
                                  children: [
                                    RoundTextField(
                                        controller: nameController,
                                        title: "Name",
                                        hinttext: "Name",
                                        onSaved: (String? value) {
                                          name != value;
                                        },
                                        validator: val.nameVal),
                                    space,
                                    RoundTextField(
                                        controller: numberController,
                                        title: "Number",
                                        hinttext: "Number",
                                        onSaved: (String? value) {
                                          number != value;
                                        },
                                        validator: val.phoneVal),
                                  ],
                                ),

                              space,
                              RoundTextField(
                                  controller: emailController,
                                  title: "Email",
                                  hinttext: "Email",
                                  onSaved: (String? value) {
                                    email != value;
                                  },
                                  validator: val.emailVal),
                              space,
                              RoundTextField(
                                  controller: passwordController,
                                  title: "Password",
                                  hinttext: password,
                                  onSaved: (String? value) {
                                    password != value;
                                  },
                                  validator: val.passwordVal),
                              space,
                              //save button
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => loading = true);
                                      var password =
                                          passwordController.value.text;
                                      var email = emailController.value.text;
                                      var name = nameController.value.text;
                                      var number = numberController.value.text;

                                      dynamic result = showSignIn
                                          ? await _auth
                                              .signInWithEmailAndPassword(
                                                  email, password, context)
                                          : await _auth.register(email,
                                              password, name, number, context);

                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          var error =
                                              "Please supply valid email";
                                          //TODO! Show POP UP ERROR
                                        });
                                      }

                                      if (!mounted) return;
                                      Navigator.pushNamed(context, '/home');
                                    }
                                  },
                                  style: kButtonStyle,
                                  child: const Text(
                                    'Submit',
                                    style: kButtonTextStyle,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 20.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: ElevatedButton(
                                  onPressed: () => toggleView(),
                                  style: kButtonStyle,
                                  child: Text(
                                    showSignIn ? 'Log In' : 'Register',
                                    style: kButtonTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
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

import 'package:flutter/material.dart';
import 'package:website_wireframe/models/servicemodel.dart';
import 'package:website_wireframe/models/usermodel.dart';

import '../components/card.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({Key? key}) : super(key: key);

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  MyUserData user = MyUserData(
    uid: "111",
    name: "Beatrix",
    email: "b@mail.com",
    number: "1234567",
  );
  List<ServiceData> services = [
    ServiceData(
        name: "Jason",
        number: "01304586",
        email: "j@mail.com",
        details:
            'Jason Is a Neurosurgeon, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vitae arcu in tellus elementum blandit. Nulla dictum arcu non elit semper, non blandit leo lobortis. Aliquam erat volutpat. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec ultricies vehicula elit. Morbi accumsan auctor enim ut sollicitudin. Etiam accumsan erat in lectus cursus placerat. Ut ultricies sollicitudin imperdiet. Morbi quis tortor a lacus sagittis varius. '),
    ServiceData(
        name: "Jason",
        number: "01304586",
        email: "j@mail.com",
        details: 'Jason Is a Neurosurgeon'),
    ServiceData(
        name: "Jason",
        number: "01304586",
        email: "j@mail.com",
        details: 'Jason Is a Neurosurgeon'),
    ServiceData(
        name: "Jason",
        number: "01304586",
        email: "j@mail.com",
        details: 'Jason Is a Neurosurgeon'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return ServiceCard(
          service: services[index],
          user: user,
        );
      },
      itemCount: services.length,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website_wireframe/models/servicemodel.dart';

import '../components/card.dart';

class ServiceList extends StatefulWidget {
  final String uid;
  const ServiceList({Key? key, required this.uid}) : super(key: key);

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    final services = Provider.of<List<ServiceData>>(context);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return ServiceCard(
          service: services[index],
          uid: widget.uid,
        );
      },
      itemCount: services.length,
    );
  }
}

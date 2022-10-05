import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:website_wireframe/components/card.dart';

import '../components/buttons.dart';
import '../components/drawer.dart';
import '../components/form.dart';
import '../components/header.dart';
import '../constant.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(3.0798, 101.593633253);
  final Set<Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
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
                  title: 'We are Here!',
                  image: "assets/cover1.jpeg"),
              space,
              //Location
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 18.0,
                      ),
                      myLocationEnabled: true,
                      markers: getmarkers(),
                    ),
                  ),
                  //const Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: const [
                        Text("Address:", style: kHeadingTextStyle),
                        Text(
                          "No. 1, Jalan SS12/1A,\n Ss 12, 47500\n Subang Jaya,\n Selangor",
                          style: kTitleTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //Contact Form
              const TitleCard(title: "Submit Your Enquiries Here!"),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                child: ContactForm(uid: user!.uid),
              ),

//url launcher
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 50.0),
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Icon(
                        Icons.link,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                        onPressed: () {},
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
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
              ),
            ],
          )
          //Row with Maps & Address
          //Row with Contact Methods

          //Footer

          ),
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(_center.toString()),
        position: _center, //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'We Are Here!',
          snippet: 'Subang Jaya Medical Centre',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website_wireframe/constant.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Theme.of(context).colorScheme.tertiary,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: const [
                  Text(
                    "Subang Jaya Medical Centre",
                    style: kSubTextStyle,
                  ),
                  Text("Jalan SS 12/1A 47500 Subang Jaya, Selangor, Malaysia",
                      style: kSubTextStyle),
                ],
              )),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Row(
              children: [
                FloatingActionButton(
                  heroTag: "fbbtn",
                  onPressed: () {
                    Uri url = Uri.parse(
                        'https://www.facebook.com/subangjayamedicalcentre/');
                    _launchUrl(url);
                  },
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.link,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                    heroTag: "phnbtn",
                    onPressed: () {
                      Uri url = Uri.parse('tel:+60182618027');
                      _launchUrl(url);
                    },
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Icon(
                      Icons.local_phone,
                      color: Theme.of(context).primaryColorDark,
                    )),
                const Spacer(),
                FloatingActionButton(
                  heroTag: "mlbtn",
                  onPressed: () {
                    Uri url = Uri.parse('mailto:hospital@mail.com');
                    _launchUrl(url);
                  },
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.local_post_office,
                    color: Theme.of(context).primaryColorDark,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

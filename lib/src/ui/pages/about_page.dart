// Stateless widget with centered text and two buttons.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeatureInfo {
  final String title;
  final String description;

  FeatureInfo(this.title, this.description);
}

var featureInfos = [
  FeatureInfo(
    "APOD: Astronomy Picture Of The Day",
    "One of the most popular websites at NASA is the Astronomy Picture of the Day.\n"
        "Each day a different image or photograph of our fascinating universe is featured, along with a brief explanation written by a professional astronomer.",
  ),
  FeatureInfo(
    "EPIC: Earth Polychromatic Imaging Camera",
    "The EPIC API provides information on the daily imagery collected by DSCOVR's "
    "Earth Polychromatic Imaging Camera (EPIC) instrument.\n"
    "Uniquely positioned at the"
    "Earth-Sun Lagrange point, EPIC provides full disc imagery of the Earth and"
    "captures unique perspectives of certain astronomical events.",
  ),
  FeatureInfo(
    "Search in NASA Image and Video Library",
    "API to access the NASA Image and Video Library.",
  ),
];

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildAboutSection(context),
            const Divider(height: 20),
            const Text(
              "App Features:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            for (FeatureInfo info in featureInfos)
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child:
                    getFeatureInfoWidget(context, info.title, info.description),
              ),
            // getSectionWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAboutDataText("Developed By", fontSize: 16),
          _buildLinkText("Mohammed Hashim",
              "https://www.linkedin.com/in/mohammed-hashim-25764b1b2/"),
          const SizedBox(
            height: 20,
          ),
          _buildAboutDataText("Source Code", fontSize: 16),
          _buildLinkText("Github",
              "https://github.com/mohammedhashim44/Flutter-Lyrics-App"),
        ],
      ),
    );
  }

  Widget _buildAboutDataText(String text, {double fontSize = 18}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize),
    );
  }

  Widget _buildLinkText(String text, String url) {
    return GestureDetector(
      onTap: () async {
        Uri link = Uri.parse(url);
        bool canLaunch = await canLaunchUrl(link);
        if (canLaunch) {
          launchUrl(link);
        }
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  // Helper Widget
  Widget getFeatureInfoWidget(BuildContext context, String title, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          desc,
        ),
      ],
    );
  }
}

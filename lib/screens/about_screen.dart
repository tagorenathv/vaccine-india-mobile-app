import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.info_rounded,
                  ),
                  title: Text(
                    'About',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onTap: () {
                    print("about");
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.info,
                      text:
                          'App to know Covid Vaccine Availability in India by Location and Pincode.',
                      title: 'Vaccine India',
                      animType: CoolAlertAnimType.scale,
                      backgroundColor: Colors.white,
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.help_rounded,
                  ),
                  title: Text(
                    'FAQs',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onTap: () {
                    print("FAQs");
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.share_rounded,
                  ),
                  title: Text(
                    'Refer Friend',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onTap: () {
                    print("refer friend");
                    Share.share(
                      'Hey! Do you want to Track & Notify about Covid Vaccines for FREE? Try this Indian App now!\n http://onelink.to/7rq5vx',
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.mail_rounded,
                  ),
                  title: Text(
                    'Contact Us',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onTap: () {
                    print("Contact Us");
                    _launchMailto(context,
                        'mailto:forece85@gmail.com?subject=Vaccine India&body=Hello!');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void _launchMailto(BuildContext context, String mailUrl) async {
  try {
    if (await canLaunch(mailUrl)) {
      await launch(mailUrl);
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        autoCloseDuration: Duration(seconds: 3),
        text: "Device Not supported. Unable to any Mail App.!",
      );
      print('Could not open the map.');
    }
  } on Exception catch (e) {
    print(e);
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      autoCloseDuration: Duration(seconds: 3),
      text: "Device Not supported. Unable to any Mail App.!",
    );
  } catch (error) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      autoCloseDuration: Duration(seconds: 3),
      text: "Device Not supported. Unable to any Mail App.!",
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_india/configs/color_constants.dart';
import 'package:vaccine_india/utils/url_launch_util.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("blogs")
            .orderBy('millis', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    print("Container was tapped" + e['blogUrl']);
                    UrlLaunchUtil.launchURL(e['blogUrl']);
                  },
                  child: Material(
                    // shadowColor: Color(0x802196F3),
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            border: Border.all(
                              color: ColorConstants.kmainColor,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.network(
                                e['imageUrl'],
                                loadingBuilder: (BuildContext? context,
                                    Widget? child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child!;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                e['heading'],
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              );
            }).toList(),
          );
          // return ListView(
          //   shrinkWrap: true,
          //   children: snapshot.data!.docs.map((doc) {
          //     return Card(
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Column(
          //           children: <Widget>[
          //             Image.network(
          //               doc.data()['imageUrl'],
          //               loadingBuilder: (BuildContext? context, Widget? child,
          //                   ImageChunkEvent? loadingProgress) {
          //                 if (loadingProgress == null) return child!;
          //                 return Center(
          //                   child: CircularProgressIndicator(
          //                     value: loadingProgress.expectedTotalBytes != null
          //                         ? loadingProgress.cumulativeBytesLoaded /
          //                             loadingProgress.expectedTotalBytes!
          //                         : null,
          //                   ),
          //                 );
          //               },
          //             ),
          //             Text(
          //               doc.data()['heading'],
          //               style: Theme.of(context).textTheme.headline6!.copyWith(
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //               overflow: TextOverflow.clip,
          //             ),
          //             Divider(),
          //           ],
          //         ),
          //       ),
          //     );
          //   }).toList(),
          // );
        });
  }
}

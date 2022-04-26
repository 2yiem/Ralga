import 'dart:async';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:lglaw/pages/infos/laws-category-en.dart';
import 'package:lglaw/pages/infos/laws-category-fr.dart';
import 'package:lglaw/utils/colors.dart';
import 'package:lglaw/widgets/app-icon.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DecentralizationFR extends StatefulWidget {
  const DecentralizationFR({Key? key}) : super(key: key);

  @override
  State<DecentralizationFR> createState() => _DecentralizationFRState();
}

class _DecentralizationFRState extends State<DecentralizationFR> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              height: height + 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  appDarkColor,
                  appDarkColor,
                ]),
              ), // Background
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (() => Navigator.pop(context)),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: whiteColor,
                            ),
                          ),
                          Container(
                            width: 240,
                            child: Text("Decentralization",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LawsCategoryFR()),
                                );
                              },
                              child: AppIcon(icon: Icons.arrow_forward)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            Container(), // Required some widget in between to float AppBar
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(AppBar().preferredSize.height),
        backgroundColor: whiteColor,
        body: Container(
            child: SfPdfViewer.network(
                'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')));
  }
}

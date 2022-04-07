import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lglaw/api/http_request.dart';
import 'package:lglaw/models/chapter_model.dart';
import 'package:lglaw/utils/colors.dart';
import 'package:lglaw/widgets/app-icon.dart';
import 'package:lglaw/widgets/big-text.dart';
import 'package:lglaw/widgets/expandable-text.dart';

class HomeRW extends StatefulWidget {
  const HomeRW({Key? key}) : super(key: key);

  @override
  State<HomeRW> createState() => _HomeRWState();
}

class _HomeRWState extends State<HomeRW> {
  var chapters = <Chapters>[];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    await HttpRequest().getPublicData("retrieveChapters").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        chapters = list.map((model) => Chapters.fromJson(model)).toList();

        print(list);
      });
    });
  }

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
                  appColor,
                  appColor,
                ]),
              ), // Background
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (() => Navigator.pop(context)),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: whiteColor,
                            ),
                          ),
                          Text("RALGA",
                              style: GoogleFonts.lato(
                                  color: whiteColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        AppIcon(icon: Icons.search),
                        AppIcon(icon: Icons.settings),
                      ],
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
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 1000,
                margin: EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 10),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: chapters.length,
                    itemBuilder: (context, position) {
                      return _buildShopItem(position);
                    }),
              ),
            ],
          ),
        ));
  }

  Widget _buildShopItem(int index) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 60,
            margin: EdgeInsets.only(left: 40, right: 5, top: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0XFFe8e8e8),
                      offset: Offset(0, 5),
                      blurRadius: 5)
                ]),
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ExpandableText(text: chapters[index].text),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Articles : 100",
                                  style: GoogleFonts.lato(
                                      fontSize: 15, color: Colors.black45)),
                              SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            left: 5,
            top: 0,
            bottom: 0,
            child: Container(
              height: 40,
              width: 60,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index.isEven ? greyColor : greyColor,
                border: Border.all(color: overlayWhiteColor, width: 6),
              ),
              child: Image.asset("assets/images/rwlogo.png"),
            ))
      ],
    );
  }
}

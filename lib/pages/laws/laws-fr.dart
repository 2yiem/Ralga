import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lglaw/api/http_request.dart';
import 'package:lglaw/models/chapter_model.dart';
import 'package:lglaw/utils/colors.dart';
import 'package:lglaw/widgets/app-icon.dart';

import '../../models/article_model.dart';

class LawsFR extends StatefulWidget {
  final String id, title;
  const LawsFR(this.id, this.title);

  @override
  State<LawsFR> createState() => _LawsFRState();
}

class _LawsFRState extends State<LawsFR> {
  var laws = <Article>[];

  @override
  void initState() {
    super.initState();
    _initData();

    print("id: " + widget.id.toString());
  }

  _initData() async {
    await HttpRequest()
        .getPublicData("articleRetrieveFR/" + widget.id)
        .then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        laws = list.map((model) => Article.fromJson(model)).toList();

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
                padding: EdgeInsets.only(left: 15, right: 10, top: 25),
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
                          Container(
                            width: 200,
                            child: Text(widget.title,
                                overflow: TextOverflow.visible,
                                style: GoogleFonts.lato(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w600)),
                          ),
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
              laws.isEmpty
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(
                          bottom: 10, left: 8, right: 8, top: 10),
                      child: Center(
                        child: SpinKitDoubleBounce(
                          color: appColor,
                          size: 70,
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(
                          bottom: 10, left: 8, right: 8, top: 10),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: laws.length,
                          itemBuilder: (context, position) {
                            return _buildLawsItem(position);
                          }),
                    ),
            ],
          ),
        ));
  }

  Widget _buildLawsItem(int index) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
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
              padding: EdgeInsets.only(left: 0, right: 5, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: overlayWhiteColor, width: 6),
                        ),
                        child: Image.asset("assets/images/rwlogo.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 270,
                                child: ExpandablePanel(
                                  header: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(laws[index].title, style: TextStyle(fontSize: 17, color: appDarkColor),),
                                  ),
                                  collapsed: Text(' ', softWrap: true, textAlign: TextAlign.justify, overflow: TextOverflow.ellipsis,),
                                  expanded: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(laws[index].law, softWrap: true, textAlign: TextAlign.justify),
                                  ),
                                  
                                ),
                              ),
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
      ],
    );
  }
}

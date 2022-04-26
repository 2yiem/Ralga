import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lglaw/api/http_request.dart';
import 'package:lglaw/models/category_model.dart';
import 'package:lglaw/models/chapter_model.dart';
import 'package:lglaw/pages/home-fr.dart';
import 'package:lglaw/pages/home-rw.dart';
import 'package:lglaw/utils/colors.dart';
import 'package:lglaw/widgets/app-icon.dart';
import 'package:lglaw/widgets/big-text.dart';
import 'package:lglaw/widgets/expandable-text.dart';

class CategoryFR extends StatefulWidget {
  const CategoryFR({Key? key}) : super(key: key);

  @override
  State<CategoryFR> createState() => _CategoryFRState();
}

class _CategoryFRState extends State<CategoryFR> {
  var categories = <Category>[];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    await HttpRequest().getPublicData("retrieveCategoriesFR").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        categories = list.map((model) => Category.fromJson(model)).toList();

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
                            width: 190,
                            child: Text("Sommaire",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 23),
                      child: Row(
                        children: [
                          AppIcon(icon: Icons.search),
                          AppIcon(icon: Icons.settings),
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
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
             
              categories.isEmpty ?
              Container(
                height: 600,
                margin: EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 10),
                child: Center(
                  child: SpinKitDoubleBounce(color: appColor,size: 70,),
                ), 
              ):
              Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 10),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeFR(
                                categories[position].id,
                                categories[position].title,
                              )),
                            );
                          }),
                          child: _buildCategoryItem(position));
                    }),
              ),
            ],
          ),
        ));
  }

  Widget _buildCategoryItem(int index) {
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
                          border: Border.all(color: overlayWhiteColor, width: 3),
                        ),
                        child: Image.asset("assets/images/rwlogo.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 270,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(categories[index].title , style: TextStyle(color: appDarkColor, fontSize: 20, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 4,),
                                    Text(categories[index].law_no, style: TextStyle(color: blackColor, fontSize: 18, fontWeight: FontWeight.bold),),
                                    Text(categories[index].description, textAlign: TextAlign.justify,style: TextStyle(
                                      fontSize: 15, color: Colors.black45)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                  "Articles : " +
                                      categories[index].chapters_count,
                                  style: TextStyle(
                                      fontSize: 14, color: appColor)),
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

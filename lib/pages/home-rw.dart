import 'package:accordion/accordion.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lglaw/api/http_request.dart';
import 'package:lglaw/utils/colors.dart';

class HomeRW extends StatefulWidget {
  const HomeRW({Key? key}) : super(key: key);

  @override
  State<HomeRW> createState() => _HomeRWState();
}

class _HomeRWState extends State<HomeRW> {
  var products = <Chapter>[];

  _initData() async {
    await HttpRequest()
        .getPublicData("getProductByCategoryId/" + widget.categoryId)
        .then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        products = list.map((model) => Product.fromJson(model)).toList();

      });
    });
  }
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 100),
        child: Stack(
          children: <Widget>[
            Container(
              height: height + 90,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  appColor,
                  appColor,
                ]),
              ), // Background
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (() => Navigator.pop(context)),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: whiteColor,
                      ),
                    ),
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
      body: Accordion(
        maxOpenSections: 2,
         headerBackgroundColorOpened: Colors.black54,
          headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        children: [
          AccordionSection(
                isOpen: false,
                
                header: Text('Chapter One', style: GoogleFonts.lato(fontSize: 13)),
                contentBorderColor: const Color(0xffffffff),
                headerBackgroundColorOpened: Colors.amber,
                content: Row(
                  children: [
                   Text('Chapter', style: GoogleFonts.lato(fontSize: 13)),
                  ],
                ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lglaw/pages/home-rw.dart';
import 'package:lglaw/utils/colors.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/rwanda.jpg", scale: 3),
            Text('Welcome!',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            Container(
              margin: EdgeInsets.only(left: 50, right: 50,top: 40),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("RALGA is a membership organization that brings together local government entities in Rwanda.",
                    textAlign: TextAlign.justify, style: GoogleFonts.laila(fontSize: 14),),
                  ),
                  SizedBox(height: 60,),
                  Text("Choose language"),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeRW()),
    );
                        }),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: overlayColor, width: 3),
                              ),
                              child: Image.asset("assets/images/flaguk.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("English"),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          print("cclicked");
                        }),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: overlayColor, width: 3),
                              ),
                              child: Image.asset("assets/images/flagrw.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Kinyarwanda"),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          print("cclicked");
                        }),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: overlayColor, width: 3),
                              ),
                              child: Image.asset("assets/images/flagfr.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("French"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class DecentralizationEN extends StatefulWidget {
  const DecentralizationEN({Key? key}) : super(key: key);

  @override
  State<DecentralizationEN> createState() => _DecentralizationENState();
}

class _DecentralizationENState extends State<DecentralizationEN> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SfPdfViewer.network('https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')
        )
    );
  }

}

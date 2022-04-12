// import 'package:flutter/material.dart';
//
// import 'appbar.dart';
//
// class PdfView extends StatefulWidget {
//   final String title;
//   final String url;
//
//   const PdfView({Key? key, required this.title, required this.url})
//       : super(key: key);
//
//   @override
//   _PdfViewState createState() => _PdfViewState();
// }
//
// class _PdfViewState extends State<PdfView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBarCustom(
//           title: tabbar.title,
//         ),
//         body: Center(
//           child: FutureBuilder<PDFDocument>(
//             future: PDFDocument.fromURL(tabbar.url),
//             builder: (BuildContext context, snapshot) {
//               if (snapshot.hasData) {hasData
//                 return PDFViewer(document: snapshot.data!);
//               } else {
//                 return const Text("No Data");
//               }
//             },
//           ),
//         ));
//   }
// }

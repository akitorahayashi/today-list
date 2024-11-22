// import 'package:flutter/material.dart';

// import 'package:url_launcher/url_launcher.dart';

// void launchMyUrl(
//     {required BuildContext context,
//     required String url,
//     required bool shouldUseExternalApplication}) async {
//   final Uri selectedUrl = Uri.parse(url);
//   try {
//     if (await canLaunchUrl(selectedUrl)) {
//       launchUrl(
//         selectedUrl,
//         mode: shouldUseExternalApplication
//             ? LaunchMode.externalApplication
//             : LaunchMode.inAppWebView,
//       );
//     } else {
//       showDialog(
//           // ignore: use_build_context_synchronously
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Align(
//                   alignment: Alignment.center, child: Text("申し訳ありません")),
//               content: const Align(
//                   heightFactor: 0.8,
//                   alignment: Alignment.center,
//                   child: Text("urlの問題により\n現在は使用できません")),
//               actionsAlignment: MainAxisAlignment.center,
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text("OK"))
//               ],
//             );
//           });
//     }
//   } catch (e) {
//     // ignore: avoid_print
//     print(e);
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';

// class LordThuisPage extends StatefulWidget {
//   @override
//   _LordThuisPageState createState() => _LordThuisPageState();
// }

// class _LordThuisPageState extends State<LordThuisPage> {
//   String _htmlContent = 'Loading...';

//   @override
//   void initState() {
//     super.initState();
//     _fetchLordThuisContent();
//   }

//   Future<void> _fetchLordThuisContent() async {
//     if (!mounted) return;

//     final response = await http.get(Uri.parse('https://sicweb-78c6801c0953.herokuapp.com/'));

//     if (!mounted) return;

//     if (response.statusCode == 200) {
//       setState(() {
//         _htmlContent = response.body;
//       });
//     } else {
//       setState(() {
//         _htmlContent = 'Failed to load content';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         title: const Text(
//           'Profile verification',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: WebView(
//         initialUrl: 'https://sicweb-78c6801c0953.herokuapp.com/',
//       ),
//     );
//   }
// }

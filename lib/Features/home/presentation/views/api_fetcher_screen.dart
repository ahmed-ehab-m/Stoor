// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:cookie_jar/cookie_jar.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const ApiFetcherScreen(),
//     );
//   }
// }

// class ApiFetcherScreen extends StatefulWidget {
//   const ApiFetcherScreen({super.key});

//   @override
//   State<ApiFetcherScreen> createState() => _ApiFetcherScreenState();
// }

// class _ApiFetcherScreenState extends State<ApiFetcherScreen> {
//   InAppWebViewController? _webViewController;
//   bool _isLoading = true;
//   String _response = 'Loading...';

//   Future<void> _fetchApiWithCookies(String? testCookie, String? cookie1) async {
//     Dio dio = Dio();
//     var cookieJar = CookieJar();
//     dio.interceptors.add(CookieManager(cookieJar));

//     List<Cookie> cookies = [];
//     if (testCookie != null) {
//       cookies.add(Cookie('__test', testCookie));
//     }
//     if (cookie1 != null) {
//       cookies.add(Cookie('Cookie_1', cookie1));
//     }
//     if (cookies.isNotEmpty) {
//       cookieJar.saveFromResponse(
//         Uri.parse('https://hadeer.wuaze.com'),
//         cookies,
//       );
//       print('Cookies saved: $cookies');
//     } else {
//       print('No cookies found, proceeding without cookies');
//     }

//     try {
//       Response response = await dio.get(
//         'https://hadeer.wuaze.com/api/v1/books/highest-rated',
//         queryParameters: {'i': 1},
//         options: Options(
//           headers: {
//             'Accept': 'application/json',
//             'User-Agent':
//                 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
//             'Accept-Language': 'en-US,en;q=0.9',
//           },
//           followRedirects: true,
//           maxRedirects: 5,
//         ),
//       );
//       setState(() {
//         _response = response.data.toString();
//         _isLoading = false;
//       });
//       print('Response: ${response.data}');
//     } catch (e) {
//       setState(() {
//         _response = 'Dio error: $e';
//         _isLoading = false;
//       });
//       print('Dio error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Fetch API')),
//       body: Stack(
//         children: [
//           Center(
//             child: _isLoading
//                 ? const CircularProgressIndicator()
//                 : SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(_response),
//                     ),
//                   ),
//           ),
//           // الـ WebView مخفي
//           Visibility(
//             visible: false,
//             child: SizedBox(
//               height: 1,
//               width: 1,
//               child: InAppWebView(
//                 initialUrlRequest: URLRequest(
//                   url: WebUri('https://hadeer.wuaze.com/api/v1/books/highest-rated?i=1'),
//                 ),
//                 initialOptions: InAppWebViewGroupOptions(
//                   crossPlatform: InAppWebViewOptions(
//                     javaScriptEnabled: true,
//                     userAgent:
//                         'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
//                   ),
//                 ),
//                 onWebViewCreated: (controller) {
//                   _webViewController = controller;
//                 },
//                 onLoadStop: (controller, url) async {
//                   print('Page finished loading: $url');
//                   final cookieManager = CookieManager.instance();
//                   final cookies = await cookieManager.getCookies(
//                     url: WebUri('https://hadeer.wuaze.com'),
//                   );

//                   String? testCookie;
//                   String? cookie1;
//                   for (var cookie in cookies) {
//                     print('Cookie: ${cookie.name}=${cookie.value}');
//                     if (cookie.name == '__test') {
//                       testCookie = cookie.value;
//                     } else if (cookie.name == 'Cookie_1') {
//                       cookie1 = cookie.value;
//                     }
//                   }

//                   print('__test: $testCookie, Cookie_1: $cookie1');
//                   await _fetchApiWithCookies(testCookie, cookie1);
//                 },
//                 onReceivedError: (controller, request, error) {
//                   print('WebView error: ${error.description}');
//                   setState(() {
//                     _response = 'WebView error: ${error.description}';
//                     _isLoading = false;
//                   });
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

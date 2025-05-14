// // lib/views/cookie_fetcher_view.dart
// import 'package:bookly_app/core/utils/cookie_service.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:io';

// class CookieFetcherView extends StatefulWidget {
//   const CookieFetcherView({super.key});

//   @override
//   State<CookieFetcherView> createState() => _CookieFetcherViewState();
// }

// class _CookieFetcherViewState extends State<CookieFetcherView> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(NavigationDelegate(
//         onPageFinished: (url) async {
//           final cookieManager = WebViewCookieManager();
//           final cookies = await cookieManager.getCookies(url);
//           for (var cookie in cookies) {
//             if (cookie.name == '__test') {
//               CookieService.setCookie(cookie.value);
//               Navigator.pop(context); // نرجع بعد ما نحفظ الكوكي
//             }
//           }
//         },
//       ))
//       ..loadRequest(Uri.parse('https://hadeer.wuaze.com/api/v1/books?i=1'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('جلب الكوكي')),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }

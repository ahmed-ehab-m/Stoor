// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:convert';

// class ApiWebView extends StatefulWidget {
//   @override
//   _ApiWebViewState createState() => _ApiWebViewState();
// }

// class _ApiWebViewState extends State<ApiWebView> {
//   late WebViewController controller;
//   String apiData = '';
  
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (String url) async {
//             print('Page finished loading: $url');
            
//             // استنى شوية عشان الصفحة تخلص تحميل تماماً
//             await Future.delayed(Duration(seconds: 3));
            
//             try {
//               // جرب تجيب الـ content
//               final Object? result = await controller.runJavaScript(
//                 'document.body.innerText || document.body.textContent'
//               );
              
//               if (result != null) {
//                 String content = result.toString();
//                 print('Raw Content: $content');
                
//                 // شوف لو الكونتنت ده JSON
//                 if (content.trim().startsWith('[') || content.trim().startsWith('{')) {
//                   setState(() {
//                     apiData = content;
//                   });
                  
//                   // جرب تعمل parse للـ JSON
//                   try {
//                     var jsonData = jsonDecode(content);
//                     print('Parsed JSON: $jsonData');
//                     // هنا تقدر تشتغل بالداتا
//                   } catch (e) {
//                     print('JSON Parse Error: $e');
//                   }
//                 } else {
//                   print('Content is not JSON: $content');
//                 }
//               }
//             } catch (e) {
//               print('JavaScript execution error: $e');
//             }
//           },
//           onWebResourceError: (error) {
//             print('Web resource error: ${error.description}');
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://hadeer.wuaze.com/api/v1/books/lowest-rated?i=1'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('API Data Fetcher'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               controller.reload();
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               color: Colors.grey[200],
//               padding: EdgeInsets.all(8),
//               child: SingleChildScrollView(
//                 child: Text(
//                   apiData.isEmpty ? 'Loading API data...' : apiData,
//                   style: TextStyle(fontSize: 12),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: WebViewWidget(controller: controller),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // أو لو عايز function منفصلة تجيب الداتا
// Future<String?> fetchApiDataUsingWebView(String url) async {
//   final WebViewController controller = WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted);
  
//   // Load the URL
//   await controller.loadRequest(Uri.parse(url));
  
//   // Wait for page to load
//   await Future.delayed(Duration(seconds: 5));
  
//   try {
//     final Object? result = await controller.runJavaScript(
//       'document.body.innerText || document.body.textContent'
//     );
    
//     if (result != null) {
//       String content = result.toString();
//       if (content.trim().startsWith('[') || content.trim().startsWith('{')) {
//         return content;
//       }
//     }
//   } catch (e) {
//     print('Error getting content: $e');
//   }
  
//   return null;
// }

// // استخدام الfunction
// void testFetchData() async {
//   String? data = await fetchApiDataUsingWebView(
//     'https://hadeer.wuaze.com/api/v1/books/lowest-rated?i=1'
//   );
  
//   if (data != null) {
//     try {
//       var jsonData = jsonDecode(data);
//       print('Success: $jsonData');
//     } catch (e) {
//       print('JSON parse error: $e');
//     }
//   } else {
//     print('Failed to fetch data');
//   }
// }
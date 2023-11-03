// import 'package:flutter/material.dart';

// class WebViewContainer extends StatefulWidget {
//   final url;
//   Widget? bottomWid;

//   WebViewContainer(this.url, {this.bottomWid});

//   @override
//   createState() => _WebViewContainerState(this.url);
// }

// class _WebViewContainerState extends State<WebViewContainer> {
//   var _url;
//   final _key = UniqueKey();

//   _WebViewContainerState(this._url);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 15),
//       child: Column(
//         children: [
//           // Expanded(
//           //     child: WebviewScaffold(
//           //   url: _url,
//           //   withZoom: true,
//           //   scrollBar: true,
//           //   withJavascript: true,
//           //   useWideViewPort: true,
//           // )),
//           // widget.bottomWid != null ? widget.bottomWid : SizedBox.shrink(),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:viettel_app/config/theme/assets-constant.dart';
// import 'package:viettel_app/config/theme/style-constant.dart';
// import 'package:viettel_app/src/camera_search/camera_search_page.dart';
// import 'package:viettel_app/src/camera_search/components/take_picture_screen.dart';
// import 'package:viettel_app/src/home/nagivator_bottom_page.dart';
//
// import 'bottomnavybar_item.dart';
// import 'container_paint.dart';
//
// class CustomAnimatedBottomBar extends StatelessWidget {
//   CustomAnimatedBottomBar({
//     Key? key,
//     this.selectedIndex = 0,
//     this.showElevation = true,
//     this.iconSize = 24,
//     this.backgroundColor,
//     this.itemCornerRadius = 50,
//     this.containerHeight = 56,
//     this.animationDuration = const Duration(milliseconds: 270),
//     this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
//     required this.items,
//     required this.onItemSelected,
//     this.curve = Curves.linear,
//   })  : assert(items.length >= 2 && items.length <= 5),
//         super(key: key);
//
//   final int selectedIndex;
//   final double iconSize;
//   final Color? backgroundColor;
//   final bool showElevation;
//   final Duration animationDuration;
//   final List<BottomNavyBarItem> items;
//   final ValueChanged<int> onItemSelected;
//   final MainAxisAlignment mainAxisAlignment;
//   final double itemCornerRadius;
//   final double containerHeight;
//   final Curve curve;
//
//   int indexDefault = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;
//
//     return CustomPaint(
//       painter: ContainerPaint(),
//       child: Container(
//         width: double.infinity,
//         height: containerHeight,
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Row(
//           mainAxisAlignment: mainAxisAlignment,
//           children: List.generate(items.length + 1, (index) {
//             if (index == items.length / 2) {
//               indexDefault = 1;
//               return GestureDetector(
//                 onTap: () {
//                  Get.to(CameraSearchPage());
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 50),
//                   child: Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(100),
//                       boxShadow: <BoxShadow>[
//                         BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 10.0,
//                             offset: Offset(0.0, 0.75))
//                       ],
//                     ),
//                     padding: EdgeInsets.all(3),
//                     child: Container(
//                       width: 57,
//                       height: 57,
//                       decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(100)),
//                       child: Center(
//                           child: ImageIcon(
//                         AssetImage(AssetsConst.iconCamera),
//                         size: 60,
//                         color: Colors.white,
//                       )),
//                     ),
//                   ),
//                 ),
//               );
//             }
//
//             return Expanded(
//               child: GestureDetector(
//                 onTap: () =>
//                     onItemSelected(index >= 2 ? (index - indexDefault) : index),
//                 child: Padding(
//                   padding: EdgeInsets.only(top: containerHeight - 69),
//                   child: _ItemWidget(
//                     item: items.elementAt(index - indexDefault),
//                     iconSize: iconSize,
//                     isSelected: (index - indexDefault) == selectedIndex,
//                     backgroundColor: bgColor,
//                     itemCornerRadius: itemCornerRadius,
//                     animationDuration: animationDuration,
//                     curve: curve,
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
//
// class _ItemWidget extends StatelessWidget {
//   final double iconSize;
//   final bool isSelected;
//   final BottomNavyBarItem item;
//   final Color backgroundColor;
//   final double itemCornerRadius;
//   final Duration animationDuration;
//   final Curve curve;
//
//   // final ValueChanged<int> onItemSelected;
//   // final int index;
//   // final double containerHeight;
//
//   const _ItemWidget({
//     Key? key,
//     required this.item,
//     required this.isSelected,
//     required this.backgroundColor,
//     required this.animationDuration,
//     required this.itemCornerRadius,
//     required this.iconSize,
//     // required this.onItemSelected,
//     // required this.index,
//     // required this.containerHeight,
//     this.curve = Curves.linear,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Semantics(
//       container: true,
//       selected: isSelected,
//       child: Container(
//         // width: MediaQuery.of(context).size.width / 5,
//         // padding: EdgeInsets.symmetric(horizontal: 8),
//         color: Colors.transparent,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             IconTheme(
//               data: IconThemeData(
//                 size: iconSize,
//                 color: isSelected
//                     ? item.activeColor.withOpacity(1)
//                     : item.inactiveColor == null
//                         ? item.activeColor
//                         : item.inactiveColor,
//               ),
//               child: item.icon,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 4),
//                 child: DefaultTextStyle.merge(
//                   style: StyleConst.regularStyle(
//                       color: isSelected ? item.activeColor : item.inactiveColor,
//                       fontSize: 12),
//                   textAlign: item.textAlign,
//                   child: item.title,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

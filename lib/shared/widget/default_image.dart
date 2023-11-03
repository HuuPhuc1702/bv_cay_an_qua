import 'package:flutter/material.dart';


class DefaultImage extends StatelessWidget {
  const DefaultImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
         "assets/images/app_logo.png",width: 60,
        height: 60,
        fit: BoxFit.fitHeight,);
  }
}

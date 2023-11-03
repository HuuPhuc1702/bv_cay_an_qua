import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../export.dart';

class WidgetHtml extends  StatefulWidget {
  String? content;
   WidgetHtml({Key? key, this.content}) : super(key: key);

  @override
  _WidgetHtmlState createState() => _WidgetHtmlState();
}

class _WidgetHtmlState extends State<WidgetHtml> {

  double fontSlider = defaultSize;


  @override
  Widget build(BuildContext context) {

    Widget html = Html(
      data: """
          ${widget.content??""}
          """,
      style: {
        "body": Style(
          fontSize: FontSize(fontSlider),
        )
      },
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: html,
          ),
          Positioned(
              bottom: 10,
              left: 50.0,
              right: 50.0,
              height: 100,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0))),
                  child: Row(children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (fontSlider > defaultSize + ((supTitleSize - defaultSize) / 5)) {
                          setState(() {
                            fontSlider = fontSlider -
                                ((supTitleSize - defaultSize) / 5);
                          });
                        }
                      },
                      child: Icon(Icons.zoom_out,
                          size: 30,
                          color: ColorConst.textPrimary),
                    ),
                    Expanded(
                      child: Slider(
                          divisions: 5,
                          min: defaultSize,
                          max: supTitleSize,
                          value: fontSlider,
                          inactiveColor: ColorConst.grey,
                          activeColor: ColorConst.primaryColor,
                          onChanged: (v) {
                            setState(() {
                              fontSlider = v;
                            });
                            // _htmlFontBehavior.sink.add(fontSlider);
                          }),
                    ),
                    GestureDetector(
                      onTap: () {
                        print(fontSlider);
                        if (fontSlider < supTitleSize - ((supTitleSize - defaultSize) / 5)) {
                          setState(() {
                            fontSlider = fontSlider +
                                ((supTitleSize - defaultSize) / 5);
                          });
                          // _htmlFontBehavior.sink.add(fontSlider + 5);
                        }
                      },
                      child: Icon(Icons.zoom_in,
                          size: 30,
                          color: ColorConst.textPrimary),
                    ),
                  ])))
        ],
      ),
    );
  }
}

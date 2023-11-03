import 'package:bv_cay_an_qua/page/issue/input_issue_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../export.dart';

class WidgetAppbar extends StatefulWidget {
  final String title;
  final Widget? widgetIcons;
  final Function? callBack;
  final Function(String)? onChangeSearch;
  TextEditingController? textEditingController;
  final bool turnOnSendIssue;
  final bool showWidgetIcons;
  final dynamic functionTag;

  WidgetAppbar({
    Key? key,
    required this.title,
    this.onChangeSearch,
    this.textEditingController,
    this.widgetIcons,
    this.callBack,
    this.functionTag,
    this.turnOnSendIssue = true,
    this.showWidgetIcons = true,
  }) : super(key: key);

  @override
  _WidgetAppbarState createState() => _WidgetAppbarState();
}

class _WidgetAppbarState extends State<WidgetAppbar> {
  bool showSearch = false;

  final _searchChangeBehavior = PublishSubject<String>();

  Widget? widgetSearch;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchChangeBehavior.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.textEditingController == null)
      widget.textEditingController = TextEditingController();
    _searchChangeBehavior
        .debounceTime(Duration(milliseconds: 500))
        .listen((queryString) {
      widget.onChangeSearch?.call(queryString);
    });
    widgetSearch = Row(
      children: [
        GestureDetector(
          onTap: () {
            widget.textEditingController?.clear();
            widget.onChangeSearch?.call("");
            setState(() {
              showSearch = !showSearch;
            });
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 2, bottom: 2, right: 5),
            child: Icon(
              Icons.arrow_back_ios,
              size: titleSize * 1.5,
              color: ColorConst.textPrimary,
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: widget.textEditingController,
            style: StyleConst.mediumStyle(),
            cursorColor: ColorConst.primaryColor,
            onChanged: _searchChangeBehavior.sink.add,
            decoration: InputDecoration(
              hintText: "Tìm kiếm...",
              isDense: true,
              hintStyle: StyleConst.mediumStyle(),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 2, bottom: 2, right: 10),
          child: StreamBuilder<String>(
            stream: _searchChangeBehavior.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData == false || (snapshot.data?.isEmpty ?? true))
                return SizedBox();
              return GestureDetector(
                onTap: () {
                  _searchChangeBehavior.sink.add('');
                  widget.textEditingController?.clear();
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                  size: titleSize * 1.5,
                ),
              );
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _widgetTitle = Text('${widget.title}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:
            StyleConst.boldStyle(color: ColorConst.red, fontSize: titleSize));

    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: kToolbarHeight + MediaQuery.of(context).padding.top + 10,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: ColorConst.primaryColor, width: 8))),
      child: Row(
        children: [
          Visibility(
            visible: showSearch == false,
            child: GestureDetector(
              onTap: () {
                if (widget.callBack == null)
                  Navigator.pop(context);
                else {
                  widget.callBack?.call();
                }
              },
              child: Padding(
                padding:
                    EdgeInsets.only(left: 16, bottom: 14, top: 14, right: 16),
                child: Image.asset(
                  AssetsConst.iconBack,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
              child: Center(
                  child: showSearch && widget.onChangeSearch != null
                      ? widgetSearch
                      : _widgetTitle)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Visibility(
                  visible: widget.onChangeSearch != null && showSearch == false,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showSearch = !showSearch;
                        });
                      },
                      child: Image(
                        image: AssetImage("assets/icons/icon_search.png"),
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                widget.showWidgetIcons == true && widget.widgetIcons != null
                    ? widget.widgetIcons!
                    : SizedBox(),
                Visibility(
                  visible: widget.turnOnSendIssue,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(InputIssuePage(
                        tag: widget.functionTag,
                      ));
                    },
                    child: Image.asset(
                      "assets/images/question.png",
                      width: 56,
                      height: 56,
                    ),
                  ),
                ),
                // Visibility(
                //     visible: /*widget.turnOnSendIssue == false &&*/
                //         widget.showWidgetIcons == false,
                //     child: Opacity(
                //       opacity: 0.0,
                //       child: widget.widgetIcons,
                //     ))
              ],
            ),
          ),
        ],
      ),
    );
  }

// @override
// Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);
}

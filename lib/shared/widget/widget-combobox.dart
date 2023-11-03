import 'package:flutter/material.dart';
import '../../export.dart';

class WidgetComboBox extends StatefulWidget {
  FormComboBox? itemSelected;
  final List<FormComboBox> listData;
  final Function(FormComboBox) onSelected;
  final String? hintText;
  bool turnOffValidate;

  WidgetComboBox(
      {Key? key,
      this.itemSelected,
      this.hintText,
      required this.listData,
        required this.onSelected,
        this.turnOffValidate = false})
      : super(key: key);

  @override
  _WidgetComboBoxState createState() => _WidgetComboBoxState();
}

class _WidgetComboBoxState extends State<WidgetComboBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.listData.length);

    Color colorBorder = ColorConst.borderInputColor;
    if (widget.itemSelected == null && widget.turnOffValidate == false) {
      colorBorder = Colors.red;
    }

    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        // if (widget.listData.length > 0) {
        await showDialogCustom(
            context: context,
            showButtonClose: true,
            title: Text(
              "${widget.hintText}",
              style: StyleConst.boldStyle(fontSize: titleSize),
            ),
            childBody: Container(
                margin: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.listData.map((FormComboBox item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            widget.onSelected.call(item);
                            setState(() {
                              widget.itemSelected = item;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                item.title,
                                style: StyleConst.mediumStyle(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )));
        // }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 52,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: colorBorder),
            borderRadius: BorderRadius.circular(6)),
        // width: double.infinity,
        child: Row(
          children: [
            Expanded(
                child: widget.itemSelected != null
                    ? Text(
                        widget.itemSelected?.title ?? "",
                        style: StyleConst.mediumStyle(),
                      )
                    : Text(
                        widget.hintText ?? "chọn",
                        style: StyleConst.mediumStyle(color: ColorConst.grey),
                      )),
            Icon(
              Icons.arrow_drop_down,
              color: ColorConst.grey,
            )
          ],
        ),
      ),
    );
  }
}

class FormComboBox {
  final String title;
  final dynamic key;
  final String id;
  final Function? callBack;

  FormComboBox(
      {required this.title,
      required this.key,
      required this.id,
      this.callBack});
}

showDialogCustom(
    {Widget? childBody,
    Widget? title,
    required BuildContext context,
    bool? showButtonClose}) {
  return showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        content: CustomDialogBox(
          showButtonClose: showButtonClose ?? false,
          child: childBody,
          title: title,
        )),
  );
}

class Constants {
  Constants._();

  static const double padding = 15;
  static const double avatarRadius = 45;
}

class CustomDialogBox extends StatelessWidget {
  final Widget? child;
  final Widget? title;
  final bool showButtonClose;

  const CustomDialogBox(
      {Key? key, this.child, this.title, this.showButtonClose = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          Visibility(
            visible: showButtonClose,
            child: Row(
              children: [
                Expanded(child: title ?? SizedBox()),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.clear)),
              ],
            ),
          ),
          child ?? SizedBox()
        ],
      ),
    ]);
  }
}

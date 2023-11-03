import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../export.dart';

class WidgetOTPInput extends StatefulWidget {
  final int length;
  final TextStyle? textStyle;
  final Color? cursorColor;
  final BuildContext appContext;
  final Function(String)? onSubmit;
  final Function(String)? onChange;

  const WidgetOTPInput({
    Key? key,
    required this.length,
    required this.appContext,
    this.textStyle,
    this.cursorColor,
    this.onSubmit,
    this.onChange,
  }) : super(key: key);

  @override
  _WidgetOTPInputState createState() => _WidgetOTPInputState();
}

class _WidgetOTPInputState extends State<WidgetOTPInput>
    with TickerProviderStateMixin {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode? _focusNode;
  late AnimationController _cursorController;
  late Animation<double> _cursorAnimation;
  int _selectedIndex = 0;
  List<String> _inputList = [];

  TextStyle get _textStyle => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ).merge(widget.textStyle);

  @override
  void initState() {
    // TODO: implement initState
    _focusNode = FocusNode();
    _focusNode!.addListener(() {
      if (_focusNode!.hasFocus) {
        _cursorController.repeat();
      }
      // else{
      //   _cursorController.stop();
      // }

      setState(() {});
    }); // Rebuilds on every change to reflect the correct color on each field.

    _cursorController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _cursorAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _cursorController,
      curve: Curves.easeIn,
    ));
    _textEditingController.addListener(() {
      // print(" _textEditingController: ${_textEditingController.text}");
      var currentText = _textEditingController.text;
      if (currentText.length == widget.length) {
        widget.onSubmit?.call(currentText);
      }
      widget.onChange?.call(currentText);
      _setTextToInput(currentText);
    });
    _setTextToInput("");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cursorController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          textField(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _onFocus();
              },
              onLongPress: () async {
                var data = await Clipboard.getData("text/plain");
                print("onLongPress----${data?.text}");

                if (data?.text != null && data!.text!.isNotEmpty) {
                  _showPasteDialog(data.text ?? "");
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: listItemNumberView(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> listItemNumberView() {
    List<Widget> listWidget = [];

    for (int i = 0; i < widget.length; i++) {
      listWidget.add(Expanded(child: buildChild(i)));
    }

    return listWidget;
  }

  Widget buildChild(int index) {
    final cursorHeight = _textStyle.fontSize!;
    // print("$_selectedIndex - $index");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          _inputList[index].isNotEmpty
              ? Text(
                  "${_inputList[index]}",
                  style: _textStyle,
                )
              : (_textEditingController.text.length >= index &&
                      _focusNode!.hasFocus == true)
                  ? FadeTransition(
                      opacity: _cursorAnimation,
                      child: CustomPaint(
                        size: Size(0, cursorHeight),
                        painter: CursorPainter(
                          cursorColor:
                              widget.cursorColor ?? ColorConst.textPrimary,
                          cursorWidth: 2,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: cursorHeight,
                    ),
          Container(
            margin: EdgeInsets.only(top: cursorHeight / 2),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: index == _selectedIndex && _focusNode!.hasFocus == true
                  ? ColorConst.primaryColor
                  : Colors.black,
                      width: 2
            ))),
          )
        ],
      ),
    );
  }

  void _onFocus() {
    if (_focusNode!.hasFocus &&
        MediaQuery.of(widget.appContext).viewInsets.bottom == 0) {
      _focusNode!.unfocus();
      Future.delayed(
          const Duration(microseconds: 1), () => _focusNode!.requestFocus());
    } else {
      print("_onFocus");
      _focusNode!.requestFocus();
    }
  }

  void _setTextToInput(String data) async {
    var replaceInputList = List<String>.filled(widget.length, "");
    for (int i = 0; i < widget.length; i++) {
      replaceInputList[i] = data.length > i ? data[i] : "";
    }

    if (mounted)
      setState(() {
        _selectedIndex = data.length;
        _inputList = replaceInputList;
      });
  }

  Widget textField() {
    return TextFormField(
      controller: _textEditingController,
      focusNode: _focusNode,

      autofocus: false,
      autocorrect: false,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        ...const <TextInputFormatter>[],
        LengthLimitingTextInputFormatter(
          widget.length,
        ), // this limits the input length
      ],
      // trigger on the complete event handler from the keyboard
      enableInteractiveSelection: false,
      showCursor: false,
      // using same as background color so tha it can blend into the view
      cursorWidth: 0.01,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        border: InputBorder.none,
        fillColor: Colors.transparent,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      style: TextStyle(
        color: Colors.transparent,
        height: .01,
        fontSize:
            0.01, // it is a hidden textfield which should remain transparent and extremely small
      ),
    );
  }

  Future<void> _showPasteDialog(String pastedText) {
    final formattedPastedText = pastedText
        .trim()
        .substring(0, min(pastedText.trim().length, widget.length));

    final defaultPastedTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).accentColor,
    );

    return showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: RichText(
          text: TextSpan(
            text: "Mã OTP của bạn là ",
            style: StyleConst.regularStyle(),
            children: [
              TextSpan(
                text: formattedPastedText,
                style: StyleConst.boldStyle(color: ColorConst.primaryColor),
              ),
              TextSpan(
                text: " đúng không ?",
                style: StyleConst.regularStyle(),
              )
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: WidgetButton(
                  text: "Không",
                  backgroundColor: Colors.white,
                  radiusColor: ColorConst.borderInputColor,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: WidgetButton(
                  text: "Đúng",
                  textColor: Colors.white,
                  onTap: () {
                    _textEditingController.clear();
                    _textEditingController.text = formattedPastedText;
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CursorPainter extends CustomPainter {
  final Color cursorColor;
  final double cursorWidth;

  CursorPainter({this.cursorColor = Colors.black, this.cursorWidth = 2});

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(0, 0);
    final p2 = Offset(0, size.height);
    final paint = Paint()
      ..color = cursorColor
      ..strokeWidth = cursorWidth;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

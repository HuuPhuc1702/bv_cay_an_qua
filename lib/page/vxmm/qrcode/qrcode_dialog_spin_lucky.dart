import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:bv_cay_an_qua/constants/constants.dart';

class QrcodeDialogSpinLucky extends StatefulWidget {
  final String? url;

  const QrcodeDialogSpinLucky({Key? key, this.url}) : super(key: key);

  @override
  _QrcodeDialogSpinLuckyState createState() => _QrcodeDialogSpinLuckyState();
}

class _QrcodeDialogSpinLuckyState extends State<QrcodeDialogSpinLucky> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetImageNetWork(
                  url: widget.url ?? "",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.5,
                ),
                SizedBox(
                  height: 90,
                )
              ],
            ),
          ),
        ),
        // Image.asset(
        //   "assets/gif/animation_vxmm3.gif",
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   fit: BoxFit.cover,
        // ),
        Image.asset(
          "assets/gif/animation_vxmm.gif",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
              ),
              GestureDetector(
                onTap: () {
                  // print("xxxxx");
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 80),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),

                  child: Image.asset(
                    "assets/icons/close.png",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),

                  // Text(
                  //   "Đóng",
                  //   // style: ptButton(context)
                  //   //     .copyWith(color: Colors.white, fontSize: 16),
                  // ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:bv_cay_an_qua/models/issue/attachment_model.dart';
import 'package:bv_cay_an_qua/page/components/widget_video.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:flutter/material.dart';

import '../../../export.dart';

enum TypeAttachment { audio, video }

class WidgetFileAttachment extends StatefulWidget {
  AttachmentModel? attachmentModel;
  TypeAttachment type;

  WidgetFileAttachment({Key? key, this.attachmentModel, required this.type})
      : super(key: key);

  @override
  _WidgetFileAttachmentState createState() => _WidgetFileAttachmentState();
}

class _WidgetFileAttachmentState extends State<WidgetFileAttachment> {
  AudioPlayer audioPlayer = AudioPlayer();
  // FlutterSound flutterSound = new FlutterSound();

  bool isStart = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        isStart = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //   return  Container(
    //     width: 64,
    //     height: 64,
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.all(
    //             Radius.circular(8.0)),
    //         border: Border.all(
    //             width: 3,
    //             color: ColorConst
    //                 .borderInputColor)),
    //     child: SizedBox(
    //       height: 20,
    //       width: 20,
    //       child: CircularProgressIndicator(
    //         strokeWidth: 1.0,
    //         valueColor:
    //         AlwaysStoppedAnimation<Color>(ColorConst.primaryColor),
    //       ),
    //     ),
    //   );
    if (widget.attachmentModel?.downloadUrl == null) return SizedBox();
    if (widget.type == TypeAttachment.video) {
      return WidgetVideo(
        url: widget.attachmentModel?.downloadUrl ?? "",
        size: 64,
        isRemove: false,
      );
    }
    return Row(
      children: [
        Expanded(
            child: Text(
          "${widget.attachmentModel?.name?.toString().split("/").last ?? "Chưa có tập tin ghi âm"}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: StyleConst.regularStyle(),
        )),
        GestureDetector(
            onTap: () async {
              if (isStart) {
                // await flutterSound.thePlayer.startPlayer(
                //     fromURI: widget.attachmentModel?.downloadUrl);
                // flutterSound.thePlayer.onProgress?.listen((e) {
                //   print("xxx");
                // });
                printLog(widget.attachmentModel?.downloadUrl);

                await audioPlayer.play(
                    widget.attachmentModel?.downloadUrl ?? "",
                    isLocal: false);
              } else {
                await audioPlayer.stop();
                // await flutterSound.thePlayer.stopPlayer();
              }
              setState(() {
                isStart = !isStart;
              });
            },
            child: Icon(
              isStart ? Icons.not_started_outlined : Icons.stop_circle_outlined,
              color: isStart ? ColorConst.primaryColor : Colors.red,
            )),
      ],
    );
  }
}

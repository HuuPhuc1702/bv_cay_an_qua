import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/issue/comment_model.dart';
import 'package:bv_cay_an_qua/repositories/issue_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class itemComment extends StatefulWidget {
  final BuildContext context;
  final String content;
  final CommentModel? commentModel;

  const itemComment(
      {Key? key,
      required this.content,
      required this.context,
      this.commentModel})
      : super(key: key);

  @override
  _itemCommentState createState() => _itemCommentState();
}

class _itemCommentState extends State<itemComment> {
  bool _isExpanded = false;
  static const defaultLines = 3;

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final span = TextSpan(
          text: widget.content.trim(), style: StyleConst.regularStyle());
      final tp = TextPainter(
          text: span, textDirection: TextDirection.ltr, maxLines: defaultLines);
      tp.layout(maxWidth: size.maxWidth);
      if (tp.didExceedMaxLines) {
        return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: GestureDetector(
                onTap: () {
                  if (widget.commentModel != null && _isExpanded == false) {
                    issueRepository.countComment(
                        commentId: widget.commentModel!.id!);
                    widget.commentModel!.viewCount =
                        (widget.commentModel?.viewCount ?? 0) + 10;
                  }
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.content.trim(),
                      style: StyleConst.regularStyle(color: Colors.grey),
                      maxLines: _isExpanded ? null : defaultLines,
                      // textAlign: TextAlign.justify,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _isExpanded ? 'Thu gọn' : "Xem thêm",
                            style: StyleConst.regularStyle(
                                color: ColorConst.primaryColor),
                          ),
                        ),
                        Visibility(
                          visible: appConfig.appType == AppType.DOCTOR,
                          child: GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                        new ClipboardData(text: widget.content))
                                    .then((_) {
                                  showSnackBar(
                                      title: "Sao chép thành công",
                                      body: "${widget.content}");
                                });
                              },
                              child: Icon(
                                Icons.copy,
                                color: Colors.grey,
                                size: titleSize,
                              )),
                        )
                      ],
                    ),
                    Visibility(
                      visible: widget.commentModel != null,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.remove_red_eye_outlined,
                              color: ColorConst.grey,
                            ),
                          ),
                          Text(
                            '${widget.commentModel?.viewCount ?? 0} lượt xem',
                            style:
                                StyleConst.regularStyle(color: ColorConst.grey),
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  ],
                )));
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.content.trim(),
                textAlign: TextAlign.justify,
                style: StyleConst.regularStyle(color: Colors.grey),
              ),
            ),
            Visibility(
              visible: appConfig.appType == AppType.DOCTOR,
              child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(new ClipboardData(text: widget.content))
                        .then((_) {
                      showSnackBar(
                          title: "Sao chép thành công",
                          body: "${widget.content}");
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: 10),
                    child: Icon(
                      Icons.copy,
                      color: Colors.grey,
                      size: titleSize,
                    ),
                  )),
            )
          ],
        );
      }
    });
  }
}

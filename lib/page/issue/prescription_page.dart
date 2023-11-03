import 'package:bv_cay_an_qua/models/prescription/prescription_param.dart';
import 'package:bv_cay_an_qua/page/components/image_picker.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/issue_controller.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/prescription_controller.dart';
import 'package:bv_cay_an_qua/shared/helper/image_helper.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'components/item_prescription.dart';
import 'components/list_medicine.dart';

class PrescriptionPage extends StatefulWidget {
  final String issueId;
  final String tag;

  const PrescriptionPage({Key? key, required this.issueId, required this.tag})
      : super(key: key);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  List<String> images = [];
  TextEditingController note = TextEditingController();
  PrescriptionController _prescriptionController =
      Get.find<PrescriptionController>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Image.asset(
                AssetsConst.iconBack,
                fit: BoxFit.cover,
                width: 24,
                height: 24,
              ),
            ),
          ),
          brightness: Brightness.light,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Kê đơn",
                  style: StyleConst.boldStyle(
                          color: ColorConst.red, fontSize: titleSize)
                      .copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold)),
              Text('www.benhviencayanqua.vn',
                  style:
                      StyleConst.mediumStyle(color: ColorConst.primaryColor)),
            ],
          ),
          elevation: 2,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              child: Container(
                color: ColorConst.primaryColor,
                height: 8,
              ),
              preferredSize: Size.fromHeight(8)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đơn thuốc",
                  style:
                      StyleConst.regularStyle(color: ColorConst.primaryColor),
                ),
                GetBuilder<PrescriptionController>(builder: (controller) {
                  if (controller.inputDetails.length == 0)
                    return SizedBox(
                      height: 5,
                    );
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: ItemPrescription(
                        inputDetails: controller.inputDetails,
                        prescriptionController: _prescriptionController,
                      ));
                }),
                WidgetButton(
                  text: "Thêm thuốc",
                  textColor: ColorConst.primaryColor,
                  radiusColor: ColorConst.primaryColor,
                  backgroundColor: Colors.white,
                  onTap: () {
                    Get.to(ListMedicine());
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Ghi chú",
                  style:
                      StyleConst.regularStyle(color: ColorConst.primaryColor),
                ),
                SizedBox(
                  height: 10,
                ),
                WidgetTextField(
                  controller: note,
                  hintText: "Vui lòng nhập ghi chú nếu có",
                  keyboardType: TextInputType.multiline,
                  padding: EdgeInsets.all(10),
                  maxLine: 10,
                  minLine: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Hình ảnh đính kèm",
                  style: StyleConst.boldStyle(color: ColorConst.primaryColor),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                border: Border.all(
                                    width: 3,
                                    color: ColorConst.borderInputColor)),
                            child: Icon(
                              Icons.add,
                              color: ColorConst.grey,
                            )),
                        onTap: () => _handleUploadImage.call(context),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 130,
                        height: 64,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: images
                              .map(
                                (item) => InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: ImagePickerWidget(
                                      context: context,
                                      size: 64,
                                      isRemove: true,
                                      resourceUrl: item,
                                      // onFileChanged: (fileUri, fileType) {
                                      //   setState(() {
                                      //     item = fileUri;
                                      //   });
                                      // },
                                    ),
                                  ),
                                  onTap: () => _handleRemoveImage(item),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                WidgetButton(
                  text: "Xác nhận",
                  textColor: Colors.white,
                  onTap: () async {
                    await _prescriptionController.createPrescription(
                        issueId: widget.issueId,
                        context: context,
                        note: note.text,
                        images: images,
                        param: _prescriptionController.inputDetails);
                    Get.find<IssueController>(tag: widget.tag)
                        .getOneIssue(widget.issueId);
                    Get.find<IssueController>(tag: widget.tag).refreshData();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleRemoveImage(item) async {
    setState(() {
      images.remove(item);
    });
  }

  _handleUploadImage(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    showSelectMoreFile(
        context: context,
        isMultiImage: true,
        typeAlbum: TypeAlbum.image,
        callBack: (value) {
          if (value is List<String> && value.length > 0) {
            images.addAll(value);
            setState(() {});
          } else {
            setState(() {
              images.add(value);
            });
          }
        });
  }
}

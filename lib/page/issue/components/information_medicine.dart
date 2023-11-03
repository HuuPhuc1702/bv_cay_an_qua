import 'package:bv_cay_an_qua/models/prescription/medicine_model.dart';
import 'package:bv_cay_an_qua/models/prescription/prescription_param.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/prescription_controller.dart';
import 'package:bv_cay_an_qua/shared/widget/widget-combobox.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';

class InformationMedicine extends StatefulWidget {
  final MedicineModel medicineModel;

  const InformationMedicine({Key? key, required this.medicineModel})
      : super(key: key);

  @override
  _InformationMedicineState createState() => _InformationMedicineState();
}

class _InformationMedicineState extends State<InformationMedicine> {
  TextEditingController amount = TextEditingController();
  TextEditingController areaUse = TextEditingController();
  List<FormComboBox> listUnit = [FormComboBox(title: "ha", key: "", id: "")];
  List<FormComboBox> listAmountUnit = [
    FormComboBox(title: "chai", key: "", id: "chai"),
    FormComboBox(title: "gói", key: "", id: "goi")
  ];

  PrescriptionController _prescriptionController =
      Get.find<PrescriptionController>();
  FormComboBox? unit;

  late DropModel dropModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropModel = DropModel(listUnit: listAmountUnit, unit: listAmountUnit.first);
  }

  @override
  Widget build(BuildContext context) {
    print("xxx");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        // appBar: AppBar(
        //   leading: GestureDetector(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: Padding(
        //       padding: EdgeInsets.all(14.0),
        //       child: Image.asset(
        //         AssetsConst.iconBack,
        //         fit: BoxFit.cover,
        //         width: 24,
        //         height: 24,
        //       ),
        //     ),
        //   ),
        //   brightness: Brightness.light,
        //   title: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Text("Thông tin thuốc",
        //           style: StyleConst.boldStyle(
        //                   color: ColorConst.red, fontSize: titleSize)
        //               .copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
        //       Text('www.benhviencayanqua.vn',
        //           style: StyleConst.mediumStyle(color: ColorConst.primaryColor)),
        //     ],
        //   ),
        //   elevation: 2,
        //   backgroundColor: Colors.white,
        //   bottom: PreferredSize(
        //       child: Container(
        //         color: ColorConst.primaryColor,
        //         height: 8,
        //       ),
        //       preferredSize: Size.fromHeight(8)),
        // ),
        body: SafeArea(
          child: Column(
            children: [
              WidgetAppbar(
                title: "Thông tin thuốc",
                turnOnSendIssue: false,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.medicineModel.name ?? "chưa cập nhật"}",
                        style: StyleConst.boldStyle(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "Liều lượng",
                          style: StyleConst.regularStyle(
                              color: ColorConst.primaryColor),
                        ),
                      ),
                      new WidgetTextField(
                        controller: amount,
                        hintText: "Nhập liều lượng",
                        dropModel: dropModel,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "Diện tích sử dụng",
                          style: StyleConst.regularStyle(
                              color: ColorConst.primaryColor),
                        ),
                      ),
                      new WidgetTextField(
                        controller: areaUse,
                        hintText: "Nhập diện tích sử dụng",
                        // listUnit: listUnit,
                        dropModel:
                            DropModel(listUnit: listUnit, unit: listUnit.first),
                        maxLength: 3,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        // unit: unit,
                      ),
                      Spacer(),
                      WidgetButton(
                        text: "Xác nhận",
                        textColor: Colors.white,
                        onTap: () {
                          if (amount.text.isEmpty || areaUse.text.isEmpty) {
                            showSnackBar(
                                title: "Thông báo",
                                body: "Vui lòng nhập đủ thông tin.",
                                backgroundColor: Colors.yellow,
                                color: Colors.black);
                            return;
                          }
                          _prescriptionController.addDetailPrescription(
                              PrescriptionParam(
                                  medicineId: widget.medicineModel.id,
                                  medicineCode: widget.medicineModel.code,
                                  medicineName: widget.medicineModel.name,
                                  dosage:
                                      "${amount.text} ${dropModel.unit?.title}",
                                  sprayingArea: areaUse.text));
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

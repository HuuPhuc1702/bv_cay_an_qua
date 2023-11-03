import 'package:bv_cay_an_qua/models/prescription/prescription_param.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/prescription_controller.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';

import '../../../export.dart';

class ItemPrescription extends StatelessWidget {
  List<PrescriptionParam> inputDetails;
  PrescriptionController? prescriptionController;

  ItemPrescription(
      {Key? key, required this.inputDetails, this.prescriptionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          inputDetails.length,
          (index) => Container(
                padding:
                    prescriptionController != null ? EdgeInsets.all(10) : null,
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: prescriptionController != null
                        ? Border.all(
                            color: ColorConst.grey.withOpacity(.5), width: 1)
                        : null),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${inputDetails[index].medicineName ?? "Chưa cập nhật"}",
                                style: StyleConst.boldStyle(),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/icon_amount.png",
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Liều lượng: ${inputDetails[index].dosage ?? "Chưa cập nhật"}",
                                    style: StyleConst.regularStyle(
                                      fontSize: miniSize,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/icon_area.png",
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Diện tích sử dụng: ${inputDetails[index].sprayingArea ?? ""} ha",
                                    style: StyleConst.regularStyle(
                                      fontSize: miniSize,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: prescriptionController != null,
                          child: GestureDetector(
                            onTap: () {
                              prescriptionController?.removeDetailPrescription(
                                  inputDetails[index]);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: ImageIcon(
                                  AssetImage("assets/icons/icon_delete.png"),
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Visibility(
                        visible: prescriptionController == null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const MySeparator(),
                        ))
                  ],
                ),
              )),
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

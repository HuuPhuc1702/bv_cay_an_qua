import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/prescription/prescription_param.dart';
import 'package:bv_cay_an_qua/page/issue/controllers/issue_controller.dart';
import 'package:bv_cay_an_qua/repositories/prescription_repo.dart';
import 'package:bv_cay_an_qua/services/files/service_file.dart';
import 'package:bv_cay_an_qua/shared/helper/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrescriptionController extends GetxController {
  List<PrescriptionParam> inputDetails = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  addDetailPrescription(PrescriptionParam param) {
    inputDetails.add(param);
    update();
  }

  removeDetailPrescription(PrescriptionParam param) {
    inputDetails.remove(param);
    update();
  }

  createPrescription(
      {required String issueId,
      required BuildContext context,
      required List<PrescriptionParam> param,
      List<String>? images,
      String? note}) async {
    try {
      WaitingDialog.show(context);

      List<String>? imageNetworks;
      if (images != null) {
        imageNetworks = [];
        for (int i = 0; i < images.length; i++) {
          await serviceFile.updateImageImgur(images[i], onUpdateImage: (value) {
            if (value != null) imageNetworks!.add(value);
          });
        }
      }
      var data = await prescriptionRepository.prescribeForIssue(
          issueId: issueId, param: param, images: imageNetworks, note: note);

      WaitingDialog.turnOff();
      if (data == true) {
        inputDetails = [];
        Get.back();
        showSnackBar(title: "Thông báo", body: "Kê đơn thành công");
      } else {
        showSnackBar(
            title: "Thông báo",
            body: "Kê đơn không thành công",
            backgroundColor: Colors.red);
      }
    } catch (error) {
      WaitingDialog.turnOff();
      print(error);
    }
  }

  deletePrescription({required String issueId}) async {
    var data =
        await prescriptionRepository.deletePrescription(issueId: issueId);
    if (data == true) {
      showSnackBar(title: "Thông báo", body: "Cập nhật thành công");
    } else {
      showSnackBar(
          title: "Thông báo",
          body: "Cập nhật thành công",
          backgroundColor: Colors.red);
    }
  }
}

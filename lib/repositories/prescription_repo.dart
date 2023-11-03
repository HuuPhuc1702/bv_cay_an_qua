import 'dart:convert';

import 'package:bv_cay_an_qua/models/notification_model.dart';
import 'package:bv_cay_an_qua/models/prescription/prescription_param.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_repo.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';

final prescriptionRepository = new _PrescriptionRepository();

class _PrescriptionRepository extends GraphqlRepository {
  assignPrescription({
    required String issueId,
  }) async {
    try {
      var result = await this.mutate("""
       assignPrescription(issueId:"$issueId"){
                id
              }
    """);
      this.handleException(result);
      this.clearCache();
      if (result.data?["g0"]["id"] != null) {
        return true;
      }
      return false;
    } catch (error) {
      print("update---Comment: $error");
      return false;
    }
  }

  prescribeForIssue(
      {required String issueId,
      String? note,
      List<String>? images,
      required List<PrescriptionParam> param}) async {
    try {
      var _param = List.from(param.map((d) => """
                             {medicineId:"${d.medicineId}", 
                             medicineCode:"${d.medicineCode}", 
                             medicineName:"${d.medicineName}", 
                             dosage:"${d.dosage}", 
                             sprayingArea:${d.sprayingArea}},
                          """));

      var result = await this.mutate("""
              prescribeForIssue(
                      issueId:"$issueId",
                      images:${jsonEncode(images)} ,
                      ${note != null ? ' note:"$note",' : ""}
                      detail:$_param){
                        id
                      }
          """);
      this.handleException(result);
      this.clearCache();
      if (result.data?["g0"]["id"] != null) {
        return true;
      }
      return false;
    } catch (error) {
      print("update---Comment: $error");
      return false;
    }
  }

  deletePrescription({String? issueId}) async {
    try {
      var result = await this.mutate("""
              deletePrescription(
                      issueId:"$issueId"){
                        id
                      }
          """);
      this.handleException(result);
      this.clearCache();
      if (result.data?["g0"]["id"] != null) {
        return true;
      }
      return false;
    } catch (error) {
      print("update---Comment: $error");
      return false;
    }
  }
}

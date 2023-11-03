import 'dart:convert';

import 'package:bv_cay_an_qua/models/notification_model.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_repo.dart';

final issueRepository = new _IssueRepository();

class _IssueRepository extends GraphqlRepository {
  Future<bool> createIssue(
      {String? title,
      String? desc,
      String? plantId,
      String? diseaseId,
      String? hospitalId,
      String? doctorId,
      String? videoId,
      String? audioId,
      List<String>? images}) async {
    var result = await this.mutate("""
            createIssue(data:{
                          title:"$title",
                          desc:"$desc",
                         ${(images?.length ?? 0) > 0 ? 'images: ${jsonEncode(images)},' : ""}
                          ${plantId != null ? 'plantId:"$plantId",' : ""}
                          ${hospitalId != null ? 'hospitalId:"$hospitalId",' : ""}
                          ${doctorId != null ? 'doctorId:"$doctorId",' : ""}
                          ${diseaseId != null ? 'diseaseId:"$diseaseId",' : ""}
                          ${videoId != null ? 'videoId:"$videoId",' : ""}
                          ${audioId != null ? 'audioId:"$audioId",' : ""}
                           }){
    id
  }
    """);
    this.handleException(result);
    this.clearCache();
    if (result.data?["g0"]["id"] != null) {
      // return result.data?["g0"];
      return true;
    }
    return false;
  }

  createComment(
      {required String issueId,
      String? replyToId,
      String? content,
      String? image}) async {
    try {
      //   var result = await this.mutate("""
      //     createComment(data:{
      //                         issueId:"$issueId",
      //                         ${replyToId != null ? 'replyToId:"$replyToId",' : ""}
      //                         content:"$content",
      //                         ${image != null ? 'image:"$image",' : ""}
      //                       }){
      //                         id
      //                       }
      // """);

      var result = await this.mutate("""
       createComment(data:\$data){ id }
    """, variables: {
        "data": {
          "issueId": issueId,
          if (replyToId != null) "replyToId": replyToId,
          "content": content,
          "image": image
        }
      }, variablesParams: "(\$data:CreateCommentInput!)");

      this.handleException(result);
      this.clearCache();
      if (result.data?["g0"]["id"] != null) {
        return true;
      }
      return false;
    } catch (error) {
      print("update---Comment: $error");
    }
  }

  updateComment(
      {required String id, String? content, List<String>? image}) async {
    try {
      var result = await this.mutate("""
       updateComment(id:"$id",data:{
                     content:"$content",
                     ${image != null ? 'image:"$image",' : ""}
            }){
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

  rateIssue(String issueId, int rating) async {
    try {
      var result = await this.mutate("""
      createIssueRate(data:{
        issueId:"$issueId",
        rate:${rating.toInt()}
            }){
              id
              rate 
              user {id name role}
            }
            """);
      this.handleException(result);
      this.clearCache();
      if (result.data?["g0"]["id"] != null) {
        return true;
      }
      return false;
    } catch (error) {
      print("rate--Issue: $error");
    }
  }

  rateComment({required String? commentId, required int rating}) async {
    try {
      var result = await this.mutate("""
      createCommentRate(data:{
        commentId:"$commentId",
        rate:${rating.toInt()}
            }){
              id
              rate 
              user {id name role}
            }
            """);
      this.handleException(result);
      this.clearCache();
      if (result.data?["g0"]["id"] != null) {
        return true;
      }
      return false;
    } catch (error) {
      print("rate--Comment: $error");
    }
  }

  assignIssueDisease(
      {required String issueId, required String diseaseId}) async {
    try {
      var result = await this.mutate("""
              assignIssueDisease(issueId:"$issueId",diseaseId:"$diseaseId"){
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
      print("rate--Comment: $error");
    }
  }

  transferIssueDoctor(
      {required String issueId,
      required String? doctorId,
      required reason}) async {
    try {
      var result = await this.mutate("""
              transferIssueDoctor(issueId:"$issueId",doctorId:"$doctorId",reason:"$reason"){
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
      print("rate--Comment: $error");
    }
  }

  transferIssueHospital(
      {required String issueId,
      required String? hospitalId,
      required reason}) async {
    try {
      var result = await this.mutate("""
              transferIssueHospital(issueId:"$issueId",hospitalId:"$hospitalId",reason:"$reason"){
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
      print("rate--Comment: $error");
    }
  }

  countComment({required String commentId}) async {
    try {
      var result = await this.mutate("""
             viewComment(commentId:"$commentId"){
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
      print("rate--Comment: $error");
    }
  }
}

import 'dart:convert';

import 'package:bv_cay_an_qua/models/notification_model.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_repo.dart';

final userPostRepository = new _UserPostRepository();

class _UserPostRepository extends GraphqlRepository {
  Future<bool> createUserPost(
      {String? content = "",
      String? plantId = "",
      String? doctorId = "",
      List<String>? images}) async {
    //   var result = await this.mutate("""
    //           createUserPost(data:{
    //                         content:"$content",
    //                        ${(images?.length ?? 0) > 0 ? 'images: ${jsonEncode(images)},' : ""}
    //                         ${plantId != null ? 'plantId:"$plantId",' : ""}
    //                         ${doctorId != null ? 'doctorId:"$doctorId",' : ""}
    //                          }){
    //   id
    // }
    //   """);

    var result = await this.mutate("""
       createUserPost(data:\$data){ id }
    """, variables: {
      "data": {
        if ((images?.length ?? 0) > 0) "images": images,
        if (plantId != null) "plantId": plantId,
        if (doctorId != null) "doctorId": doctorId,
        "content": content,
      }
    }, variablesParams: "(\$data:CreateUserPostInput!)");

    this.handleException(result);
    this.clearCache();
    if (result.data?["g0"]["id"] != null) {
      // return result.data?["g0"];
      return true;
    }
    return false;
  }

  Future<bool> updateUserPost(
      {String? content,
      required String userPostId,
      String? plantId,
      List<String>? images}) async {
    var result = await this.mutate("""
            updateUserPost(id:"$userPostId",data:{
                          content:"$content",
                         ${(images?.length ?? 0) > 0 ? 'images: ${jsonEncode(images)},' : ""}
                          ${plantId != null ? 'plantId:"$plantId",' : ""}
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
      {required String userPostId,
      String? replyToId,
      String? content,
      String? image}) async {
    try {
      //   var result = await this.mutate("""
      //     createComment(data:{
      //                         userPostId:"$userPostId",
      //                         ${replyToId != null ? 'replyToId:"$replyToId",' : ""}
      //                         content:"${content?.replaceAll("\n", r"\n")}",
      //                         ${image != null ? 'image:"$image",' : ""}
      //                       }){
      //                         id
      //                       }
      // """);
      var result = await this.mutate("""
       createComment(data:\$data){ id }
    """, variables: {
        "data": {
          "userPostId": userPostId,
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
}

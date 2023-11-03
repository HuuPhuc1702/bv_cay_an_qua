import 'dart:convert';

import 'package:bv_cay_an_qua/services/graphql/graphql_list_provider.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';

import '../../services/graphql/crud_repo.dart';
import '../../services/graphql/graphql_list_load_more_provider.dart';
import '../../models/post_model.dart';

class PostController extends GraphqlListLoadMoreProvider<PostModel> {
  static PostProvider _tinTucProvider = PostProvider();
  static QueryInput queryInput = QueryInput(
      // filter: {"topicSlugs": topicSlugs},
      order: {"_id": -1, "publishedAt": -1});

  PostModel? postDetail;
  String? topic;

  PostController({QueryInput? query})
      : super(
            service: _tinTucProvider, query: query ?? queryInput, fragment: """
      id
      createdAt
      title
      excerpt
      slug
      status
      publishedAt
      featureImage
      ogImage
   		content
      ogTitle
      ogDescription
      seen
      url
      view
      attachments {
                          id
                          mimetype
                          name
                          path 
                          downloadUrl
                          size
      }
  """);

  getOnePost(String id) async {
    var data = await _tinTucProvider.getOne(id: id, fragment: this.fragment);
    postDetail = data;
    update();
  }

  refreshGetOnePost() async {
    _tinTucProvider.clearCache();
    if (postDetail != null) {
      var data = await _tinTucProvider.getOne(
          id: postDetail!.id, fragment: this.fragment);
      postDetail = data;
      update();
    }
  }

  refreshData({String? topicIds}) {
    _tinTucProvider.clearCache();
    loadAll(
        query: mapData(PostController.queryInput.toJson(),
            QueryInput(page: 1, filter: {"topicIds": "$topicIds"}).toJson()));
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}

class PostProvider extends CrudRepository<PostModel> {
  PostProvider() : super(apiName: "Post");

  @override
  PostModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return PostModel.fromJson(json);
  }
}

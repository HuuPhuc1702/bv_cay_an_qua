import 'package:bv_cay_an_qua/models/video_model.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_load_more_provider.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_provider.dart';
import 'package:get/get.dart';

class VideoController extends GraphqlListLoadMoreProvider<VideoModel> {
  static VideoProvider _provider = VideoProvider();
  static QueryInput queryInput = QueryInput(
      // filter: {"topicSlugs": topicSlugs},
      order: {"priority": -1, "_id": -1, "createdAt": -1});

  VideoModel? detail;

  VideoController({QueryInput? query})
      : super(
            service: _provider,
            query: query != null
                ? mapData(query.toJson(), queryInput.toJson())
                : queryInput,
            fragment: """
       id
      createdAt
      videoId
      title
      description
      thumb
      published
  """);

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  refreshData({String? groupId}) {
    _provider.clearCache();
    loadAll(
        query: QueryInput(
            page: 1, filter: groupId != null ? {"groupId": "$groupId"} : {}));
  }
}

class VideoProvider extends CrudRepository<VideoModel> {
  VideoProvider() : super(apiName: "YoutubeVideo");

  @override
  VideoModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return VideoModel.fromJson(json);
  }
}

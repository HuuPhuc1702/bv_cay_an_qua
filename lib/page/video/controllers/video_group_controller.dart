import 'package:bv_cay_an_qua/models/video_model.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_load_more_provider.dart';
import 'package:get/get.dart';

class VideoGroupController
    extends GraphqlListLoadMoreProvider<GroupVideoModel> {
  static VideoGroupProvider _provider = VideoGroupProvider();
  static QueryInput queryInput = QueryInput(order: {"priority": -1});

  VideoGroupController({QueryInput? query})
      : super(service: _provider, query: query ?? queryInput, fragment: """
       id
      name
      videos{
        id
        createdAt
        title
        description
        thumb
        published
        videoId
      }
      createdAt
      active
      priority
  """);

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  refreshData() {
    _provider.clearCache();
    loadAll(query: QueryInput(order: {"priority": -1}, page: 1));
  }
}

class VideoGroupProvider extends CrudRepository<GroupVideoModel> {
  VideoGroupProvider() : super(apiName: "VideoGroup");

  @override
  GroupVideoModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return GroupVideoModel.fromJson(json);
  }
}

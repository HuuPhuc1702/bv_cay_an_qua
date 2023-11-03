import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../shared/helper/dialogs.dart';

import 'crud_repo.dart';
import 'graphql_list_provider.dart';

class GraphqlListLoadMoreProvider<T> extends GraphqlListProvider<T> {
  Rx<List<T>> loadMoreItems = Rx<List<T>>([]);
  bool lastItem = false;
  int defaultLimit=10;


  GraphqlListLoadMoreProvider(
      {required service,  QueryInput? query, required String fragment})
      : super(service: service, query: query, fragment: fragment){
    this.lastItem=false;
  }

  Future loadMore() async {
    // print("length - ${this.loadMoreItems.value}");
    // print("lastItem - ${this.lastItem}");
    // print("this.pagination.value.page  ${this.pagination.value.page }");
    if (lastItem == true) return;
    var items = await this.loadAll(
        query: QueryInput(page: (this.pagination.value.page ?? 0) + 1));
    // print("items.length ${items.length}");
    if (items.length < (this.pagination.value.limit ?? defaultLimit)) {
      lastItem = true;
    }
    loadMoreItems.value = [...loadMoreItems.value, ...items];

    update();
  }

  @override
  Future<List<T>> loadAll({QueryInput? query}) {
    return super.loadAll(query: query).then((res) {
      if (this.pagination.value.page == 1) {
        if(res.length<(this.pagination.value.limit??defaultLimit)){
          // print("res.total - $total - ${res.length}");
          lastItem=true;
        }
        loadMoreItems.value = res;
        // print("res.total - $total - ${res.length}");
        //
        // print("loadAll length - ${this.loadMoreItems.value.length}");

        ///region dùng test data
        // loadMoreItems.value.addAll(res);
        // loadMoreItems.value.addAll(res);
        // loadMoreItems.value.addAll(res);
        ///endregion
      }
      update();

      return res;
    });
  }
}

import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'crud_repo.dart';

abstract class GraphqlListProvider<T> extends GetxController {
  final CrudRepository<T> service;
  Rx<List<T>> items = Rx<List<T>>([]);
  int total = 0;
  Rx<Pagination> pagination = Rx(Pagination(
    limit: 10,
    offset: 0,
    page: 1,
    total: 0,
  ));
  QueryInput query = QueryInput(limit: 10, page: 1);
  late String fragment;

  GraphqlListProvider(
      {required this.service, QueryInput? query, required String fragment}) {
    this.fragment = fragment;
    this.loadAll(query: query);
  }

  Future<List<T>> loadAll({QueryInput? query}) {
    this.query = query == null
        ? this.query
        // : QueryInput.fromJson({...this.query.toJson(), ...query.toJson()});
        : mapData(this.query.toJson(), query.toJson());

    printLog("json query loadAll: ${this.query.toJson()}");

    return service
        .getAll(query: this.query, fragment: this.fragment)
        .then((res) {
      items.value = res.data;
      pagination.value = res.pagination;
      total = res.total;
      // pagination.notifyListeners();
      update();
      return res.data;
    });
  }

  Future<T> create(dynamic data) {
    return service.create(data: data, fragment: fragment).then((res) {
      this.loadAll();
      return res;
    });
  }

  Future<T> updateData(String id, dynamic data) {
    return service.update(id: id, data: data, fragment: fragment).then((res) {
      this.loadAll();
      return res;
    });
  }

  Future<T> delete(String id) {
    return service.delete(id: id, fragment: fragment).then((res) {
      this.loadAll();
      return res;
    });
  }
}

mapData(Map<String, dynamic> map1, Map<String, dynamic> map2) {
  Map<String, dynamic> object = map1;
  if (map1.keys.length > map2.keys.length) {
    object = {...map2, ...map1};
  } else {
    if (map1.keys.length < map2.keys.length) {
      object = {...map1, ...map2};
    }
  }
  map1.keys.forEach((element) {
    if (map2[element] != null) map1[element] = map2[element];
  });
  object = map1;
  // print("mapData----- $object");
  return QueryInput.fromJson(object);
}

// mapData2({required Map<String, dynamic> mapNew,required Map<String, dynamic> mapOld}) {
//   Map<String, dynamic> object = Map();
//   Map<String, dynamic> _map2={...mapNew,...mapOld};
//   printLog("_map2---$_map2");
//   object={...mapNew,...mapOld};
//   mapNew.forEach((key1, value1) {
//     _map2.forEach((key2, value2) {
//       if(key1==key2){
//         if(mapNew[key1] is Map<String,dynamic>&& _map2[key1] is Map<String,dynamic>){
//           object[key1]=  mapData2(mapNew: mapNew[key1],mapOld: _map2[key1]);
//         }else{
//           object[key1]=_map2[key1]??mapNew[key1]??mapOld[key1];
//         }
//       }
//     });
//   });
//   // print("mapData----- $object");
//   // return QueryInput.fromJson(object);
//   return object;
// }


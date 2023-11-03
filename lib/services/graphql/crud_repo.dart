import 'package:flutter/material.dart';

import 'graphql_repo.dart';

class QueryInput {
  final int? limit;
  final int? page;
  final int? offset;
  final String? search;
  final Map<String, int>? order;
  final dynamic filter;

  QueryInput(
      {this.limit,
      this.page,
      this.offset,
      this.search,
      this.order,
      this.filter});

  factory QueryInput.fromJson(Map<String, dynamic> json) => QueryInput(
        limit: json["limit"] == null ? null : json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
        page: json["page"] == null ? null : json["page"],
        search: json["search"] == null ? null : json["search"],
        order: json["order"] == null ? null : json["order"],
        filter: json["filter"] == null ? null : json["filter"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "page": page,
        "offset": offset,
        "search": search,
        "order": order,
        "filter": filter
      };
}

class Pagination {
  final int? limit;
  final int? offset;
  final int? page;
  final int? total;

  Pagination({this.limit, this.offset, required this.page, this.total});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        limit: json["limit"] == null ? null : json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
        page: json["page"] == null ? null : json["page"],
        total: json["total"] == null ? null : json["total"],
      );
}

class PageData<T> {
  final List<T> data;
  final int total;
  final Pagination pagination;

  PageData(this.data, this.total, this.pagination);
}

abstract class CrudRepository<T> extends GraphqlRepository {
  String? apiName;
  String? shortFragment;
  String? fullFragment;

  T fromJson(Map<String, dynamic> json);

  CrudRepository({apiName, shortFragment, fullFragment}) {
    this.apiName = apiName ?? this.apiName;
    this.shortFragment = shortFragment ?? this.shortFragment;
    this.fullFragment = fullFragment ?? this.fullFragment;
  }

  Future<PageData<T>> getAll(
      {QueryInput? query, String? fragment, bool? cache}) async {
    query = query ?? QueryInput(limit: 10, page: 1);
    fragment = fragment ?? this.shortFragment;
    cache = cache == null ? true : cache;
    var result = await this.query(
      "getAll$apiName(q: \$q) { data { $fragment } total pagination { limit offset page total } }",
      variablesParams: "(\$q: QueryGetListInput)",
      variables: {"q": query.toJson()},
    );
    this.handleException(result);
    var data = result.data?["g0"];
    var listDoc = List<T>.from(data["data"].map((d) => this.fromJson(d)));
    var pagination = Pagination.fromJson(data["pagination"]);
    return PageData(listDoc, data["total"], pagination);
  }

  Future<T> getOne(
      {@required String? id, String? fragment, bool? cache}) async {
    fragment = fragment ?? this.fullFragment;
    cache = cache == null ? true : cache;
    var result = await this.query(
      """getOne$apiName(id: "$id") { $fragment }""",
    );
    this.handleException(result);
    return this.fromJson(result.data?["g0"]);
  }

  Future<T> update(
      {@required String? id, @required dynamic data, String? fragment}) async {
    fragment = fragment ?? this.fullFragment;
    var result = await this.mutate(
        """update$apiName(id: "$id", data: \$data) { $fragment }""",
        variablesParams: "(\$data: Update${apiName}Input!)",
        variables: {"data": data});
    this.handleException(result);
    this.clearCache();
    return this.fromJson(result.data?["g0"]);
  }

  Future<T> create({@required dynamic data, String? fragment}) async {
    fragment = fragment ?? this.fullFragment;
    var result = await this.mutate(
        """create$apiName( data: \$data) { $fragment }""",
        variablesParams: "(\$data: Create${apiName}Input!)",
        variables: {"data": data});
    this.handleException(result);
    this.clearCache();
    return this.fromJson(result.data?["g0"]);
  }

  Future<T> delete({@required String? id, String? fragment}) async {
    fragment = fragment ?? this.fullFragment;
    var result =
        await this.mutate("""deleteOne$apiName(id: "$id") { $fragment }""");
    this.handleException(result);
    this.clearCache();
    return this.fromJson(result.data?["g0"]);
  }
}

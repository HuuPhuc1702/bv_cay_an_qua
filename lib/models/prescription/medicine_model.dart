/// id : "6177d9bec7eb073ba0120e55"
/// name : "Astra"
/// code : "T10001"
/// thumbnail : null
/// images : null
/// desc : "Vacxin covid"
/// ingredientIds : []
/// target : null
/// supplier : null
/// ingredients : []

class MedicineModel {
  MedicineModel({
      this.id, 
      this.name, 
      this.code, 
      this.thumbnail, 
      this.images, 
      this.desc, 
      this.ingredientIds, 
      this.target, 
      this.supplier, 
      this.ingredients,});

  MedicineModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    thumbnail = json['thumbnail'];
    images = json['images'];
    desc = json['desc'];
    if (json['ingredientIds'] != null) {
      ingredientIds = [];
      json['ingredientIds'].forEach((v) {
        ingredientIds?.add(v);
      });
    }
    target = json['target'];
    supplier = json['supplier'];
    if (json['ingredients'] != null) {
      ingredients = [];
      json['ingredients'].forEach((v) {
        ingredients?.add(v);
      });
    }
  }
  String? id;
  String? name;
  String? code;
  dynamic thumbnail;
  dynamic images;
  String? desc;
  List<dynamic>? ingredientIds;
  dynamic target;
  dynamic supplier;
  List<dynamic>? ingredients;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['thumbnail'] = thumbnail;
    map['images'] = images;
    map['desc'] = desc;
    if (ingredientIds != null) {
      map['ingredientIds'] = ingredientIds?.map((v) => v.toJson()).toList();
    }
    map['target'] = target;
    map['supplier'] = supplier;
    if (ingredients != null) {
      map['ingredients'] = ingredients?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
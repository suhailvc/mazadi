class advertisementCategories_Model {
late bool? status;
late String? messageEn;
late String? messageAr;
late Data data;
late int? code;

  advertisementCategories_Model();

  advertisementCategories_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data =  new Data.fromJson(json['data']) ;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message_en'] = this.messageEn;
    data['message_ar'] = this.messageAr;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
late int? id;
late String? name;
late String? description;
late String? icon;
late int? parentId;
late int? style;
late List<SubCategories>? subCategories;
late List<type_categories>? typeCategories;
late List<type_categories>? featureCategories;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    parentId = json['parent_id'];
    style = json['style'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
    if (json['type_categories'] != null) {
      typeCategories = <type_categories>[];
      json['type_categories'].forEach((v) {
        typeCategories!.add(new type_categories.fromJson(v));
      });
    }
    if (json['feature_categories'] != null) {
      featureCategories = <type_categories>[];
      json['feature_categories'].forEach((v) {
        featureCategories!.add(new type_categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['parent_id'] = this.parentId;
    data['style'] = this.style;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    if (this.typeCategories != null) {
      data['type_categories'] =
          this.typeCategories!.map((v) => v.toJson()).toList();
    }
    if (this.featureCategories != null) {
      data['feature_categories'] =
          this.featureCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int? id;
  String? name;
  String? description;
  String? icon;
  int? parentId;
  int? style;
  List<SubCategories>? subCategories;

  SubCategories(
      {this.id,
        this.name,
        this.description,
        this.icon,
        this.parentId,
        this.style,
        this.subCategories});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    parentId = json['parent_id'];
    style = json['style'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['parent_id'] = this.parentId;
    data['style'] = this.style;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class type_categories {
 late int? id;
 late int? category_id;
 late String? name;


  type_categories(
);

  type_categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category_id = json['category_id'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.category_id;

    return data;
  }
}

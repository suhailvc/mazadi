import 'advertisementOfCategory_Model.dart';

class advertisementCategoryDetails_Model {
late  bool? status;
late  String? messageEn;
late  String? messageAr;
late  List<Data>? data;
late  LastPaidAdvertisement? lastPaidAdvertisement;
late  List<Types>? typeCategories;
late  int? code;

  advertisementCategoryDetails_Model(
      );

  advertisementCategoryDetails_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    lastPaidAdvertisement = json['last_paid_advertisement'] != null
        ? new LastPaidAdvertisement.fromJson(json['last_paid_advertisement'])
        : null;
    if (json['type_categories'] != null) {
      typeCategories = <Types>[];
      json['type_categories'].forEach((v) {
        typeCategories!.add(new Types.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message_en'] = this.messageEn;
    data['message_ar'] = this.messageAr;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.lastPaidAdvertisement != null) {
      data['last_paid_advertisement'] = this.lastPaidAdvertisement!.toJson();
    }
    if (this.typeCategories != null) {
      data['type_categories'] =
          this.typeCategories!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
late int? id;
late String? name;
late String? name_ar;
late String? description;
late String? icon;
late int? parentId;
late int? advertisementsCount;
// late List<Null>? subCategories;
late List<Types>? typeCategories;

  Data(
    );

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    parentId = json['parent_id'];
    advertisementsCount = json['advertisements_count']??0;
    name_ar = json['name_ar'];
    // if (json['sub_categories'] != null) {
    //   subCategories = <Null>[];
    //   json['sub_categories'].forEach((v) {
    //     subCategories!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['type_categories'] != null) {
      typeCategories = <Types>[];
      json['type_categories'].forEach((v) {
        typeCategories!.add(new Types.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['name_ar'] = this.name_ar;
    data['parent_id'] = this.parentId;
    data['advertisements_count'] = this.advertisementsCount;
    // if (this.subCategories != null) {
    //   data['sub_categories'] =
    //       this.subCategories!.map((v) => v.toJson()).toList();
    // }
    if (this.typeCategories != null) {
      data['type_categories'] =
          this.typeCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class LastPaidAdvertisement {
late  int? id;
late  int? categoryId;
late  int? advertisementId;
late  String? title;
late  String? photo;
late  String? link;
late  String? views;
late  int? type;
late  String? createdAt;
late  String? updatedAt;
late  String? deletedAt;

  LastPaidAdvertisement(
      );

  LastPaidAdvertisement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    advertisementId = json['advertisement_id'];
    title = json['title'];
    photo = json['photo'];
    link = json['link'];
    views = json['views'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['advertisement_id'] = this.advertisementId;
    data['title'] = this.title;
    data['photo'] = this.photo;
    data['link'] = this.link;
    data['views'] = this.views;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

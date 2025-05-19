import 'package:flutter/material.dart';

class singleAucationCategory_Model {
 late bool status;
 late String messageEn;
 late String messageAr;
 late Data? data;
 late int code;

  singleAucationCategory_Model();

  singleAucationCategory_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data = new Data.fromJson(json['data']) ;
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
late  int? id;
late  String? name;
late  String? description;
late  String? icon;
late  List<SubCategories>? subCategories;
late  List<TypeCategories>? typeCategories;
// late  List<Null>? featureCategories;
late  List<auction_model>? auctions;
  String typeGroupValue='';
  String subCategoryGroupValue='';
  TextEditingController TypeEditingController=TextEditingController();
  TextEditingController subCategoryEditingController=TextEditingController();

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
    if (json['type_categories'] != null) {
      typeCategories = <TypeCategories>[];
      json['type_categories'].forEach((v) {
        typeCategories!.add(new TypeCategories.fromJson(v));
      });
    }
    // if (json['feature_categories'] != null) {
    //   featureCategories = <Null>[];
    //   json['feature_categories'].forEach((v) {
    //     featureCategories!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['auctions'] != null) {
      auctions = <auction_model>[];
      json['auctions'].forEach((v) {
        auctions!.add(new auction_model.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    if (this.typeCategories != null) {
      data['type_categories'] =
          this.typeCategories!.map((v) => v.toJson()).toList();
    }
    // if (this.featureCategories != null) {
    //   data['feature_categories'] =
    //       this.featureCategories!.map((v) => v.toJson()).toList();
    // }
    if (this.auctions != null) {
      data['auctions'] = this.auctions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class auction_model {
late  int id;
late  int userId;
late  int categoryId;
late  int typeId;
late  int cityId;
late  String title;
late  String titleAr;
late  String description;
late  String descriptionAr;
late  String price;
late  String minBid;
late  int status;
late  String? photo;
late  int views;
late  String auctionFrom;
late  String auctionTo;
late  String createdAt;
late  String? updatedAt;
late  Null? deletedAt;
late  int wishlist;
late  int lastBid;

  auction_model();

  auction_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    typeId = json['type_id'];
    cityId = json['city_id'];
    title = json['title'];
    titleAr = json['title_ar'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    price = json['price'];
    minBid = json['min_bid'];
    status = json['status'];
    photo = json['photo'];
    views = json['views'];
    auctionFrom = json['auction_from'];
    auctionTo = json['auction_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    wishlist = json['wishlist'];
    lastBid = json['last_bid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['type_id'] = this.typeId;
    data['city_id'] = this.cityId;
    data['title'] = this.title;
    data['title_ar'] = this.titleAr;
    data['description'] = this.description;
    data['description_ar'] = this.descriptionAr;
    data['price'] = this.price;
    data['min_bid'] = this.minBid;
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['views'] = this.views;
    data['auction_from'] = this.auctionFrom;
    data['auction_to'] = this.auctionTo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['wishlist'] = this.wishlist;
    data['last_bid'] = this.lastBid;
    return data;
  }
}
class SubCategories {
 late int? id;
 late String? name;
 late String? nameAr;
 late String? description;
 late String? icon;
 late int? parentId;

  SubCategories(
     );

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    description = json['description'];
    icon = json['icon'];
    parentId = json['parent_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['parent_id'] = this.parentId;

    return data;
  }
}
class TypeCategories {
  late int? id;
  late String? name;
  late String? name_en;
  bool isSelected =false;

  TypeCategories();

  TypeCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_en = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.name_en;
    return data;
  }
}
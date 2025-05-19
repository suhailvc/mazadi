class myAdvertisement_wishlists_Model {
late  bool status;
late  String messageEn;
late  String messageAr;
late  List<Data> data;
late  int code;

  myAdvertisement_wishlists_Model(
     );

  myAdvertisement_wishlists_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
    data['code'] = this.code;
    return data;
  }
}

class Data {
 late int id;
 late int userId;
 late int? advertisementId;
 late int? auctionId;
 late String createdAt;
 late String updatedAt;
 late Advertisement advertisement;

  Data(
     );

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    advertisementId = json['advertisement_id'];
    auctionId = json['auction_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    advertisement = new Advertisement.fromJson(json['advertisement']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['advertisement_id'] = this.advertisementId;
    data['auction_id'] = this.auctionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.advertisement != null) {
      data['advertisement'] = this.advertisement!.toJson();
    }
    return data;
  }
}

class Advertisement {
late int? id;
late int? userId;
late int? categoryId;
late int? typeId;
late int? cityId;
late String? title;
late String? titleAr;
late String? description;
late String? descriptionAr;
late String? price;
late int? status;
late String? photo;
late int? views;
late String? createdAt;
late String? updatedAt;
late String? deletedAt;
late int? wishlist;

  Advertisement();

  Advertisement.fromJson(Map<String, dynamic> json) {
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
    status = json['status'];
    photo = json['photo'];
    views = json['views'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    wishlist = json['wishlist'];
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
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['views'] = this.views;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['wishlist'] = this.wishlist;
    return data;
  }
}

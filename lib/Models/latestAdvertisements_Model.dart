class latestAdvertisements_Model {
  late bool status;
  late String messageEn;
  late String messageAr;
  late Data data;
  late int code;

  latestAdvertisements_Model(
      );

  latestAdvertisements_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data =  Data.fromJson(json['data']) ;
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
  late int? currentPage;
  late List<Data2> data2;

  late String? nextPageUrl;


  Data(
      );

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data2 = <Data2>[];
      json['data'].forEach((v) {
        data2!.add(new Data2.fromJson(v));
      });
    }

    nextPageUrl = json['next_page_url'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data2 != null) {
      data['data'] = this.data2!.map((v) => v.toJson()).toList();
    }

    data['next_page_url'] = this.nextPageUrl;

    return data;
  }
}

class Data2 {
  late int? id;
  late int? userId;
  late int? categoryId;
  late int? typeId;
  late int? cityId;
  late String? title;
  late String? titleAr;
  late String? description;
  late String? descriptionAr;
  late String? language;
  late String? price;
  late int? status;
  late String? photo;
  late int? views;
  late String? createdAt;
  late String? updatedAt;
  late String? deletedAt;
  late var commentsCount;
  late int? wishlist;
  late int? paid;

  Data2(
      );

  Data2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paid = json['paid'];
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
    language = json['language'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    commentsCount = json['comments_count'];
    wishlist = json['wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['paid'] = this.paid;
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
    data['language'] = this.language;
    data['views'] = this.views;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['comments_count'] = this.commentsCount;
    data['wishlist'] = this.wishlist;
    return data;
  }
}

class Links {
  late  String? url;
  late  String? label;
  late  bool? active;

  Links();

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
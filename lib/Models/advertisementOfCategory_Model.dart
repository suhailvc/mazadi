class advertisementOfCategory_Model {
late  bool status;
late  String messageEn;
late  String messageAr;
late  Data? data;
late  List<Types> types;
late  int code;

  advertisementOfCategory_Model(
     );

  advertisementOfCategory_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(new Types.fromJson(v));
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
      data['data'] = this.data!.toJson();
    }
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  late int currentPage;
  late List<AdvertiseModel>? data;

  late  String? nextPageUrl;


  Data();

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AdvertiseModel>[];
      json['data'].forEach((v) {
        data!.add(new AdvertiseModel.fromJson(v));
      });
    }

    nextPageUrl = json['next_page_url'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    data['next_page_url'] = this.nextPageUrl;

    return data;
  }
}

class AdvertiseModel {
  late  int id;
  late  int userId;
  late  int categoryId;
  late  int? typeId;
  late  int cityId;
  late  String title;
  late  String titleAr;
  late  String description;
  late String descriptionAr;
  late String price;
  late String? minBid;
  late  int status;
  late  String? photo;
  late  int? views;
  late  String? auctionFrom;
  late  String? auctionTo;
  late  String createdAt;
  late  String? updatedAt;
  late  String? deletedAt;
  late  int? bidsCount;
  late  int? wishlist;
  late  int? lastBid;
  late  int? comments_count;
  late int? paid;

  AdvertiseModel();

  AdvertiseModel.fromJson(Map<String, dynamic> json) {
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
    paid = json['paid'];
    auctionFrom = json['auction_from'];
    auctionTo = json['auction_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    bidsCount = json['bids_count'];
    wishlist = json['wishlist'];
    lastBid = json['last_bid'];
    comments_count = json['comments_count'];
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
    data['paid'] = this.paid;
    data['auction_from'] = this.auctionFrom;
    data['auction_to'] = this.auctionTo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['bids_count'] = this.bidsCount;
    data['wishlist'] = this.wishlist;
    data['comments_count'] = this.comments_count;
    data['last_bid'] = this.lastBid;
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

class Types {
late  int? id;
late  int? categoryId;
late  String? name;
bool isSelected =false;
  Types();

  Types.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    return data;
  }
}

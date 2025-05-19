class MyAuctions_model {

 late bool? status;
 late String? messageEn;
 late String? messageAr;
 late Data? data;
 late int? code;

  MyAuctions_model();

  MyAuctions_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
late  int? currentPage;
late  List<Data2> data;

late  String? nextPageUrl;


  Data(
     );

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data2>[];
      json['data'].forEach((v) {
        data!.add(new Data2.fromJson(v));
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
late String? price;
late String? minBid;
late int? status;
late String? photo;
late String? auctionFrom;
late String? auctionTo;
late String? language;
late int bidsCount;
late TopBid? topBid;
late int? wishlist;
late int? lastBid;

  Data2(
     );

  Data2.fromJson(Map<String, dynamic> json) {
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
    auctionFrom = json['auction_from'];
    auctionTo = json['auction_to'];

    language = json['language'];
    bidsCount = json['bids_count']??0;
    topBid =
    json['top_bid'] != null ? new TopBid.fromJson(json['top_bid']) : null;
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
    data['auction_from'] = this.auctionFrom;
    data['auction_to'] = this.auctionTo;

    data['language'] = this.language;
    data['bids_count'] = this.bidsCount;
    if (this.topBid != null) {
      data['top_bid'] = this.topBid!.toJson();
    }
    data['wishlist'] = this.wishlist;
    data['last_bid'] = this.lastBid;
    return data;
  }
}

class TopBid {
late  int? id;
late  int? userId;
late  int? auctionId;
late  int? amount;
late  int? status;
late  String? createdAt;
late  String? updatedAt;
late  String? deletedAt;
late  User? user;

  TopBid(
     );

  TopBid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    auctionId = json['auction_id'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['auction_id'] = this.auctionId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
 late int? id;
 late int? userId;
 late String? userNo;
 late String? name;
 late String? mobile;
 late String? whatsapp;
 late String? email;
 late String? address;
 late int? cityId;
 late String? district;
 late String? photo;
 late String? createdAt;
 late String? updatedAt;
 late String? deletedAt;

  User(
      );

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userNo = json['user_no'];
    name = json['name'];
    mobile = json['mobile'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    address = json['address'];
    cityId = json['city_id'];
    district = json['district'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_no'] = this.userNo;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['whatsapp'] = this.whatsapp;
    data['email'] = this.email;
    data['address'] = this.address;
    data['city_id'] = this.cityId;
    data['district'] = this.district;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Links {
 late String? url;
 late String? label;
 late bool? active;

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



class singleAucations_Model {
late  bool? status;
late String? messageEn;
late String? messageAr;
late  singleAuctionData data;
late  int? code;

  singleAucations_Model();

  singleAucations_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data =  singleAuctionData.fromJson(json['data']) ;
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

class singleAuctionData {
  late  int? id;
  late  int? userId;
  late  int categoryId;
  late  int? typeId;
  late  int? cityId;
  late  String? title;
  late  String? titleAr;
  late  String? description;
  late  String? descriptionAr;
  late  String? price;
  late  String? vedio;
  late  String? vedio_thumb;
  late  String? minBid;
  late int? status;
  late String? photo;
  late int? views;
  late  String? auctionFrom;
  late  String? auctionTo;
  late  String? createdAt;
  late  String? updatedAt;
  late  String? language;
  late  String? deletedAt;
  late  int bidsCount;
  late int? wishlist;
  late num? lastBid;
  late User? user;
  late Category? category;
  late Type? type;
  late  List<Images>? images;
  late List<SimilarAuctions> similarAuctions;
  late List<Bidders> bidders;
  late List<Features>? features;

  singleAuctionData();

  singleAuctionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    typeId = json['type_id'];
    cityId = json['city_id'];
    title = json['title'];
    vedio = json['vedio'];
    titleAr = json['title_ar'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    price = json['price'];
    minBid = json['min_bid'];
    vedio_thumb = json['vedio_thumb'];
    language = json['language'];
    status = json['status'];
    photo = json['photo'];
    views = json['views'];
    auctionFrom = json['auction_from'];
    auctionTo = json['auction_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    bidsCount = json['bids_count']??0;
    wishlist = json['wishlist'];
    lastBid = json['last_bid'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['similar_auctions'] != null) {
      similarAuctions = <SimilarAuctions>[];
      json['similar_auctions'].forEach((v) {
        similarAuctions!.add(new SimilarAuctions.fromJson(v));
      });
    }
    if (json['bidders'] != null) {
      bidders = <Bidders>[];
      json['bidders'].forEach((v) {
        bidders!.add(new Bidders.fromJson(v));
      });
    }
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
    data['vedio'] = this.vedio;
    data['vedio_thumb'] = this.vedio_thumb;
    data['description_ar'] = this.descriptionAr;
    data['price'] = this.price;
    data['language'] = this.language;
    data['min_bid'] = this.minBid;
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['views'] = this.views;
    data['auction_from'] = this.auctionFrom;
    data['auction_to'] = this.auctionTo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['bids_count'] = this.bidsCount;
    data['wishlist'] = this.wishlist;
    data['last_bid'] = this.lastBid;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.similarAuctions != null) {
      data['similar_auctions'] =
          this.similarAuctions!.map((v) => v.toJson()).toList();
    }
    if (this.bidders != null) {
      data['bidders'] = this.bidders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Features {
  late  int? id;
  late  int? advertisementId;
  late  String? key;
  late  String? value;
  late  String? createdAt;
  late  String? updatedAt;
  late  String? deletedAt;

  Features(
      );

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertisementId = json['advertisement_id'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advertisement_id'] = this.advertisementId;
    data['key'] = this.key;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class User {
  late  int? id;
  late  int? userId;
  late  String? userNo;
  late  String? name;
  late  String? mobile;
  late  String? whatsapp;
  late  String? email;
  late  String? address;
  late  int? cityId;
  late  String? district;
  late String? photo;
  late String? createdAt;
  late  String? updatedAt;
  late String? deletedAt;

  User();

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

class Category {
  late int id;
  late String name;
  late String name_ar;
  late String description;
  late String icon;
  // late int parentId;

  Category();

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_ar = json['name_ar'];
    description = json['description'];
    icon = json['icon'];
    // parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.name_ar;
    data['description'] = this.description;
    data['icon'] = this.icon;
    // data['parent_id'] = this.parentId;
    return data;
  }
}

class Type {
  late  int? id;
  // late  int? categoryId;
  late String? name;

  Type();

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // categoryId = json['category_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // data['category_id'] = this.categoryId;
    data['name'] = this.name;
    return data;
  }
}

class Images {
  late int? id;
  // late int? auctionId;
  late String? photo;


  Images();

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // auctionId = json['auction_id'];
    photo = json['photo'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // data['auction_id'] = this.auctionId;
    data['photo'] = this.photo;

    return data;
  }
}

class SimilarAuctions {
  late int? id;
  late int? userId;
  late int? categoryId;
  late int? typeId;
  late  int? cityId;
  late  String? title;
  late String? titleAr;
  late String? description;
  late String? descriptionAr;
  late String? price;
  late String? minBid;
  late int? status;
  late String? photo;
  late int? views;
  late String? auctionFrom;
  late String? auctionTo;
  late String? createdAt;
  late String? updatedAt;
  late String? deletedAt;
  late int? wishlist;
  late int? lastBid;

  SimilarAuctions();

  SimilarAuctions.fromJson(Map<String, dynamic> json) {
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

class Bidders {
  late int? id;
  late  int? userId;
  late int? amount;
  late String? time;
  late  User? user;

  Bidders();

  Bidders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = int.parse(json['user_id'].toString());
    amount = json['amount'];
    time = json['time']??'';
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    // data['status'] = this.status;
    data['time'] = this.time;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

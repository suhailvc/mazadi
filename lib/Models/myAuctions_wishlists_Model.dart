class myAuctions_wishlists_Model {
late  bool status;
late  String messageEn;
late  String messageAr;
late  List<likedAuctionData> data;
late  int code;

  myAuctions_wishlists_Model(
     );

  myAuctions_wishlists_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    if (json['data'] != null) {
      data = <likedAuctionData>[];
      json['data'].forEach((v) {
        data!.add(new likedAuctionData.fromJson(v));
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

class likedAuctionData {
late int id;
late int userId;
late String? advertisementId;
//todo--> String to int
late int? auctionId;
late String? createdAt;
late String? updatedAt;
late Auction? auction;

  likedAuctionData(
);

  likedAuctionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    advertisementId = json['advertisement_id'];
    auctionId = json['auction_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    auction =
    json['auction'] != null ? new Auction.fromJson(json['auction']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['advertisement_id'] = this.advertisementId;
    data['auction_id'] = this.auctionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.auction != null) {
      data['auction'] = this.auction!.toJson();
    }
    return data;
  }
}

class Auction {
late  int? id;
late  int? userId;
late  int? categoryId;
late  int? typeId;
late  int? cityId;
late  String? title;
late  String? titleAr;
late  String? description;
late  String? descriptionAr;
late  String? price;
late  String? minBid;
late  int? status;
late  String? photo;
late  int? views;
late  String? auctionFrom;
late  String? auctionTo;
late  String? createdAt;
late  String? updatedAt;
late  String? deletedAt;
late  int? wishlist;
late  int? lastBid;

  Auction(
  );

  Auction.fromJson(Map<String, dynamic> json) {
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

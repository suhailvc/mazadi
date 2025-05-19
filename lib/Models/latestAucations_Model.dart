class latestAucations_Model {
  late bool status;
  late  String messageEn;
  late  String messageAr;
  late  Data data;
  late  int code;

  latestAucations_Model();

  latestAucations_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data = new Data.fromJson(json['data']);
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
  late int currentPage;
  late List<Data2> data;
  // late String firstPageUrl;
  // late int? from;
  // late int? lastPage;
  // late  String lastPageUrl;
  // late  List<Links> links;
  late  String? nextPageUrl;
  // late  String? path;
  // late  int? perPage;
  // late  String? prevPageUrl;
  // late  int? to;
  // late  int? total;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data2>[];
      json['data'].forEach((v) {
        data!.add(new Data2.fromJson(v));
      });
    }
    // firstPageUrl = json['first_page_url'];
    // from = json['from'];
    // lastPage = json['last_page'];
    // lastPageUrl = json['last_page_url'];
    // if (json['links'] != null) {
    //   links = <Links>[];
    //   json['links'].forEach((v) {
    //     links!.add(new Links.fromJson(v));
    //   });
    // }
    nextPageUrl = json['next_page_url'];
    // path = json['path'];
    // perPage = json['per_page'];
    // prevPageUrl = json['prev_page_url'];
    // to = json['to'];
    // total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    // data['first_page_url'] = this.firstPageUrl;
    // data['from'] = this.from;
    // data['last_page'] = this.lastPage;
    // data['last_page_url'] = this.lastPageUrl;
    // if (this.links != null) {
    //   data['links'] = this.links!.map((v) => v.toJson()).toList();
    // }
    data['next_page_url'] = this.nextPageUrl;
    // data['path'] = this.path;
    // data['per_page'] = this.perPage;
    // data['prev_page_url'] = this.prevPageUrl;
    // data['to'] = this.to;
    // data['total'] = this.total;
    return data;
  }
}

class Data2 {
  late  int id;
  late  int userId;
  late  int categoryId;
  late  int typeId;
  late  int cityId;
  late  String title;
  late  String titleAr;
  late  String description;
  late String descriptionAr;
  late String price;
  late String minBid;
  late  int status;
  late  String? photo;
  late  int views;
  late  String auctionFrom;
  late  String auctionTo;
  late  String createdAt;
  late  String? updatedAt;
  late  String? deletedAt;
  late  int? bidsCount;
  late  int? wishlist;
  late  int? lastBid;

  Data2();

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
    views = json['views'];
    auctionFrom = json['auction_from'];
    auctionTo = json['auction_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    bidsCount = json['bids_count'];
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
    data['bids_count'] = this.bidsCount;
    data['wishlist'] = this.wishlist;
    data['last_bid'] = this.lastBid;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

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

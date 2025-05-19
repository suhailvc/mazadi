class singleAdvertisement_Model {
 late bool? status;
 late String? messageEn;
 late String? messageAr;
 late AdvData data;
 late int? isFavorit;
 late int? code;

  singleAdvertisement_Model(
    );

  singleAdvertisement_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data =  new AdvData.fromJson(json['data']) ;
    isFavorit = json['is_favorit'];
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
    data['is_favorit'] = this.isFavorit;
    data['code'] = this.code;
    return data;
  }
}

class AdvData {
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
late String? language;
late String? deletedAt;
late int? commentsCount;
late int? wishlist;
late User? user;
late Category? category;
late Type? type;
late List<Images>? images;
late List<SimilarAdvertisements>? similarAdvertisements;
late List<Features>? features;
late List<Comments2> comments;

  AdvData(
    );

  AdvData.fromJson(Map<String, dynamic> json) {
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
    language = json['language'];
    views = json['views'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    commentsCount = json['comments_count'];
    wishlist = json['wishlist'];
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
    if (json['similar_advertisements'] != null) {
      similarAdvertisements = <SimilarAdvertisements>[];
      json['similar_advertisements'].forEach((v) {
        similarAdvertisements!.add(new SimilarAdvertisements.fromJson(v));
      });
    }
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments2>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments2.fromJson(v));
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
    if (this.similarAdvertisements != null) {
      data['similar_advertisements'] =
          this.similarAdvertisements!.map((v) => v.toJson()).toList();
    }
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
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

class Category {
 late int? id;
 late String? name;
 late String? name_ar;
 late String? description;
 late String? icon;
 late int? parentId;
 late Parent? parent;

  Category(
     );

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_ar = json['name_ar'];
    description = json['description'];
    icon = json['icon'];
    parentId = json['parent_id'];
    parent = json['parent'] != null
        ? new Parent.fromJson(json['parent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.name_ar;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['parent_id'] = this.parentId;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}
class Parent {
 late int? id;
 late String? name;
 late String? name_ar;
 late String? description;
 late String? icon;
 late int? parentId;

 Parent(
     );

 Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_ar = json['name_ar'];
    description = json['description'];
    icon = json['icon'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.name_ar;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['parent_id'] = this.parentId;
    return data;
  }
}

class Type {
 late int? id;
 late int? categoryId;
 late String? name;

  Type();

  Type.fromJson(Map<String, dynamic> json) {
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

class Images {
late  int? id;
late  int? advertisementId;
late  String? photo;


  Images(
  );

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertisementId = json['advertisement_id'];
    photo = json['photo'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advertisement_id'] = this.advertisementId;
    data['photo'] = this.photo;

    return data;
  }
}

class SimilarAdvertisements {
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
late  int? status;
late  String? photo;
late  int? views;
late  String? createdAt;
late  String? updatedAt;
late  Null? deletedAt;
late  int? wishlist;
late  List<Comments2>? comments;

  SimilarAdvertisements(
  );

  SimilarAdvertisements.fromJson(Map<String, dynamic> json) {
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
    if (json['comments'] != null) {
      comments = <Comments2>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments2.fromJson(v));
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
    data['description_ar'] = this.descriptionAr;
    data['price'] = this.price;
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['views'] = this.views;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['wishlist'] = this.wishlist;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
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

class Comments2 {
late int? id;
late int? userId;
late int? advertisementId;
late String? comment;
late String? parent;
late String? createdAt;

late User? user;

  Comments2(
    );

  Comments2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    advertisementId = json['advertisement_id'];
    comment = json['comment'];
    parent = json['parent'];
    createdAt = json['created_at'];

    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['advertisement_id'] = this.advertisementId;
    data['comment'] = this.comment;
    data['parent'] = this.parent;
    data['created_at'] = this.createdAt;

    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

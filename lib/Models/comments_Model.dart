

import 'package:mazzad/Models/profile_Model.dart';

class comments_Model {
 late bool status;
 late String messageEn;
 late String messageAr;
 late List<CommentData> data;
 late int code;

  comments_Model();

  comments_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    if (json['data'] != null) {
      data = <CommentData>[];
      json['data'].forEach((v) {
        data.add(new CommentData.fromJson(v));
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
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class CommentData {
late  int id;
 late String comment;
late  String createdAt;
late  String time;
late  User user;
//todo -> get List of replies
List<Replies> replies = [];

CommentData();

CommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    comment = json['comment'];
    time = json['time']??'';
    createdAt = json['created_at'];

    user = (json['user'] != null ? new User.fromJson(json['user']) : null)!;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies.add(new Replies.fromJson(v));
      });
    }
  }

Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['comment'] = this.comment;
    data['time'] = this.time;
    data['created_at'] = this.createdAt;

    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class User {
 late int id;
 late int userId;
 late String userNo;
 late String name;
 late String? mobile;
 late String? whatsapp;
late  String email;
 late String address;
 late int cityId;
 late String district;
 late String photo;
 late String createdAt;
 late String updatedAt;
 int status=0;
 int isReseller =0;


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

    status = json['status']??0;

    isReseller = json['isReseller']??0;
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
    data['status'] = this.status;
    data['isReseller'] = this.isReseller;
    return data;
  }
}

class Replies {
 late int id;
 late String comment;
 late String createdAt;
 // late String time;
 late  User? user;

  Replies({
   required this.comment,
   required this.createdAt,
   required this.user,
});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    // time = json['time'];
    createdAt = json['created_at'];
    user = (json['user'] != null ? new User.fromJson(json['user']) : null)!;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    // data['time'] = this.time;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

import 'package:mazzad/Models/comments_Model.dart';

class profile_Model {
late  bool? status;
late  String? messageEn;
late  String? messageAr;
late  User data;
late  int? code;

  profile_Model(
    );

  profile_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data =  new User.fromJson(json['data']) ;
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


/*
class profile_Model2 {
late  bool? status;
late  String? messageEn;
late  String? messageAr;
late  User2 data;
late  int? code;

profile_Model2(
    );

profile_Model2.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data =  new User2.fromJson(json['data']) ;
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
class User2 {
  late int id;
  late int userId;
  late String userNo;
  late String name;
  late String mobile;
  late String? whatsapp;
  late  String email;
  late String address;
  late int cityId;
  late String district;
  late String photo;
  late String createdAt;
  late String updatedAt;
  late UserData userData;


  User2(
      );

  User2.fromJson(Map<String, dynamic> json) {
    userData =  new UserData.fromJson(json['user']) ;

    id = json['id'];
    userId = json['id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['user'] = this.userData!.toJson();
    }
    data['id'] = this.id;
    data['id'] = this.userId;
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
    return data;
  }
}

class UserData {
  late int status;




  UserData(
      );

  UserData.fromJson(Map<String, dynamic> json) {

    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['status'] = this.status;

    return data;
  }
}


 */

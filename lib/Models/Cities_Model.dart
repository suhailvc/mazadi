import 'package:flutter/cupertino.dart';

class Cities_Model {
late  bool? status;
late  String? messageEn;
late  String? messageAr;
late  List<cityData>? data;
late  int? code;
TextEditingController CityEditingController=TextEditingController();
String CityGroupValue='';

  Cities_Model();

  Cities_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    if (json['data'] != null) {
      data = <cityData>[];
      json['data'].forEach((v) {
        data!.add(new cityData.fromJson(v));
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

class cityData {
 late int? id;
 late int? countryId;
 late String? name;
 late String? nameAr;
 late String? deliveryPrice;
 late String? createdAt;
 late String? updatedAt;
 late String? deletedAt;

  cityData(
 );

  cityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    nameAr = json['name_ar'];
    deliveryPrice = json['delivery_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['delivery_price'] = this.deliveryPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

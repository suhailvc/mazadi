import 'package:flutter/cupertino.dart';

class getCategory_featuresQ_Model {
 late bool status;
 late String messageEn;
 late String messageAr;
 late List<Data> data;
 late int code;

  getCategory_featuresQ_Model(
    );

  getCategory_featuresQ_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
 late int? id;
 late String title;
 late int categoryId;
 late String createdAt;
 late String? updatedAt;
 late String? deletedAt;
 late String? type;
  String groupValue='';
 late List<String>? choices;

 TextEditingController textEditingController=TextEditingController();

  Data(
    );

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    type = json['type'];
    choices =json['choices']!=null? json['choices'].cast<String>():json['choices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['type'] = this.type;
    data['choices'] = this.choices;
    return data;
  }
}

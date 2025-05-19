class myAddress_Model {
 late bool status;
 late String messageEn;
 late String messageAr;
 late List<Data> data;
 late int code;

  myAddress_Model();

  myAddress_Model.fromJson(Map<String, dynamic> json) {
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
 late int id;
 late int userId;
 late String name;
 late String mobile;
 late int cityId;
 late String address;
 late String district;
 late String createdAt;
 late String updatedAt;
 late String? deletedAt;

  Data(
  );

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    mobile = json['mobile'];
    cityId = json['city_id'];
    address = json['address'];
    district = json['district'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['city_id'] = this.cityId;
    data['address'] = this.address;
    data['district'] = this.district;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

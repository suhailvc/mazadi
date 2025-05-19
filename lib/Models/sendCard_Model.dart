class sendCard_Model {
late  bool status;
late  String messageEn;
late  String messageAr;
late  cardData? data;
late  int code;

  sendCard_Model(
     );

  sendCard_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data = (json['data'] != null ? new cardData.fromJson(json['data']) : null)!;
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

class cardData {
 late int id;
 late String code;
 late String amount;
 late int status;
 late int userId;
 late String createdAt;
 late String updatedAt;

  cardData();

  cardData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

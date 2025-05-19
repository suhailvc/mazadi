class myTransactions_Model {
 late bool status;
 late String messageEn;
 late String messageAr;
 late List<Data> data;
 late int code;

  myTransactions_Model(
      );

  myTransactions_Model.fromJson(Map<String, dynamic> json) {
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
 late int walletId;
 late int userId;
 late String amount;
 late int type;
 late String createdAt;
 late String updatedAt;
 late String? deletedAt;

  Data(
  );

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletId = json['wallet_id'];
    userId = json['user_id'];
    amount = json['amount'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wallet_id'] = this.walletId;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

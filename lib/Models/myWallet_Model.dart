class myWallet_Model {
 late bool? status;
 late String? messageEn;
 late String? messageAr;
 late walletData data;
 late int? code;

  myWallet_Model(
      );

  myWallet_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data =  new walletData.fromJson(json['data']) ;
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

class walletData {
 late num total;
 late num? blocked;
 late num free;
 late List<Transactions>? transactions;

  walletData();

  walletData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    blocked = json['blocked'];
    free = json['free'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['blocked'] = this.blocked;
    data['free'] = this.free;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
 late int? id;
 late int? userId;
 late String? amount;
 late String? type;
 late String? createdAt;


  Transactions(
      );

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    type = json['type'];
    createdAt = json['created_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;

    return data;
  }
}

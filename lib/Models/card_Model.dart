class card_Model {
late  bool status;
 late String messageEn;
 late String messageAr;
 late List<cardData> data;
 late int code;

  card_Model(
     );

  card_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    if (json['data'] != null) {
      data = <cardData>[];
      json['data'].forEach((v) {
        data.add(new cardData.fromJson(v));
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

class cardData {
 late int amount;


  cardData(
 );

  cardData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;

    return data;
  }
}

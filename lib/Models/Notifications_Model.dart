class Notifications_Model {
 late bool status;
 late String messageEn;
 late String messageAr;
 late List<Data>? data;
 late int code;

  Notifications_Model();

  Notifications_Model.fromJson(Map<String, dynamic> json) {
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
 late String? advertisement_id;
 late String? auction_id;
 late List<Data2>? data;
 late String? time;

  Data(
     );

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertisement_id = json['advertisement_id'];
    auction_id = json['auction_id'];
    time = json['time'];
    if (json['data'] != null) {
      data = <Data2>[];
      json['data'].forEach((v) {
        data!.add(new Data2.fromJson(v));
      });
    }
    time = json['time']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advertisement_id'] = this.advertisement_id;
    data['auction_id'] = this.auction_id;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data2 {
 late String title;
 late String body;

  Data2();

  Data2.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

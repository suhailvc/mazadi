
class general_Model {
late  bool status;
late  String messageEn;
late  String messageAr;
late  int code;

  general_Model();

  general_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message_en'] = this.messageEn;
    data['message_ar'] = this.messageAr;

    data['code'] = this.code;
    return data;
  }
}
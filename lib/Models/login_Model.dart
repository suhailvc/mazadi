class login_Model {
late  bool status;
late  String messageEn;
late  String messageAr;
late  String? accessToken;
late  int code;

  login_Model(
     );

  login_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    accessToken = json['accessToken'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message_en'] = this.messageEn;
    data['message_ar'] = this.messageAr;
    data['accessToken'] = this.accessToken;
    data['code'] = this.code;
    return data;
  }
}

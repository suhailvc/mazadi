
class mobile_OTPCode_Model {
 late bool status;
 late String messageEn;
 late String messageAr;
 late int verifyMobileCode;
 late int code;

  mobile_OTPCode_Model();

  mobile_OTPCode_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    verifyMobileCode = json['verify_mobile_code'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message_en'] = this.messageEn;
    data['message_ar'] = this.messageAr;
    data['verify_mobile_code'] = this.verifyMobileCode;
    data['code'] = this.code;
    return data;
  }
}

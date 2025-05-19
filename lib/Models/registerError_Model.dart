class registerError_Model {

late  bool? status;
late  String? messageEn;
late  String? messageAr;
late  Errors? errors;
late  int? code;

  registerError_Model(
   );

  registerError_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message_en'] = this.messageEn;
    data['message_ar'] = this.messageAr;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Errors {
late  List? mobile;
late  List? email;

  Errors();

  Errors.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}

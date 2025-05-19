class AucationsCategory_Model {
late bool status;
late String messageEn;
late String messageAr;
late List<Data> data;
late int code;

  AucationsCategory_Model(
      );

  AucationsCategory_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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
late  int id;
late  String name;
late  String name_ar;
late  String description;
late  String icon;
// late  String parentId;
bool isSelected =false;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_ar = json['name_ar'];
    description = json['description'];
    icon = json['icon'];
    // parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.name_ar;
    data['description'] = this.description;
    data['icon'] = this.icon;
    // data['parent_id'] = this.parentId;
    return data;
  }
}

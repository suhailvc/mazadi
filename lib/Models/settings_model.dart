
class setting_Model {
late  bool status;
late String messageEn;
late String messageAr;
late  Data data;
late  int code;

  setting_Model(
    );

  setting_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageEn = json['message_en'];
    messageAr = json['message_ar'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message_en'] = this.messageEn;
    data['message_ar'] = this.messageAr;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  late String auctionRatio;
  late String auctionRatioMax;
  late String auctionBidRation;
  late String fixed_fees;
   String terms ='';
   String whatsapp ='';
   String email ='';

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    auctionRatio = json['auction_ratio'];
    auctionRatioMax = json['auction_ratio_max'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    terms = json['terms'];
    fixed_fees = json['fixed_fees'];
    auctionBidRation = json['auction_bid_ration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auction_ratio'] = this.auctionRatio;
    data['auction_ratio_max'] = this.auctionRatioMax;
    data['fixed_fees'] = this.fixed_fees;
    data['auction_bid_ration'] = this.auctionBidRation;
    data['whatsapp'] = this.whatsapp;
    data['email'] = this.email;
    data['terms'] = this.terms;
    return data;
  }
}

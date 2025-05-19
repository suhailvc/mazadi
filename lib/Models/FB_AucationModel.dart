
class FB_AucationModel{
  late int AucationID;
  late int LastBid;
  FB_AucationModel();

  FB_AucationModel.fromJson(Map<String, dynamic> json) {
    AucationID = json['aucationID'];
    LastBid = json['lastPrice'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aucationID'] = this.AucationID;
    data['lastPrice'] = this.LastBid;

    return data;
  }

}
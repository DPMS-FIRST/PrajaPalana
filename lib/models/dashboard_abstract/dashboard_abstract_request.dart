class DashboardAbstractRequest {
  String? iTOKENID;
  String? userid;
  String? dISTID;
  int? paNMUNID;

  DashboardAbstractRequest(
      {this.iTOKENID, this.userid, this.dISTID, this.paNMUNID});

  DashboardAbstractRequest.fromJson(Map<String, dynamic> json) {
    iTOKENID = json['i_TOKENID'];
    userid = json['userid'];
    dISTID = json['distid'];
    paNMUNID = json['paN_MUN_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i_TOKENID'] = this.iTOKENID;
    data['userid'] = this.userid;
    data['distid'] = this.dISTID;
    data['paN_MUN_ID'] = this.paNMUNID;
    return data;
  }
}

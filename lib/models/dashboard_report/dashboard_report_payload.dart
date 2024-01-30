class DashboardReportPayload {
  String? iTOKENID;
  String? userid;
  int? distid;
  String? paNMUNID;

  DashboardReportPayload(
      {this.iTOKENID, this.userid, this.distid, this.paNMUNID});

  DashboardReportPayload.fromJson(Map<String, dynamic> json) {
    iTOKENID = json['i_TOKENID'];
    userid = json['userid'];
    distid = json['distid'];
    paNMUNID = json['paN_MUN_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i_TOKENID'] = this.iTOKENID;
    data['userid'] = this.userid;
    data['distid'] = this.distid;
    data['paN_MUN_ID'] = this.paNMUNID;
    return data;
  }
}

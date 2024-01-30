class ApplicationSchemewisePayload {
  String? iTOKENID;
  String? userid;
  int? distid;
  int? idd;

  ApplicationSchemewisePayload(
      {this.iTOKENID, this.userid, this.distid, this.idd});

  ApplicationSchemewisePayload.fromJson(Map<String, dynamic> json) {
    iTOKENID = json['i_TOKENID'];
    userid = json['userid'];
    distid = json['distid'];
    idd = json['idd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i_TOKENID'] = this.iTOKENID;
    data['userid'] = this.userid;
    data['distid'] = this.distid;
    data['idd'] = this.idd;
    return data;
  }
}

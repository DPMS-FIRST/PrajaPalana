class ApplicationSearchAnyPayload {
  String? iTOKENID;
  String? panchayatid;
  String? userid;
  String? any;
  int? distid;

  ApplicationSearchAnyPayload(
      {this.iTOKENID, this.panchayatid, this.userid, this.any, this.distid});

  ApplicationSearchAnyPayload.fromJson(Map<String, dynamic> json) {
    iTOKENID = json['i_TOKENID'];
    panchayatid = json['panchayatid'];
    userid = json['userid'];
    any = json['any'];
    distid = json['distid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i_TOKENID'] = this.iTOKENID;
    data['panchayatid'] = this.panchayatid;
    data['userid'] = this.userid;
    data['any'] = this.any;
    data['distid'] = this.distid;
    return data;
  }
}

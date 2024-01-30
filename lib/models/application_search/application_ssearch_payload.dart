class ApplicationSearchPayload {
  String? iTOKENID;
  String? userid;
  String? distid;
  String? aadhaRNO;
  String? applicantmobileNumber;
  String? ratioNCARDNO;
  String? applicantName;
  String? onlinEAPPLICATIONNO;
  String? panMun;
  String? id;
  String? ptype;

  ApplicationSearchPayload(
      {this.iTOKENID,
      this.userid,
      this.distid,
      this.aadhaRNO,
      this.applicantmobileNumber,
      this.ratioNCARDNO,
      this.applicantName,
      this.onlinEAPPLICATIONNO,
      this.panMun,
      this.id,
      this.ptype});

  ApplicationSearchPayload.fromJson(Map<String, dynamic> json) {
    iTOKENID = json['i_TOKENID'];
    userid = json['userid'];
    distid = json['distid'];
    aadhaRNO = json['aadhaR_NO'];
    applicantmobileNumber = json['applicantmobileNumber'];
    ratioNCARDNO = json['ratioN_CARD_NO'];
    applicantName = json['applicantName'];
    onlinEAPPLICATIONNO = json['onlinE_APPLICATION_NO'];
    panMun = json['pan_mun'];
    id = json['id'];
    ptype = json['ptype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i_TOKENID'] = this.iTOKENID;
    data['userid'] = this.userid;
    data['distid'] = this.distid;
    data['aadhaR_NO'] = this.aadhaRNO;
    data['applicantmobileNumber'] = this.applicantmobileNumber;
    data['ratioN_CARD_NO'] = this.ratioNCARDNO;
    data['applicantName'] = this.applicantName;
    data['onlinE_APPLICATION_NO'] = this.onlinEAPPLICATIONNO;
    data['pan_mun'] = this.panMun;
    data['id'] = this.id;
    data['ptype'] = this.ptype;
    return data;
  }
}

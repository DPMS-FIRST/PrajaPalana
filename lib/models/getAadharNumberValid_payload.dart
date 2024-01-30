class GetAadharNumberValidPayload {
  String? mobileNumber;
  String? deviceId;
  String? iTOKENID;
  String? vCDEVICEID;
  String? districtid;
  String? panchayatid;
  String? iPaddress;
  String? userid;
  String? iMPIN;
  String? sessionID;
  String? onlinEAPPLICATIONNO;
  String? aadhaRNO;
  String? ratioNCARDNO;
  String? applicantmobileNumber;
  String? applicantName;
  String? applType;
  String? any;
  int? distid;
  int? panMun;
  int? idd;
  String? ptype;

  GetAadharNumberValidPayload(
      {this.mobileNumber,
      this.deviceId,
      this.iTOKENID,
      this.vCDEVICEID,
      this.districtid,
      this.panchayatid,
      this.iPaddress,
      this.userid,
      this.iMPIN,
      this.sessionID,
      this.onlinEAPPLICATIONNO,
      this.aadhaRNO,
      this.ratioNCARDNO,
      this.applicantmobileNumber,
      this.applicantName,
      this.applType,
      this.any,
      this.distid,
      this.panMun,
      this.idd,
      this.ptype});

  GetAadharNumberValidPayload.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    deviceId = json['deviceId'];
    iTOKENID = json['i_TOKENID'];
    vCDEVICEID = json['vC_DEVICEID'];
    districtid = json['districtid'];
    panchayatid = json['panchayatid'];
    iPaddress = json['iPaddress'];
    userid = json['userid'];
    iMPIN = json['i_MPIN'];
    sessionID = json['sessionID'];
    onlinEAPPLICATIONNO = json['onlinE_APPLICATION_NO'];
    aadhaRNO = json['aadhaR_NO'];
    ratioNCARDNO = json['ratioN_CARD_NO'];
    applicantmobileNumber = json['applicantmobileNumber'];
    applicantName = json['applicantName'];
    applType = json['appl_type'];
    any = json['any'];
    distid = json['distid'];
    panMun = json['pan_mun'];
    idd = json['idd'];
    ptype = json['ptype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['deviceId'] = this.deviceId;
    data['i_TOKENID'] = this.iTOKENID;
    data['vC_DEVICEID'] = this.vCDEVICEID;
    data['districtid'] = this.districtid;
    data['panchayatid'] = this.panchayatid;
    data['iPaddress'] = this.iPaddress;
    data['userid'] = this.userid;
    data['i_MPIN'] = this.iMPIN;
    data['sessionID'] = this.sessionID;
    data['onlinE_APPLICATION_NO'] = this.onlinEAPPLICATIONNO;
    data['aadhaR_NO'] = this.aadhaRNO;
    data['ratioN_CARD_NO'] = this.ratioNCARDNO;
    data['applicantmobileNumber'] = this.applicantmobileNumber;
    data['applicantName'] = this.applicantName;
    data['appl_type'] = this.applType;
    data['any'] = this.any;
    data['distid'] = this.distid;
    data['pan_mun'] = this.panMun;
    data['idd'] = this.idd;
    data['ptype'] = this.ptype;
    return data;
  }
}

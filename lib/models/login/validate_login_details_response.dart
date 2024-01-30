class ValidLoginDetailsResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  Data? data;

  ValidLoginDetailsResponse(
      {this.statusMessage, this.message, this.statusCode, this.data});

  ValidLoginDetailsResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    message = json['message'];
    statusCode = json['status_Code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['message'] = this.message;
    data['status_Code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? vCEMPID;
  String? vCEMPNAME;
  String? iMOBILENO;
  String? vCPASSWORD;
  String? vCDEVICEID;
  int? iOTP;
  String? vCNAME;
  String? vCLOCALITY;
  String? districtid;
  String? useRTYPE;
  String? panchayatid;
  String? vCIMAGE;
  String? vCROLE;
  String? iROLEID;
  String? vCROLECODE;
  String? vCDESIGNATION;
  String? iDESIGID;
  String? vCDESIGCODE;
  String? iTOKENID;
  String? userid;
  String? vCMAILID;
  int? iMPIN;
  String? statusmsg;
  String? message;
  String? image;

  Data(
      {this.vCEMPID,
      this.vCEMPNAME,
      this.iMOBILENO,
      this.vCPASSWORD,
      this.vCDEVICEID,
      this.iOTP,
      this.vCNAME,
      this.vCLOCALITY,
      this.districtid,
      this.useRTYPE,
      this.panchayatid,
      this.vCIMAGE,
      this.vCROLE,
      this.iROLEID,
      this.vCROLECODE,
      this.vCDESIGNATION,
      this.iDESIGID,
      this.vCDESIGCODE,
      this.iTOKENID,
      this.userid,
      this.vCMAILID,
      this.iMPIN,
      this.statusmsg,
      this.message,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    vCEMPID = json['vC_EMPID'];
    vCEMPNAME = json['vC_EMPNAME'];
    iMOBILENO = json['i_MOBILENO'];
    vCPASSWORD = json['vC_PASSWORD'];
    vCDEVICEID = json['vC_DEVICEID'];
    iOTP = json['i_OTP'];
    vCNAME = json['vC_NAME'];
    vCLOCALITY = json['vC_LOCALITY'];
    districtid = json['districtid'];
    useRTYPE = json['useR_TYPE'];
    panchayatid = json['panchayatid'];
    vCIMAGE = json['vC_IMAGE'];
    vCROLE = json['vC_ROLE'];
    iROLEID = json['i_ROLEID'];
    vCROLECODE = json['vC_ROLECODE'];
    vCDESIGNATION = json['vC_DESIGNATION'];
    iDESIGID = json['i_DESIGID'];
    vCDESIGCODE = json['vC_DESIGCODE'];
    iTOKENID = json['i_TOKENID'];
    userid = json['userid'];
    vCMAILID = json['vC_MAILID'];
    iMPIN = json['i_MPIN'];
    statusmsg = json['statusmsg'];
    message = json['message'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vC_EMPID'] = this.vCEMPID;
    data['vC_EMPNAME'] = this.vCEMPNAME;
    data['i_MOBILENO'] = this.iMOBILENO;
    data['vC_PASSWORD'] = this.vCPASSWORD;
    data['vC_DEVICEID'] = this.vCDEVICEID;
    data['i_OTP'] = this.iOTP;
    data['vC_NAME'] = this.vCNAME;
    data['vC_LOCALITY'] = this.vCLOCALITY;
    data['districtid'] = this.districtid;
    data['useR_TYPE'] = this.useRTYPE;
    data['panchayatid'] = this.panchayatid;
    data['vC_IMAGE'] = this.vCIMAGE;
    data['vC_ROLE'] = this.vCROLE;
    data['i_ROLEID'] = this.iROLEID;
    data['vC_ROLECODE'] = this.vCROLECODE;
    data['vC_DESIGNATION'] = this.vCDESIGNATION;
    data['i_DESIGID'] = this.iDESIGID;
    data['vC_DESIGCODE'] = this.vCDESIGCODE;
    data['i_TOKENID'] = this.iTOKENID;
    data['userid'] = this.userid;
    data['vC_MAILID'] = this.vCMAILID;
    data['i_MPIN'] = this.iMPIN;
    data['statusmsg'] = this.statusmsg;
    data['message'] = this.message;
    data['image'] = this.image;
    return data;
  }
}

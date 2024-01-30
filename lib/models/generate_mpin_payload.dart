class GenerateMPINPayLoad {
  String? mobileNumber;
  String? deviceId;
  String? userid;
  String? iMPIN;
  String? iTOKENID;

  GenerateMPINPayLoad(
      {this.mobileNumber,
      this.deviceId,
      this.userid,
      this.iMPIN,
      this.iTOKENID});

  GenerateMPINPayLoad.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    deviceId = json['deviceId'];
    userid = json['userid'];
    iMPIN = json['i_MPIN'];
    iTOKENID = json['i_TOKENID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['deviceId'] = this.deviceId;
    data['userid'] = this.userid;
    data['i_MPIN'] = this.iMPIN;
    data['i_TOKENID'] = this.iTOKENID;
    return data;
  }
}

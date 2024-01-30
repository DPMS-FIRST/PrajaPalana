class ResendOtpPayload {
  String? mobileNumber;
  String? deviceId;
  String? userid;
  String? iTOKENID;

  ResendOtpPayload(
      {this.mobileNumber, this.deviceId, this.userid, this.iTOKENID});

  ResendOtpPayload.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    deviceId = json['deviceId'];
    userid = json['userid'];
    iTOKENID = json['i_TOKENID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['deviceId'] = this.deviceId;
    data['userid'] = this.userid;
    data['i_TOKENID'] = this.iTOKENID;
    return data;
  }
}

class ValidateMpinPayload {
  String? userid;
  String? mpin;
  String? tokenid;

  ValidateMpinPayload({this.userid, this.mpin, this.tokenid});

  ValidateMpinPayload.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    mpin = json['mpin'];
    tokenid = json['tokenid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['mpin'] = this.mpin;
    data['tokenid'] = this.tokenid;
    return data;
  }
}

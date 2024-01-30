/* class GetApplicantDetailsPayload {
  String? iTOKENID;
  String? userid;
  String? onlinEAPPLICATIONNO;

  GetApplicantDetailsPayload(
      {this.iTOKENID, this.userid, this.onlinEAPPLICATIONNO});

  GetApplicantDetailsPayload.fromJson(Map<String, dynamic> json) {
    iTOKENID = json['i_TOKENID'];
    userid = json['userid'];
    onlinEAPPLICATIONNO = json['onlinE_APPLICATION_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i_TOKENID'] = this.iTOKENID;
    data['userid'] = this.userid;
    data['onlinE_APPLICATION_NO'] = this.onlinEAPPLICATIONNO;
    return data;
  }
}
 */
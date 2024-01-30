class ConfigurableFieldsPayload {
  String? iTOKENID;
  String? userid;
  String? applType;

  ConfigurableFieldsPayload({this.iTOKENID, this.userid, this.applType});

  ConfigurableFieldsPayload.fromJson(Map<String, dynamic> json) {
    iTOKENID = json['i_TOKENID'];
    userid = json['userid'];
    applType = json['appl_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i_TOKENID'] = this.iTOKENID;
    data['userid'] = this.userid;
    data['appl_type'] = this.applType;
    return data;
  }
}

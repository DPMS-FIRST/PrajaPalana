class RegistrationResponse {
  List<UserInfo>? userInfo;
  int? statusCode;
  String? statusMessage;

  RegistrationResponse({this.userInfo, this.statusCode, this.statusMessage});

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    if (json['user_Info'] != null) {
      userInfo = <UserInfo>[];
      json['user_Info'].forEach((v) {
        userInfo!.add(new UserInfo.fromJson(v));
      });
    }
    statusCode = json['Status_Code'];
    statusMessage = json['Status_Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['user_Info'] = this.userInfo!.map((v) => v.toJson()).toList();
    }
    data['Status_Code'] = this.statusCode;
    data['Status_Message'] = this.statusMessage;
    return data;
  }
}

class UserInfo {
  String? userId;
  String? mobileNo;
  String? userName;
  String? image;
  String? tockenId;
  String? oTP;
  String? mPIN;

  UserInfo(
      {this.userId,
      this.mobileNo,
      this.userName,
      this.image,
      this.tockenId,
      this.oTP,
      this.mPIN});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['User_Id'];
    mobileNo = json['Mobile_No'];
    userName = json['User_Name'];
    image = json['Image'];
    tockenId = json['Tocken_Id'];
    oTP = json['OTP'];
    mPIN = json['MPIN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User_Id'] = this.userId;
    data['Mobile_No'] = this.mobileNo;
    data['User_Name'] = this.userName;
    data['Image'] = this.image;
    data['Tocken_Id'] = this.tockenId;
    data['OTP'] = this.oTP;
    data['MPIN'] = this.mPIN;
    return data;
  }
}

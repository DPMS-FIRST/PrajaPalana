class RegistrationPayload {
  String? mobileNo;
  String? userName;
  int? districtId;
  int? ulbID;
  String? image;
  String? deviceId;

  RegistrationPayload(
      {this.mobileNo,
      this.userName,
      this.districtId,
      this.ulbID,
      this.image,
      this.deviceId});

  RegistrationPayload.fromJson(Map<String, dynamic> json) {
    mobileNo = json['MobileNo'];
    userName = json['UserName'];
    districtId = json['DistrictId'];
    ulbID = json['UlbID'];
    image = json['Image'];
    deviceId = json['DeviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNo'] = this.mobileNo;
    data['UserName'] = this.userName;
    data['DistrictId'] = this.districtId;
    data['UlbID'] = this.ulbID;
    data['Image'] = this.image;
    data['DeviceId'] = this.deviceId;
    return data;
  }
}

class ValidLoginDetailsPayload {
  String? mobileNumber;
  String? deviceId;

  ValidLoginDetailsPayload({this.mobileNumber, this.deviceId});

  ValidLoginDetailsPayload.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['deviceId'] = this.deviceId;
    return data;
  }
}

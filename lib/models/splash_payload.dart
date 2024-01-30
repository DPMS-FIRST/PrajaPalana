class VersionCheckPayload {
  String? departmentName;
  String? deviceType;

  VersionCheckPayload({this.departmentName, this.deviceType});

  VersionCheckPayload.fromJson(Map<String, dynamic> json) {
    departmentName = json['departmentName'];
    deviceType = json['deviceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departmentName'] = this.departmentName;
    data['deviceType'] = this.deviceType;
    return data;
  }
}


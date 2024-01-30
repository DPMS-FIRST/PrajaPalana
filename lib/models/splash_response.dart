class VersionCheckResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  Data? data;

  VersionCheckResponse(
      {this.statusMessage, this.message, this.statusCode, this.data});

  VersionCheckResponse.fromJson(Map<String, dynamic> json) {
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
  String? versioNNO;
  String? lastupdateDDATE;
  String? version;
  String? message;
  String? androiDURL;
  String? ioSURL;
  String? iSACTIVE;
  String? versioNTYPE;
  String? departmentName;
  String? deviceType;

  Data(
      {this.versioNNO,
      this.lastupdateDDATE,
      this.version,
      this.message,
      this.androiDURL,
      this.ioSURL,
      this.iSACTIVE,
      this.versioNTYPE,
      this.departmentName,
      this.deviceType});

  Data.fromJson(Map<String, dynamic> json) {
    versioNNO = json['versioN_NO'];
    lastupdateDDATE = json['lastupdateD_DATE'];
    version = json['version'];
    message = json['message'];
    androiDURL = json['androiD_URL'];
    ioSURL = json['ioS_URL'];
    iSACTIVE = json['iS_ACTIVE'];
    versioNTYPE = json['versioN_TYPE'];
    departmentName = json['departmentName'];
    deviceType = json['deviceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['versioN_NO'] = this.versioNNO;
    data['lastupdateD_DATE'] = this.lastupdateDDATE;
    data['version'] = this.version;
    data['message'] = this.message;
    data['androiD_URL'] = this.androiDURL;
    data['ioS_URL'] = this.ioSURL;
    data['iS_ACTIVE'] = this.iSACTIVE;
    data['versioN_TYPE'] = this.versioNTYPE;
    data['departmentName'] = this.departmentName;
    data['deviceType'] = this.deviceType;
    return data;
  }
}

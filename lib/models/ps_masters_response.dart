class PSMastersResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  List<PSData>? psData;

  PSMastersResponse(
      {this.statusMessage, this.message, this.statusCode, this.psData});

  PSMastersResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    message = json['message'];
    statusCode = json['status_Code'];
    if (json['data'] != null) {
      psData = <PSData>[];
      json['data'].forEach((v) {
        psData!.add(new PSData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['message'] = this.message;
    data['status_Code'] = this.statusCode;
    if (this.psData != null) {
      data['data'] = this.psData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PSData {
  String? pSNAME;
  int? pSID;

  PSData({this.pSNAME, this.pSID});

  PSData.fromJson(Map<String, dynamic> json) {
    pSNAME = json['pS_NAME'];
    pSID = json['pS_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pS_NAME'] = this.pSNAME;
    data['pS_ID'] = this.pSID;
    return data;
  }
}

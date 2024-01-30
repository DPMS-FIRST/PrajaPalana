class GetRemarksResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  List<RemarksData>? data;

  GetRemarksResponse(
      {this.statusMessage, this.message, this.statusCode, this.data});

  GetRemarksResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    message = json['message'];
    statusCode = json['status_Code'];
    if (json['data'] != null) {
      data = <RemarksData>[];
      json['data'].forEach((v) {
        data!.add(new RemarksData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['message'] = this.message;
    data['status_Code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RemarksData {
  int? iREMARKSID;
  String? vCREMARKS;

  RemarksData({this.iREMARKSID, this.vCREMARKS});

  RemarksData.fromJson(Map<String, dynamic> json) {
    iREMARKSID = json['i_REMARKSID'];
    vCREMARKS = json['vC_REMARKS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i_REMARKSID'] = this.iREMARKSID;
    data['vC_REMARKS'] = this.vCREMARKS;
    return data;
  }
}

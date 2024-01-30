class DashboardReportResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  List<ReportsData>? data;

  DashboardReportResponse(
      {this.statusMessage, this.message, this.statusCode, this.data});

  DashboardReportResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    message = json['message'];
    statusCode = json['status_Code'];
    if (json['data'] != null) {
      data = <ReportsData>[];
      json['data'].forEach((v) {
        data!.add(new ReportsData.fromJson(v));
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

class ReportsData {
  String? name;
  int? count;
  String? pTYPE;

  ReportsData({this.name, this.count, this.pTYPE});

  ReportsData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
    pTYPE = json['p_TYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['count'] = this.count;
    data['p_TYPE'] = this.pTYPE;
    return data;
  }
}

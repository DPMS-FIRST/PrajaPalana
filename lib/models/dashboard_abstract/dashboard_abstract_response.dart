/* class DashboardAbstractResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  List<DashboardAbstractData>? data;

  DashboardAbstractResponse(
      {this.statusMessage, this.message, this.statusCode, this.data});

  DashboardAbstractResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    message = json['message'];
    statusCode = json['status_Code'];
    if (json['data'] != null) {
      data = <DashboardAbstractData>[];
      json['data'].forEach((v) {
        data!.add(new DashboardAbstractData.fromJson(v));
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

class DashboardAbstractData {
  String? name;
  String? count;
  String? displayflag;

  DashboardAbstractData({this.name, this.count, this.displayflag});

  DashboardAbstractData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
    displayflag = json['displayflag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['count'] = this.count;
    data['displayflag'] = this.displayflag;
    return data;
  }
}
 */
class DashboardAbstractResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  List<DashboardAbstractData>? data;

  DashboardAbstractResponse(
      {this.statusMessage, this.message, this.statusCode, this.data});

  DashboardAbstractResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    message = json['message'];
    statusCode = json['status_Code'];
    if (json['data'] != null) {
      data = <DashboardAbstractData>[];
      json['data'].forEach((v) {
        data!.add(new DashboardAbstractData.fromJson(v));
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

class DashboardAbstractData {
  String? name;
  int? count;
  String? pTYPE;

  DashboardAbstractData({this.name, this.count, this.pTYPE});

  DashboardAbstractData.fromJson(Map<String, dynamic> json) {
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

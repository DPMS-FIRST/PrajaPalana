class UlbsMasterResponse {
  List<Ulbs>? ulbs;
  int? statusCode;
  String? statusMessage;

  UlbsMasterResponse({this.ulbs, this.statusCode, this.statusMessage});

  UlbsMasterResponse.fromJson(Map<String, dynamic> json) {
    if (json['ulbs'] != null) {
      ulbs = <Ulbs>[];
      json['ulbs'].forEach((v) {
        ulbs!.add(new Ulbs.fromJson(v));
      });
    }
    statusCode = json['Status_Code'];
    statusMessage = json['Status_Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ulbs != null) {
      data['ulbs'] = this.ulbs!.map((v) => v.toJson()).toList();
    }
    data['Status_Code'] = this.statusCode;
    data['Status_Message'] = this.statusMessage;
    return data;
  }
}

class Ulbs {
  int? uLBID;
  String? uLBName;

  Ulbs({this.uLBID, this.uLBName});

  Ulbs.fromJson(Map<String, dynamic> json) {
    uLBID = json['ULB_ID'];
    uLBName = json['ULB_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ULB_ID'] = this.uLBID;
    data['ULB_Name'] = this.uLBName;
    return data;
  }
}

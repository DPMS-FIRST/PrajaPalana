class DistrictMasterResponse {
  List<Districts>? districts;
  int? statusCode;
  String? statusMessage;

  DistrictMasterResponse({this.districts, this.statusCode, this.statusMessage});

  DistrictMasterResponse.fromJson(Map<String, dynamic> json) {
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(new Districts.fromJson(v));
      });
    }
    statusCode = json['Status_Code'];
    statusMessage = json['Status_Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.districts != null) {
      data['districts'] = this.districts!.map((v) => v.toJson()).toList();
    }
    data['Status_Code'] = this.statusCode;
    data['Status_Message'] = this.statusMessage;
    return data;
  }
}

class Districts {
  int? districtID;
  String? districtName;

  Districts({this.districtID, this.districtName});

  Districts.fromJson(Map<String, dynamic> json) {
    districtID = json['District_ID'];
    districtName = json['District_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['District_ID'] = this.districtID;
    data['District_Name'] = this.districtName;
    return data;
  }
}

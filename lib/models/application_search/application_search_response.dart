class ApplicationSearchResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  ApplicationSearchData? data;

  ApplicationSearchResponse(
      {this.statusMessage, this.message, this.statusCode, this.data});

  ApplicationSearchResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    message = json['message'];
    statusCode = json['status_Code'];
    data = json['data'] != null ? new ApplicationSearchData.fromJson(json['data']) : null;
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

class ApplicationSearchData {
  List<ApplicationStatus>? applicationStatus;

  ApplicationSearchData({this.applicationStatus});

  ApplicationSearchData.fromJson(Map<String, dynamic> json) {
    if (json['applicationStatus'] != null) {
      applicationStatus = <ApplicationStatus>[];
      json['applicationStatus'].forEach((v) {
        applicationStatus!.add(new ApplicationStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.applicationStatus != null) {
      data['applicationStatus'] =
          this.applicationStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApplicationStatus {
  int? idd;
  String? onlinEAPPLICATIONNO;
  String? offlinEAPPLICATIONNO;
  String? applicanTNAME;
  String? gender;
  String? caste;
  String? datEOFBIRTH;
  String? aadhaRNO;
  String? ratioNCARDNO;
  String? mobilENO;
  String? occupation;
  String? type;
  String? housENO;
  String? warDNO;
  String? municipalityName;
  String? mandalName;
  String? districtName;
  String? panchayatName;
  String? status;
  String? dDUPLICATEAPPPLICANTS;

  ApplicationStatus(
      {this.idd,
      this.onlinEAPPLICATIONNO,
      this.offlinEAPPLICATIONNO,
      this.applicanTNAME,
      this.gender,
      this.caste,
      this.datEOFBIRTH,
      this.aadhaRNO,
      this.ratioNCARDNO,
      this.mobilENO,
      this.occupation,
      this.type,
      this.housENO,
      this.warDNO,
      this.municipalityName,
      this.mandalName,
      this.districtName,
      this.panchayatName,
      this.status,
      this.dDUPLICATEAPPPLICANTS});

  ApplicationStatus.fromJson(Map<String, dynamic> json) {
    idd = json['idd'];
    onlinEAPPLICATIONNO = json['onlinE_APPLICATION_NO'];
    offlinEAPPLICATIONNO = json['offlinE_APPLICATION_NO'];
    applicanTNAME = json['applicanT_NAME'];
    gender = json['gender'];
    caste = json['caste'];
    datEOFBIRTH = json['datE_OF_BIRTH'];
    aadhaRNO = json['aadhaR_NO'];
    ratioNCARDNO = json['ratioN_CARD_NO'];
    mobilENO = json['mobilE_NO'];
    occupation = json['occupation'];
    type = json['type'];
    housENO = json['housE_NO'];
    warDNO = json['warD_NO'];
    municipalityName = json['municipality_Name'];
    mandalName = json['mandalName'];
    districtName = json['districtName'];
    panchayatName = json['panchayatName'];
    status = json['status'];
    dDUPLICATEAPPPLICANTS = json['d_DUPLICATE_APPPLICANTS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idd'] = this.idd;
    data['onlinE_APPLICATION_NO'] = this.onlinEAPPLICATIONNO;
    data['offlinE_APPLICATION_NO'] = this.offlinEAPPLICATIONNO;
    data['applicanT_NAME'] = this.applicanTNAME;
    data['gender'] = this.gender;
    data['caste'] = this.caste;
    data['datE_OF_BIRTH'] = this.datEOFBIRTH;
    data['aadhaR_NO'] = this.aadhaRNO;
    data['ratioN_CARD_NO'] = this.ratioNCARDNO;
    data['mobilE_NO'] = this.mobilENO;
    data['occupation'] = this.occupation;
    data['type'] = this.type;
    data['housE_NO'] = this.housENO;
    data['warD_NO'] = this.warDNO;
    data['municipality_Name'] = this.municipalityName;
    data['mandalName'] = this.mandalName;
    data['districtName'] = this.districtName;
    data['panchayatName'] = this.panchayatName;
    data['status'] = this.status;
    data['d_DUPLICATE_APPPLICANTS'] = this.dDUPLICATEAPPPLICANTS;
    return data;
  }
}

class applicationStatusSearchResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  ApplicationStatusDetails? applicationStatusDetails;

  applicationStatusSearchResponse(
      {this.statusMessage, this.message, this.statusCode, this.applicationStatusDetails});

  applicationStatusSearchResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    message = json['message'];
    statusCode = json['status_Code'];
    applicationStatusDetails = json['data'] != null ? new ApplicationStatusDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['message'] = this.message;
    data['status_Code'] = this.statusCode;
    if (this.applicationStatusDetails != null) {
      data['data'] = this.applicationStatusDetails!.toJson();
    }
    return data;
  }
}

class ApplicationStatusDetails {
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

  ApplicationStatusDetails(
      {this.onlinEAPPLICATIONNO,
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
      this.status});

  ApplicationStatusDetails.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}

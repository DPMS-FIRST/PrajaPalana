class CheyutaSubmitLocalModel {
  List<CheyutaSubmitLocalData>? data;

  CheyutaSubmitLocalModel({this.data});

  CheyutaSubmitLocalModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CheyutaSubmitLocalData>[];
      json['data'].forEach((v) {
        data!.add(new CheyutaSubmitLocalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheyutaSubmitLocalData {
  String? familyID;
  String? schemeID;
  String? divyangulaSadaramID;
  String? widowDeathCertificateNumber;
  String? widowDateofDeath;
  String? toddyTapperRegistrationType;
  String? weaverCooperativeSociety;
  String? beediWorkerEPFEnrollmentNumber;
  String? beediWorkerEnrollemntDate;
  String? singleWomenCatgory;
  String? singleWomenDocuments;
  String? beediThekadarIndustryName;
  String? beediThekadarLicenseNumber;
  String? beediThekadarLicenceIssuedDate;
  String? beediThekadarValidUpto;
  String? enableFlag;

  CheyutaSubmitLocalData(
      {this.familyID,
      this.schemeID,
      this.divyangulaSadaramID,
      this.widowDeathCertificateNumber,
      this.widowDateofDeath,
      this.toddyTapperRegistrationType,
      this.weaverCooperativeSociety,
      this.beediWorkerEPFEnrollmentNumber,
      this.beediWorkerEnrollemntDate,
      this.singleWomenCatgory,
      this.singleWomenDocuments,
      this.beediThekadarIndustryName,
      this.beediThekadarLicenseNumber,
      this.beediThekadarLicenceIssuedDate,
      this.beediThekadarValidUpto,
      this.enableFlag});

  CheyutaSubmitLocalData.fromJson(Map<String, dynamic> json) {
    familyID = json['familyID'];
    schemeID = json['schemeID'];
    divyangulaSadaramID = json['Divyangula_SadaramID'];
    widowDeathCertificateNumber = json['Widow_death_certificate_number'];
    widowDateofDeath = json['Widow_dateofDeath'];
    toddyTapperRegistrationType = json['ToddyTapper_RegistrationType'];
    weaverCooperativeSociety = json['Weaver_cooperative_Society'];
    beediWorkerEPFEnrollmentNumber = json['BeediWorker_EPF_EnrollmentNumber'];
    beediWorkerEnrollemntDate = json['BeediWorker_Enrollemnt_Date'];
    singleWomenCatgory = json['SingleWomen_Catgory'];
    singleWomenDocuments = json['SingleWomen_Documents'];
    beediThekadarIndustryName = json['BeediThekadar_IndustryName'];
    beediThekadarLicenseNumber = json['BeediThekadar_LicenseNumber'];
    beediThekadarLicenceIssuedDate = json['BeediThekadar_LicenceIssuedDate'];
    beediThekadarValidUpto = json['BeediThekadar_ValidUpto'];
    enableFlag = json['Eligible_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyID'] = this.familyID;
    data['schemeID'] = this.schemeID;
    data['Divyangula_SadaramID'] = this.divyangulaSadaramID;
    data['Widow_death_certificate_number'] = this.widowDeathCertificateNumber;
    data['Widow_dateofDeath'] = this.widowDateofDeath;
    data['ToddyTapper_RegistrationType'] = this.toddyTapperRegistrationType;
    data['Weaver_cooperative_Society'] = this.weaverCooperativeSociety;
    data['BeediWorker_EPF_EnrollmentNumber'] =
        this.beediWorkerEPFEnrollmentNumber;
    data['BeediWorker_Enrollemnt_Date'] = this.beediWorkerEnrollemntDate;
    data['SingleWomen_Catgory'] = this.singleWomenCatgory;
    data['SingleWomen_Documents'] = this.singleWomenDocuments;
    data['BeediThekadar_IndustryName'] = this.beediThekadarIndustryName;
    data['BeediThekadar_LicenseNumber'] = this.beediThekadarLicenseNumber;
    data['BeediThekadar_LicenceIssuedDate'] =
        this.beediThekadarLicenceIssuedDate;
    data['BeediThekadar_ValidUpto'] = this.beediThekadarValidUpto;
    data['Eligible_flag'] = this.enableFlag;
    return data;
  }
}

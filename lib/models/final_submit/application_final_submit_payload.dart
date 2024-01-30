class ApplicationFinalSubmitPayload {
  PersonalDtlsMdlNew? personalDtlsMdl;
  List<FamilyListMdlNew>? familyListMdl;
  MahalakshmiMdlNew? mahalakshmiMdl;
  RaithubharosaMdlNew? raithubharosaMdl;
  IndirammaIndluMdlNew? indirammaIndluMdl;
  GruhajyothiMdlNew? gruhajyothiMdl;
  List<ListCheyuthaMdl>? listCheyuthaMdl;

  CheyuthaMdl? cheyuthaMdl;

  ApplicationFinalSubmitPayload(
      {this.personalDtlsMdl,
      this.familyListMdl,
      this.mahalakshmiMdl,
      this.raithubharosaMdl,
      this.indirammaIndluMdl,
      this.gruhajyothiMdl,
      this.cheyuthaMdl,
      this.listCheyuthaMdl});

  ApplicationFinalSubmitPayload.fromJson(Map<String, dynamic> json) {
    personalDtlsMdl = json['personalDtls_Mdl'] != null
        ? new PersonalDtlsMdlNew.fromJson(json['personalDtls_Mdl'])
        : null;
    if (json['familyList_Mdl'] != null) {
      familyListMdl = <FamilyListMdlNew>[];
      json['familyList_Mdl'].forEach((v) {
        familyListMdl!.add(new FamilyListMdlNew.fromJson(v));
      });
    }
    mahalakshmiMdl = json['mahalakshmi_Mdl'] != null
        ? new MahalakshmiMdlNew.fromJson(json['mahalakshmi_Mdl'])
        : null;
    raithubharosaMdl = json['raithubharosa_Mdl'] != null
        ? new RaithubharosaMdlNew.fromJson(json['raithubharosa_Mdl'])
        : null;
    indirammaIndluMdl = json['indirammaIndlu_Mdl'] != null
        ? new IndirammaIndluMdlNew.fromJson(json['indirammaIndlu_Mdl'])
        : null;
    gruhajyothiMdl = json['gruhajyothi_Mdl'] != null
        ? new GruhajyothiMdlNew.fromJson(json['gruhajyothi_Mdl'])
        : null;
    cheyuthaMdl = json['cheyutha_Mdl'] != null
        ? new CheyuthaMdl.fromJson(json['cheyutha_Mdl'])
        : null;
    if (json['listCheyutha_Mdl'] != null) {
      listCheyuthaMdl = <ListCheyuthaMdl>[];
      json['listCheyutha_Mdl'].forEach((v) {
        listCheyuthaMdl!.add(new ListCheyuthaMdl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.personalDtlsMdl != null) {
      data['personalDtls_Mdl'] = this.personalDtlsMdl!.toJson();
    }
    if (this.familyListMdl != null) {
      data['familyList_Mdl'] =
          this.familyListMdl!.map((v) => v.toJson()).toList();
    }
    if (this.mahalakshmiMdl != null) {
      data['mahalakshmi_Mdl'] = this.mahalakshmiMdl!.toJson();
    }
    if (this.raithubharosaMdl != null) {
      data['raithubharosa_Mdl'] = this.raithubharosaMdl!.toJson();
    }
    if (this.indirammaIndluMdl != null) {
      data['indirammaIndlu_Mdl'] = this.indirammaIndluMdl!.toJson();
    }
    if (this.gruhajyothiMdl != null) {
      data['gruhajyothi_Mdl'] = this.gruhajyothiMdl!.toJson();
    }
    if (this.cheyuthaMdl != null) {
      data['cheyutha_Mdl'] = this.cheyuthaMdl!.toJson();
    }
    if (this.listCheyuthaMdl != null) {
      data['listCheyutha_Mdl'] =
          this.listCheyuthaMdl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheyuthaMdl {
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
  String? eligibleFlag;

  CheyuthaMdl(
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
      this.eligibleFlag});

  CheyuthaMdl.fromJson(Map<String, dynamic> json) {
    familyID = json['familyID'];
    schemeID = json['schemeID'];
    divyangulaSadaramID = json['divyangula_SadaramID'];
    widowDeathCertificateNumber = json['widow_death_certificate_number'];
    widowDateofDeath = json['widow_dateofDeath'];
    toddyTapperRegistrationType = json['toddyTapper_RegistrationType'];
    weaverCooperativeSociety = json['weaver_cooperative_Society'];
    beediWorkerEPFEnrollmentNumber = json['beediWorker_EPF_EnrollmentNumber'];
    beediWorkerEnrollemntDate = json['beediWorker_Enrollemnt_Date'];
    singleWomenCatgory = json['singleWomen_Catgory'];
    singleWomenDocuments = json['singleWomen_Documents'];
    beediThekadarIndustryName = json['beediThekadar_IndustryName'];
    beediThekadarLicenseNumber = json['beediThekadar_LicenseNumber'];
    beediThekadarLicenceIssuedDate = json['beediThekadar_LicenceIssuedDate'];
    beediThekadarValidUpto = json['beediThekadar_ValidUpto'];
    eligibleFlag = json['eligible_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyID'] = this.familyID;
    data['schemeID'] = this.schemeID;
    data['divyangula_SadaramID'] = this.divyangulaSadaramID;
    data['widow_death_certificate_number'] = this.widowDeathCertificateNumber;
    data['widow_dateofDeath'] = this.widowDateofDeath;
    data['toddyTapper_RegistrationType'] = this.toddyTapperRegistrationType;
    data['weaver_cooperative_Society'] = this.weaverCooperativeSociety;
    data['beediWorker_EPF_EnrollmentNumber'] =
        this.beediWorkerEPFEnrollmentNumber;
    data['beediWorker_Enrollemnt_Date'] = this.beediWorkerEnrollemntDate;
    data['singleWomen_Catgory'] = this.singleWomenCatgory;
    data['singleWomen_Documents'] = this.singleWomenDocuments;
    data['beediThekadar_IndustryName'] = this.beediThekadarIndustryName;
    data['beediThekadar_LicenseNumber'] = this.beediThekadarLicenseNumber;
    data['beediThekadar_LicenceIssuedDate'] =
        this.beediThekadarLicenceIssuedDate;
    data['beediThekadar_ValidUpto'] = this.beediThekadarValidUpto;
    data['eligible_flag'] = this.eligibleFlag;
    return data;
  }
}

class ListCheyuthaMdl {
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
  String? eligibleFlag;

  ListCheyuthaMdl(
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
      this.eligibleFlag});

  ListCheyuthaMdl.fromJson(Map<String, dynamic> json) {
    familyID = json['familyID'];
    schemeID = json['schemeID'];
    divyangulaSadaramID = json['divyangula_SadaramID'];
    widowDeathCertificateNumber = json['widow_death_certificate_number'];
    widowDateofDeath = json['widow_dateofDeath'];
    toddyTapperRegistrationType = json['toddyTapper_RegistrationType'];
    weaverCooperativeSociety = json['weaver_cooperative_Society'];
    beediWorkerEPFEnrollmentNumber = json['beediWorker_EPF_EnrollmentNumber'];
    beediWorkerEnrollemntDate = json['beediWorker_Enrollemnt_Date'];
    singleWomenCatgory = json['singleWomen_Catgory'];
    singleWomenDocuments = json['singleWomen_Documents'];
    beediThekadarIndustryName = json['beediThekadar_IndustryName'];
    beediThekadarLicenseNumber = json['beediThekadar_LicenseNumber'];
    beediThekadarLicenceIssuedDate = json['beediThekadar_LicenceIssuedDate'];
    beediThekadarValidUpto = json['beediThekadar_ValidUpto'];
    eligibleFlag = json['eligible_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyID'] = this.familyID;
    data['schemeID'] = this.schemeID;
    data['divyangula_SadaramID'] = this.divyangulaSadaramID;
    data['widow_death_certificate_number'] = this.widowDeathCertificateNumber;
    data['widow_dateofDeath'] = this.widowDateofDeath;
    data['toddyTapper_RegistrationType'] = this.toddyTapperRegistrationType;
    data['weaver_cooperative_Society'] = this.weaverCooperativeSociety;
    data['beediWorker_EPF_EnrollmentNumber'] =
        this.beediWorkerEPFEnrollmentNumber;
    data['beediWorker_Enrollemnt_Date'] = this.beediWorkerEnrollemntDate;
    data['singleWomen_Catgory'] = this.singleWomenCatgory;
    data['singleWomen_Documents'] = this.singleWomenDocuments;
    data['beediThekadar_IndustryName'] = this.beediThekadarIndustryName;
    data['beediThekadar_LicenseNumber'] = this.beediThekadarLicenseNumber;
    data['beediThekadar_LicenceIssuedDate'] =
        this.beediThekadarLicenceIssuedDate;
    data['beediThekadar_ValidUpto'] = this.beediThekadarValidUpto;
    data['eligible_flag'] = this.eligibleFlag;
    return data;
  }
}

class PersonalDtlsMdlNew {
  String? idd;
  String? id;
  String? tokenID;
  String? createdBy;
  String? createdIP;
  String? createdDeviceID;
  String? remarks;
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
  String? housENO;
  String? warDNO;
  String? panchayaTID;
  String? mandaLID;
  String? districTID;
  String? municipaLID;
  String? gPMUN;
  String? iteCCATAGORY;
  String? departmenTCATAGORY;
  String? mHSCHEME;
  String? raithUBAROSA;
  String? indirammAILLU;
  String? gruhajyothi;
  String? cheyutha;
  String? enablEAPPFAMILY;
  String? enablESCHEMES;
  String? familyDtlsXML;
  String? ownerPassbookDtlsXML;
  String? tenentPassbookDtlsXML;
  String? houseHoldPassbookDtlsXML;
  String? surveyDtlsXML;
  String? sadaramDtlsXML;

  PersonalDtlsMdlNew(
      {this.idd,
      this.id,
      this.tokenID,
      this.createdBy,
      this.createdIP,
      this.createdDeviceID,
      this.remarks,
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
      this.housENO,
      this.warDNO,
      this.panchayaTID,
      this.mandaLID,
      this.districTID,
      this.municipaLID,
      this.gPMUN,
      this.iteCCATAGORY,
      this.departmenTCATAGORY,
      this.mHSCHEME,
      this.raithUBAROSA,
      this.indirammAILLU,
      this.gruhajyothi,
      this.cheyutha,
      this.enablEAPPFAMILY,
      this.enablESCHEMES,
      this.familyDtlsXML,
      this.ownerPassbookDtlsXML,
      this.tenentPassbookDtlsXML,
      this.houseHoldPassbookDtlsXML,
      this.surveyDtlsXML,
      this.sadaramDtlsXML});

  PersonalDtlsMdlNew.fromJson(Map<String, dynamic> json) {
    idd = json['idd'];
    id = json['id'];
    tokenID = json['tokenID'];
    createdBy = json['createdBy'];
    createdIP = json['createdIP'];
    createdDeviceID = json['createdDeviceID'];
    remarks = json['remarks'];
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
    housENO = json['housE_NO'];
    warDNO = json['warD_NO'];
    panchayaTID = json['panchayaT_ID'];
    mandaLID = json['mandaL_ID'];
    districTID = json['districT_ID'];
    municipaLID = json['municipaL_ID'];
    gPMUN = json['gP_MUN'];
    iteCCATAGORY = json['iteC_CATAGORY'];
    departmenTCATAGORY = json['departmenT_CATAGORY'];
    mHSCHEME = json['mH_SCHEME'];
    raithUBAROSA = json['raithU_BAROSA'];
    indirammAILLU = json['indirammA_ILLU'];
    gruhajyothi = json['gruhajyothi'];
    cheyutha = json['cheyutha'];
    enablEAPPFAMILY = json['enablE_APP_FAMILY'];
    enablESCHEMES = json['enablE_SCHEMES'];
    familyDtlsXML = json['familyDtlsXML'];
    ownerPassbookDtlsXML = json['ownerPassbookDtlsXML'];
    tenentPassbookDtlsXML = json['tenentPassbookDtlsXML'];
    houseHoldPassbookDtlsXML = json['houseHoldPassbookDtlsXML'];
    surveyDtlsXML = json['surveyDtlsXML'];
    sadaramDtlsXML = json['sadaramDtlsXML'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idd'] = this.idd;
    data['id'] = this.id;
    data['tokenID'] = this.tokenID;
    data['createdBy'] = this.createdBy;
    data['createdIP'] = this.createdIP;
    data['createdDeviceID'] = this.createdDeviceID;
    data['remarks'] = this.remarks;
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
    data['housE_NO'] = this.housENO;
    data['warD_NO'] = this.warDNO;
    data['panchayaT_ID'] = this.panchayaTID;
    data['mandaL_ID'] = this.mandaLID;
    data['districT_ID'] = this.districTID;
    data['municipaL_ID'] = this.municipaLID;
    data['gP_MUN'] = this.gPMUN;
    data['iteC_CATAGORY'] = this.iteCCATAGORY;
    data['departmenT_CATAGORY'] = this.departmenTCATAGORY;
    data['mH_SCHEME'] = this.mHSCHEME;
    data['raithU_BAROSA'] = this.raithUBAROSA;
    data['indirammA_ILLU'] = this.indirammAILLU;
    data['gruhajyothi'] = this.gruhajyothi;
    data['cheyutha'] = this.cheyutha;
    data['enablE_APP_FAMILY'] = this.enablEAPPFAMILY;
    data['enablE_SCHEMES'] = this.enablESCHEMES;
    data['familyDtlsXML'] = this.familyDtlsXML;
    data['ownerPassbookDtlsXML'] = this.ownerPassbookDtlsXML;
    data['tenentPassbookDtlsXML'] = this.tenentPassbookDtlsXML;
    data['houseHoldPassbookDtlsXML'] = this.houseHoldPassbookDtlsXML;
    data['surveyDtlsXML'] = this.surveyDtlsXML;
    data['sadaramDtlsXML'] = this.sadaramDtlsXML;
    return data;
  }
}

class FamilyListMdlNew {
  int? id;
  String? onlinEAPPLICATIONNO;
  String? offlinEAPPLICATIONNO;
  String? name;
  String? relation;
  String? relatioNNAME;
  String? gender;
  String? datEOFBIRTH;
  String? aadhaRNO;

  FamilyListMdlNew(
      {this.id,
      this.onlinEAPPLICATIONNO,
      this.offlinEAPPLICATIONNO,
      this.name,
      this.relation,
      this.relatioNNAME,
      this.gender,
      this.datEOFBIRTH,
      this.aadhaRNO});

  FamilyListMdlNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    onlinEAPPLICATIONNO = json['onlinE_APPLICATION_NO'];
    offlinEAPPLICATIONNO = json['offlinE_APPLICATION_NO'];
    name = json['name'];
    relation = json['relation'];
    relatioNNAME = json['relatioN_NAME'];
    gender = json['gender'];
    datEOFBIRTH = json['datE_OF_BIRTH'];
    aadhaRNO = json['aadhaR_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['onlinE_APPLICATION_NO'] = this.onlinEAPPLICATIONNO;
    data['offlinE_APPLICATION_NO'] = this.offlinEAPPLICATIONNO;
    data['name'] = this.name;
    data['relation'] = this.relation;
    data['relatioN_NAME'] = this.relatioNNAME;
    data['gender'] = this.gender;
    data['datE_OF_BIRTH'] = this.datEOFBIRTH;
    data['aadhaR_NO'] = this.aadhaRNO;
    return data;
  }
}

class MahalakshmiMdlNew {
  String? finhelP2500;
  String? selecteDUSERID;
  String? gaS500;
  String? gaSCONNECTIONNO;
  String? gaSCOMPANYNAME;
  String? gaSCOMPANYNAMEOTHER;
  String? nOOFCYLINDERS;
  String? pensionID;
  String? pensionType;
  List<ListPensions>? listPensions;

  MahalakshmiMdlNew(
      {this.finhelP2500,
      this.selecteDUSERID,
      this.gaS500,
      this.gaSCONNECTIONNO,
      this.gaSCOMPANYNAME,
      this.gaSCOMPANYNAMEOTHER,
      this.nOOFCYLINDERS,
      this.pensionID,
      this.pensionType,
      this.listPensions});

  MahalakshmiMdlNew.fromJson(Map<String, dynamic> json) {
    finhelP2500 = json['finhelP_2500'];
    selecteDUSERID = json['selecteD_USERID'];
    gaS500 = json['gaS_500'];
    gaSCONNECTIONNO = json['gaS_CONNECTION_NO'];
    gaSCOMPANYNAME = json['gaS_COMPANY_NAME'];
    gaSCOMPANYNAMEOTHER = json['gaS_COMPANY_NAME_OTHER'];
    nOOFCYLINDERS = json['nO_OF_CYLINDERS'];
    pensionID = json['pensionID'];
    pensionType = json['pensionType'];
    if (json['listPensions'] != null) {
      listPensions = <ListPensions>[];
      json['listPensions'].forEach((v) {
        listPensions!.add(new ListPensions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finhelP_2500'] = this.finhelP2500;
    data['selecteD_USERID'] = this.selecteDUSERID;
    data['gaS_500'] = this.gaS500;
    data['gaS_CONNECTION_NO'] = this.gaSCONNECTIONNO;
    data['gaS_COMPANY_NAME'] = this.gaSCOMPANYNAME;
    data['gaS_COMPANY_NAME_OTHER'] = this.gaSCOMPANYNAMEOTHER;
    data['nO_OF_CYLINDERS'] = this.nOOFCYLINDERS;
    data['pensionID'] = this.pensionID;
    data['pensionType'] = this.pensionType;
    if (this.listPensions != null) {
      data['listPensions'] = this.listPensions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListPensions {
  String? familyID;
  String? pensionID;

  ListPensions({this.familyID, this.pensionID});

  ListPensions.fromJson(Map<String, dynamic> json) {
    familyID = json['familyID'];
    pensionID = json['pensionID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyID'] = this.familyID;
    data['pensionID'] = this.pensionID;
    return data;
  }
}
// class MahalakshmiMdlNew {
//   String? finhelP2500;
//   String? selecteDUSERID;
//   String? gaS500;
//   String? gaSCONNECTIONNO;
//   String? gaSCOMPANYNAME;
//   String? gaSCOMPANYNAMEOTHER;
//   String? nOOFCYLINDERS;

//   MahalakshmiMdlNew(
//       {this.finhelP2500,
//       this.selecteDUSERID,
//       this.gaS500,
//       this.gaSCONNECTIONNO,
//       this.gaSCOMPANYNAME,
//       this.gaSCOMPANYNAMEOTHER,
//       this.nOOFCYLINDERS});

//   MahalakshmiMdlNew.fromJson(Map<String, dynamic> json) {
//     finhelP2500 = json['finhelP_2500'];
//     selecteDUSERID = json['selecteD_USERID'];
//     gaS500 = json['gaS_500'];
//     gaSCONNECTIONNO = json['gaS_CONNECTION_NO'];
//     gaSCOMPANYNAME = json['gaS_COMPANY_NAME'];
//     gaSCOMPANYNAMEOTHER = json['gaS_COMPANY_NAME_OTHER'];
//     nOOFCYLINDERS = json['nO_OF_CYLINDERS'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['finhelP_2500'] = this.finhelP2500;
//     data['selecteD_USERID'] = this.selecteDUSERID;
//     data['gaS_500'] = this.gaS500;
//     data['gaS_CONNECTION_NO'] = this.gaSCONNECTIONNO;
//     data['gaS_COMPANY_NAME'] = this.gaSCOMPANYNAME;
//     data['gaS_COMPANY_NAME_OTHER'] = this.gaSCOMPANYNAMEOTHER;
//     data['nO_OF_CYLINDERS'] = this.nOOFCYLINDERS;
//     return data;
//   }
// }

class RaithubharosaMdlNew {
  String? farmeR15000;
  String? beneficiarYRAITHUBANDHU;
  String? raithu;
  String? koulURAITHU;
  String? cooliE12000;
  String? householDAGRI;
  String? totaLREGWAGEJOBCARD;
  String? wagEWORKFY;
  String? totaLDAYSWORKEDFY;
  String? jobcarDNO;
  List<OwneRDTLS>? owneRDTLS;
  List<OwneRDTLS>? tenenTDTLS;
  List<OwneRDTLS>? householDDTLS;
  List<SurveyListMdlNew>? surveyListMdl;
  List<PassbookListMdlNew>? passbookListMdl;

  RaithubharosaMdlNew(
      {this.farmeR15000,
      this.beneficiarYRAITHUBANDHU,
      this.raithu,
      this.koulURAITHU,
      this.cooliE12000,
      this.householDAGRI,
      this.totaLREGWAGEJOBCARD,
      this.wagEWORKFY,
      this.totaLDAYSWORKEDFY,
      this.jobcarDNO,
      this.owneRDTLS,
      this.tenenTDTLS,
      this.householDDTLS,
      this.surveyListMdl,
      this.passbookListMdl});

  RaithubharosaMdlNew.fromJson(Map<String, dynamic> json) {
    farmeR15000 = json['farmeR_15000'];
    beneficiarYRAITHUBANDHU = json['beneficiarY_RAITHU_BANDHU'];
    raithu = json['raithu'];
    koulURAITHU = json['koulU_RAITHU'];
    cooliE12000 = json['cooliE_12000'];
    householDAGRI = json['householD_AGRI'];
    totaLREGWAGEJOBCARD = json['totaL_REG_WAGE_JOBCARD'];
    wagEWORKFY = json['wagE_WORK_FY'];
    totaLDAYSWORKEDFY = json['totaL_DAYS_WORKED_FY'];
    jobcarDNO = json['jobcarD_NO'];
    if (json['owneR_DTLS'] != null) {
      owneRDTLS = <OwneRDTLS>[];
      json['owneR_DTLS'].forEach((v) {
        owneRDTLS!.add(new OwneRDTLS.fromJson(v));
      });
    }
    if (json['tenenT_DTLS'] != null) {
      tenenTDTLS = <OwneRDTLS>[];
      json['tenenT_DTLS'].forEach((v) {
        tenenTDTLS!.add(new OwneRDTLS.fromJson(v));
      });
    }
    if (json['householD_DTLS'] != null) {
      householDDTLS = <OwneRDTLS>[];
      json['householD_DTLS'].forEach((v) {
        householDDTLS!.add(new OwneRDTLS.fromJson(v));
      });
    }
    if (json['surveyList_Mdl'] != null) {
      surveyListMdl = <SurveyListMdlNew>[];
      json['surveyList_Mdl'].forEach((v) {
        surveyListMdl!.add(new SurveyListMdlNew.fromJson(v));
      });
    }
    if (json['passbookList_Mdl'] != null) {
      passbookListMdl = <PassbookListMdlNew>[];
      json['passbookList_Mdl'].forEach((v) {
        passbookListMdl!.add(new PassbookListMdlNew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farmeR_15000'] = this.farmeR15000;
    data['beneficiarY_RAITHU_BANDHU'] = this.beneficiarYRAITHUBANDHU;
    data['raithu'] = this.raithu;
    data['koulU_RAITHU'] = this.koulURAITHU;
    data['cooliE_12000'] = this.cooliE12000;
    data['householD_AGRI'] = this.householDAGRI;
    data['totaL_REG_WAGE_JOBCARD'] = this.totaLREGWAGEJOBCARD;
    data['wagE_WORK_FY'] = this.wagEWORKFY;
    data['totaL_DAYS_WORKED_FY'] = this.totaLDAYSWORKEDFY;
    data['jobcarD_NO'] = this.jobcarDNO;
    if (this.owneRDTLS != null) {
      data['owneR_DTLS'] = this.owneRDTLS!.map((v) => v.toJson()).toList();
    }
    if (this.tenenTDTLS != null) {
      data['tenenT_DTLS'] = this.tenenTDTLS!.map((v) => v.toJson()).toList();
    }
    if (this.householDDTLS != null) {
      data['householD_DTLS'] =
          this.householDDTLS!.map((v) => v.toJson()).toList();
    }
    if (this.surveyListMdl != null) {
      data['surveyList_Mdl'] =
          this.surveyListMdl!.map((v) => v.toJson()).toList();
    }
    if (this.passbookListMdl != null) {
      data['passbookList_Mdl'] =
          this.passbookListMdl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PassbookListMdlNew {
  String? passBookNo;
  String? surveyNo;
  String? acres;
  String? guntas;
  String? subDivion;
  String? landOwnerName;
  String? leaseDoc;
  String? periodFrom;
  String? periodTo;

  PassbookListMdlNew(
      {this.passBookNo,
      this.surveyNo,
      this.acres,
      this.guntas,
      this.subDivion,
      this.landOwnerName,
      this.leaseDoc,
      this.periodFrom,
      this.periodTo});

  PassbookListMdlNew.fromJson(Map<String, dynamic> json) {
    passBookNo = json['passBookNo'];
    surveyNo = json['surveyNo'];
    acres = json['acres'];
    guntas = json['guntas'];
    subDivion = json['subDivion'];
    landOwnerName = json['landOwnerName'];
    leaseDoc = json['leaseDoc'];
    periodFrom = json['periodFrom'];
    periodTo = json['periodTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['passBookNo'] = this.passBookNo;
    data['surveyNo'] = this.surveyNo;
    data['acres'] = this.acres;
    data['guntas'] = this.guntas;
    data['subDivion'] = this.subDivion;
    data['landOwnerName'] = this.landOwnerName;
    data['leaseDoc'] = this.leaseDoc;
    data['periodFrom'] = this.periodFrom;
    data['periodTo'] = this.periodTo;
    return data;
  }
}

class OwneRDTLS {
  String? passbooKNO;
  String? surveYNO;
  String? area;
  String? guntas;
  String? subDivion;
  String? landOwnerName;
  String? leaseDoc;
  String? periodFrom;
  String? periodTo;

  OwneRDTLS(
      {this.passbooKNO,
      this.surveYNO,
      this.area,
      this.guntas,
      this.subDivion,
      this.landOwnerName,
      this.leaseDoc,
      this.periodFrom,
      this.periodTo});

  OwneRDTLS.fromJson(Map<String, dynamic> json) {
    passbooKNO = json['passbooK_NO'];
    surveYNO = json['surveY_NO'];
    area = json['area'];
    guntas = json['guntas'];
    subDivion = json['subDivion'];
    landOwnerName = json['landOwnerName'];
    leaseDoc = json['leaseDoc'];
    periodFrom = json['periodFrom'];
    periodTo = json['periodTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['passbooK_NO'] = this.passbooKNO;
    data['surveY_NO'] = this.surveYNO;
    data['area'] = this.area;
    data['guntas'] = this.guntas;
    data['subDivion'] = this.subDivion;
    data['landOwnerName'] = this.landOwnerName;
    data['leaseDoc'] = this.leaseDoc;
    data['periodFrom'] = this.periodFrom;
    data['periodTo'] = this.periodTo;
    return data;
  }
}

class SurveyListMdlNew {
  int? id;
  String? onlinEAPPLICATIONNO;
  String? offlinEAPPLICATIONNO;
  String? area;
  String? surveYNO;
  String? guntas;

  SurveyListMdlNew(
      {this.id,
      this.onlinEAPPLICATIONNO,
      this.offlinEAPPLICATIONNO,
      this.area,
      this.surveYNO,
      this.guntas});

  SurveyListMdlNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    onlinEAPPLICATIONNO = json['onlinE_APPLICATION_NO'];
    offlinEAPPLICATIONNO = json['offlinE_APPLICATION_NO'];
    area = json['area'];
    surveYNO = json['surveY_NO'];
    guntas = json['guntas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['onlinE_APPLICATION_NO'] = this.onlinEAPPLICATIONNO;
    data['offlinE_APPLICATION_NO'] = this.offlinEAPPLICATIONNO;
    data['area'] = this.area;
    data['surveY_NO'] = this.surveYNO;
    data['guntas'] = this.guntas;
    return data;
  }
}

/* class IndirammaIndluMdlNew {
  String? finhelPHOME;
  String? martyrS250;
  String? martyrSFAMILY;
  String? martyrSNAME;
  String? martyrSDEATHDATE;
  String? martyrSFIRNO;
  String? martyrSDEATHCERTIFICATENO;
  String? activist;
  String? activisTFIRNO;
  String? activisTFIRYEAR;
  String? wenTTOJAIL;
  String? jaiLNAME;
  String? jaiLPLACE;
  String? prisoNPERIODYEAR;
  String? prisoNPERIODMONTH;
  String? prisoNPERIODDAYS;

  IndirammaIndluMdlNew(
      {this.finhelPHOME,
      this.martyrS250,
      this.martyrSFAMILY,
      this.martyrSNAME,
      this.martyrSDEATHDATE,
      this.martyrSFIRNO,
      this.martyrSDEATHCERTIFICATENO,
      this.activist,
      this.activisTFIRNO,
      this.activisTFIRYEAR,
      this.wenTTOJAIL,
      this.jaiLNAME,
      this.jaiLPLACE,
      this.prisoNPERIODYEAR,
      this.prisoNPERIODMONTH,
      this.prisoNPERIODDAYS});

  IndirammaIndluMdlNew.fromJson(Map<String, dynamic> json) {
    finhelPHOME = json['finhelP_HOME'];
    martyrS250 = json['martyrS_250'];
    martyrSFAMILY = json['martyrS_FAMILY'];
    martyrSNAME = json['martyrS_NAME'];
    martyrSDEATHDATE = json['martyrS_DEATH_DATE'];
    martyrSFIRNO = json['martyrS_FIR_NO'];
    martyrSDEATHCERTIFICATENO = json['martyrS_DEATH_CERTIFICATE_NO'];
    activist = json['activist'];
    activisTFIRNO = json['activisT_FIR_NO'];
    activisTFIRYEAR = json['activisT_FIR_YEAR'];
    wenTTOJAIL = json['wenT_TO_JAIL'];
    jaiLNAME = json['jaiL_NAME'];
    jaiLPLACE = json['jaiL_PLACE'];
    prisoNPERIODYEAR = json['prisoN_PERIOD_YEAR'];
    prisoNPERIODMONTH = json['prisoN_PERIOD_MONTH'];
    prisoNPERIODDAYS = json['prisoN_PERIOD_DAYS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finhelP_HOME'] = this.finhelPHOME;
    data['martyrS_250'] = this.martyrS250;
    data['martyrS_FAMILY'] = this.martyrSFAMILY;
    data['martyrS_NAME'] = this.martyrSNAME;
    data['martyrS_DEATH_DATE'] = this.martyrSDEATHDATE;
    data['martyrS_FIR_NO'] = this.martyrSFIRNO;
    data['martyrS_DEATH_CERTIFICATE_NO'] = this.martyrSDEATHCERTIFICATENO;
    data['activist'] = this.activist;
    data['activisT_FIR_NO'] = this.activisTFIRNO;
    data['activisT_FIR_YEAR'] = this.activisTFIRYEAR;
    data['wenT_TO_JAIL'] = this.wenTTOJAIL;
    data['jaiL_NAME'] = this.jaiLNAME;
    data['jaiL_PLACE'] = this.jaiLPLACE;
    data['prisoN_PERIOD_YEAR'] = this.prisoNPERIODYEAR;
    data['prisoN_PERIOD_MONTH'] = this.prisoNPERIODMONTH;
    data['prisoN_PERIOD_DAYS'] = this.prisoNPERIODDAYS;
    return data;
  }
} */
class IndirammaIndluMdlNew {
  String? finhelPHOME;
  String? martyrS250;
  String? martyrSFAMILY;
  String? martyrSNAME;
  String? martyrSDEATHDATE;
  String? martyrSFIRNO;
  String? martyrSDEATHCERTIFICATENO;
  String? activist;
  String? activisTFIRNO;
  String? activisTFIRYEAR;
  String? wenTTOJAIL;
  String? jaiLNAME;
  String? jaiLPLACE;
  String? prisoNPERIODYEAR;
  String? prisoNPERIODMONTH;
  String? prisoNPERIODDAYS;
  String? prsnTRESIDENCSTATUS;
  String? typEROOF;
  String? housESITE;
  String? naturEOWNERSHIP;
  String? housESITEAPPLICANT;
  String? indiraselecteDID;
  String? relationship;
  String? ploTAREA;
  String? quaidINO;
  String? policestation;
  String? datEOFIMPRISONMENT;
  String? datEOFRELEASE;
  String? dateOFSuicide;
  String? martyrFIRYear;
  String? martyrPoliceStation;
  String? remanded;
  String? activistPoliceStation;
  String? underTrailNumber;

  IndirammaIndluMdlNew(
      {this.finhelPHOME,
      this.martyrS250,
      this.martyrSFAMILY,
      this.martyrSNAME,
      this.martyrSDEATHDATE,
      this.martyrSFIRNO,
      this.martyrSDEATHCERTIFICATENO,
      this.activist,
      this.activisTFIRNO,
      this.activisTFIRYEAR,
      this.wenTTOJAIL,
      this.jaiLNAME,
      this.jaiLPLACE,
      this.prisoNPERIODYEAR,
      this.prisoNPERIODMONTH,
      this.prisoNPERIODDAYS,
      this.prsnTRESIDENCSTATUS,
      this.typEROOF,
      this.housESITE,
      this.naturEOWNERSHIP,
      this.housESITEAPPLICANT,
      this.indiraselecteDID,
      this.relationship,
      this.ploTAREA,
      this.quaidINO,
      this.policestation,
      this.datEOFIMPRISONMENT,
      this.datEOFRELEASE,
      this.dateOFSuicide,
      this.martyrFIRYear,
      this.martyrPoliceStation,
      this.remanded,
      this.activistPoliceStation,
      this.underTrailNumber});

  IndirammaIndluMdlNew.fromJson(Map<String, dynamic> json) {
    finhelPHOME = json['finhelP_HOME'];
    martyrS250 = json['martyrS_250'];
    martyrSFAMILY = json['martyrS_FAMILY'];
    martyrSNAME = json['martyrS_NAME'];
    martyrSDEATHDATE = json['martyrS_DEATH_DATE'];
    martyrSFIRNO = json['martyrS_FIR_NO'];
    martyrSDEATHCERTIFICATENO = json['martyrS_DEATH_CERTIFICATE_NO'];
    activist = json['activist'];
    activisTFIRNO = json['activisT_FIR_NO'];
    activisTFIRYEAR = json['activisT_FIR_YEAR'];
    wenTTOJAIL = json['wenT_TO_JAIL'];
    jaiLNAME = json['jaiL_NAME'];
    jaiLPLACE = json['jaiL_PLACE'];
    prisoNPERIODYEAR = json['prisoN_PERIOD_YEAR'];
    prisoNPERIODMONTH = json['prisoN_PERIOD_MONTH'];
    prisoNPERIODDAYS = json['prisoN_PERIOD_DAYS'];
    prsnTRESIDENCSTATUS = json['prsnT_RESIDENC_STATUS'];
    typEROOF = json['typE_ROOF'];
    housESITE = json['housE_SITE'];
    naturEOWNERSHIP = json['naturE_OWNERSHIP'];
    housESITEAPPLICANT = json['housE_SITE_APPLICANT'];
    indiraselecteDID = json['indiraselecteD_ID'];
    relationship = json['relationship'];
    ploTAREA = json['ploT_AREA'];
    quaidINO = json['quaidI_NO'];
    policestation = json['policestation'];
    datEOFIMPRISONMENT = json['datE_OF_IMPRISONMENT'];
    datEOFRELEASE = json['datE_OF_RELEASE'];
    dateOFSuicide = json['dateOfSuicide'];
    martyrFIRYear = json['martyr_FIR_Year'];
    martyrPoliceStation = json['policestation'];
    remanded = json['activistRemanded'];
    activistPoliceStation = json['activePoliceStation'];
    underTrailNumber = json['jailUnderTrail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finhelP_HOME'] = this.finhelPHOME;
    data['martyrS_250'] = this.martyrS250;
    data['martyrS_FAMILY'] = this.martyrSFAMILY;
    data['martyrS_NAME'] = this.martyrSNAME;
    data['martyrS_DEATH_DATE'] = this.martyrSDEATHDATE;
    data['martyrS_FIR_NO'] = this.martyrSFIRNO;
    data['martyrS_DEATH_CERTIFICATE_NO'] = this.martyrSDEATHCERTIFICATENO;
    data['activist'] = this.activist;
    data['activisT_FIR_NO'] = this.activisTFIRNO;
    data['activisT_FIR_YEAR'] = this.activisTFIRYEAR;
    data['wenT_TO_JAIL'] = this.wenTTOJAIL;
    data['jaiL_NAME'] = this.jaiLNAME;
    data['jaiL_PLACE'] = this.jaiLPLACE;
    data['prisoN_PERIOD_YEAR'] = this.prisoNPERIODYEAR;
    data['prisoN_PERIOD_MONTH'] = this.prisoNPERIODMONTH;
    data['prisoN_PERIOD_DAYS'] = this.prisoNPERIODDAYS;
    data['prsnT_RESIDENC_STATUS'] = this.prsnTRESIDENCSTATUS;
    data['typE_ROOF'] = this.typEROOF;
    data['housE_SITE'] = this.housESITE;
    data['naturE_OWNERSHIP'] = this.naturEOWNERSHIP;
    data['housE_SITE_APPLICANT'] = this.housESITEAPPLICANT;
    data['indiraselecteD_ID'] = this.indiraselecteDID;
    data['relationship'] = this.relationship;
    data['ploT_AREA'] = this.ploTAREA;
    data['quaidI_NO'] = this.quaidINO;
    data['policestation'] = this.policestation;
    data['datE_OF_IMPRISONMENT'] = this.datEOFIMPRISONMENT;
    data['datE_OF_RELEASE'] = this.datEOFRELEASE;
    data['dateOfSuicide'] = this.dateOFSuicide;
    data['martyr_FIR_Year'] = this.martyrFIRYear;
    data['policestation'] = this.martyrPoliceStation;
    data['activistRemanded'] = this.remanded;
    data['activePoliceStation'] = this.activistPoliceStation;
    data['jailUnderTrail'] = this.underTrailNumber;
    return data;
  }
}

class GruhajyothiMdlNew {
  String? electricitY200;
  String? electricitYCONSUMPTION;
  String? meteRNO;

  GruhajyothiMdlNew(
      {this.electricitY200, this.electricitYCONSUMPTION, this.meteRNO});

  GruhajyothiMdlNew.fromJson(Map<String, dynamic> json) {
    electricitY200 = json['electricitY_200'];
    electricitYCONSUMPTION = json['electricitY_CONSUMPTION'];
    meteRNO = json['meteR_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['electricitY_200'] = this.electricitY200;
    data['electricitY_CONSUMPTION'] = this.electricitYCONSUMPTION;
    data['meteR_NO'] = this.meteRNO;
    return data;
  }
}

/* 
class CheyutaSubmitLocalModelNew {
  List<CheyutaSubmitLocalDataNew>? data;

  CheyutaSubmitLocalModelNew({this.data});

  CheyutaSubmitLocalModelNew.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CheyutaSubmitLocalDataNew>[];
      json['data'].forEach((v) {
        data!.add(new CheyutaSubmitLocalDataNew.fromJson(v));
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
 */
/* class CheyutaSubmitLocalDataNew {
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

  CheyutaSubmitLocalDataNew(
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

  CheyutaSubmitLocalDataNew.fromJson(Map<String, dynamic> json) {
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
  } */
class CheyutaSubmitLocalDataNew {
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
  String? eligibleFlag;

  CheyutaSubmitLocalDataNew(
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
      this.eligibleFlag});

  CheyutaSubmitLocalDataNew.fromJson(Map<String, dynamic> json) {
    familyID = json['familyID'];
    schemeID = json['schemeID'];
    divyangulaSadaramID = json['divyangula_SadaramID'];
    widowDeathCertificateNumber = json['widow_death_certificate_number'];
    widowDateofDeath = json['widow_dateofDeath'];
    toddyTapperRegistrationType = json['toddyTapper_RegistrationType'];
    weaverCooperativeSociety = json['weaver_cooperative_Society'];
    beediWorkerEPFEnrollmentNumber = json['beediWorker_EPF_EnrollmentNumber'];
    beediWorkerEnrollemntDate = json['beediWorker_Enrollemnt_Date'];
    singleWomenCatgory = json['singleWomen_Catgory'];
    singleWomenDocuments = json['singleWomen_Documents'];
    beediThekadarIndustryName = json['beediThekadar_IndustryName'];
    beediThekadarLicenseNumber = json['beediThekadar_LicenseNumber'];
    beediThekadarLicenceIssuedDate = json['beediThekadar_LicenceIssuedDate'];
    beediThekadarValidUpto = json['beediThekadar_ValidUpto'];
    eligibleFlag = json['eligible_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyID'] = this.familyID;
    data['schemeID'] = this.schemeID;
    data['divyangula_SadaramID'] = this.divyangulaSadaramID;
    data['widow_death_certificate_number'] = this.widowDeathCertificateNumber;
    data['widow_dateofDeath'] = this.widowDateofDeath;
    data['toddyTapper_RegistrationType'] = this.toddyTapperRegistrationType;
    data['weaver_cooperative_Society'] = this.weaverCooperativeSociety;
    data['beediWorker_EPF_EnrollmentNumber'] =
        this.beediWorkerEPFEnrollmentNumber;
    data['beediWorker_Enrollemnt_Date'] = this.beediWorkerEnrollemntDate;
    data['singleWomen_Catgory'] = this.singleWomenCatgory;
    data['singleWomen_Documents'] = this.singleWomenDocuments;
    data['beediThekadar_IndustryName'] = this.beediThekadarIndustryName;
    data['beediThekadar_LicenseNumber'] = this.beediThekadarLicenseNumber;
    data['beediThekadar_LicenceIssuedDate'] =
        this.beediThekadarLicenceIssuedDate;
    data['beediThekadar_ValidUpto'] = this.beediThekadarValidUpto;
    data['eligible_flag'] = this.eligibleFlag;
    return data;
  }
}

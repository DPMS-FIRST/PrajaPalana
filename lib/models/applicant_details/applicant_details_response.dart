/* class GetApplicantDetailsResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  Data? data;

  GetApplicantDetailsResponse(
      {this.statusMessage, this.message, this.statusCode, this.data});

  GetApplicantDetailsResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    message = json['message'];
    statusCode = json['status_Code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  PersonalDtlsMdl? personalDtlsMdl;
  List<FamilyListMdl>? familyListMdl;
  MahalakshmiMdl? mahalakshmiMdl;
  RaithubharosaMdl? raithubharosaMdl;
  IndirammaIndluMdl? indirammaIndluMdl;
  GruhajyothiMdl? gruhajyothiMdl;
  CheyuthaMdl? cheyuthaMdl;

  Data(
      {this.personalDtlsMdl,
      this.familyListMdl,
      this.mahalakshmiMdl,
      this.raithubharosaMdl,
      this.indirammaIndluMdl,
      this.gruhajyothiMdl,
      this.cheyuthaMdl});

  Data.fromJson(Map<String, dynamic> json) {
    personalDtlsMdl = json['personalDtls_Mdl'] != null
        ? new PersonalDtlsMdl.fromJson(json['personalDtls_Mdl'])
        : null;
    if (json['familyList_Mdl'] != null) {
      familyListMdl = <FamilyListMdl>[];
      json['familyList_Mdl'].forEach((v) {
        familyListMdl!.add(new FamilyListMdl.fromJson(v));
      });
    }
    mahalakshmiMdl = json['mahalakshmi_Mdl'] != null
        ? new MahalakshmiMdl.fromJson(json['mahalakshmi_Mdl'])
        : null;
    raithubharosaMdl = json['raithubharosa_Mdl'] != null
        ? new RaithubharosaMdl.fromJson(json['raithubharosa_Mdl'])
        : null;
    indirammaIndluMdl = json['indirammaIndlu_Mdl'] != null
        ? new IndirammaIndluMdl.fromJson(json['indirammaIndlu_Mdl'])
        : null;
    gruhajyothiMdl = json['gruhajyothi_Mdl'] != null
        ? new GruhajyothiMdl.fromJson(json['gruhajyothi_Mdl'])
        : null;
    cheyuthaMdl = json['cheyutha_Mdl'] != null
        ? new CheyuthaMdl.fromJson(json['cheyutha_Mdl'])
        : null;
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
    return data;
  }
}

class PersonalDtlsMdl {
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

  PersonalDtlsMdl(
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
      this.housENO,
      this.warDNO,
      this.panchayaTID,
      this.mandaLID,
      this.districTID,
      this.municipaLID,
      this.gPMUN});

  PersonalDtlsMdl.fromJson(Map<String, dynamic> json) {
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
    data['housE_NO'] = this.housENO;
    data['warD_NO'] = this.warDNO;
    data['panchayaT_ID'] = this.panchayaTID;
    data['mandaL_ID'] = this.mandaLID;
    data['districT_ID'] = this.districTID;
    data['municipaL_ID'] = this.municipaLID;
    data['gP_MUN'] = this.gPMUN;
    return data;
  }
}

class FamilyListMdl {
  String? onlinEAPPLICATIONNO;
  String? offlinEAPPLICATIONNO;
  String? name;
  String? relation;
  String? relatioNNAME;
  String? gender;
  String? datEOFBIRTH;
  String? aadhaRNO;

  FamilyListMdl(
      {this.onlinEAPPLICATIONNO,
      this.offlinEAPPLICATIONNO,
      this.name,
      this.relation,
      this.relatioNNAME,
      this.gender,
      this.datEOFBIRTH,
      this.aadhaRNO});

  FamilyListMdl.fromJson(Map<String, dynamic> json) {
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

class MahalakshmiMdl {
  String? finhelP2500;
  String? gaS500;
  String? gaSCONNECTIONNO;
  String? gaSCOMPANYNAME;
  String? gaSCOMPANYNAMEOTHER;
  String? nOOFCYLINDERS;

  MahalakshmiMdl(
      {this.finhelP2500,
      this.gaS500,
      this.gaSCONNECTIONNO,
      this.gaSCOMPANYNAME,
      this.gaSCOMPANYNAMEOTHER,
      this.nOOFCYLINDERS});

  MahalakshmiMdl.fromJson(Map<String, dynamic> json) {
    finhelP2500 = json['finhelP_2500'];
    gaS500 = json['gaS_500'];
    gaSCONNECTIONNO = json['gaS_CONNECTION_NO'];
    gaSCOMPANYNAME = json['gaS_COMPANY_NAME'];
    gaSCOMPANYNAMEOTHER = json['gaS_COMPANY_NAME_OTHER'];
    nOOFCYLINDERS = json['nO_OF_CYLINDERS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finhelP_2500'] = this.finhelP2500;
    data['gaS_500'] = this.gaS500;
    data['gaS_CONNECTION_NO'] = this.gaSCONNECTIONNO;
    data['gaS_COMPANY_NAME'] = this.gaSCOMPANYNAME;
    data['gaS_COMPANY_NAME_OTHER'] = this.gaSCOMPANYNAMEOTHER;
    data['nO_OF_CYLINDERS'] = this.nOOFCYLINDERS;
    return data;
  }
}

class RaithubharosaMdl {
  String? farmeR15000;
  String? raithu;
  String? koulURAITHU;
  String? cooliE12000;
  String? jobcarDNO;
  List<SurveyListMdl>? surveyListMdl;
  List<PassbookListMdl>? passbookListMdl;

  RaithubharosaMdl(
      {this.farmeR15000,
      this.raithu,
      this.koulURAITHU,
      this.cooliE12000,
      this.jobcarDNO,
      this.surveyListMdl,
      this.passbookListMdl});

  RaithubharosaMdl.fromJson(Map<String, dynamic> json) {
    farmeR15000 = json['farmeR_15000'];
    raithu = json['raithu'];
    koulURAITHU = json['koulU_RAITHU'];
    cooliE12000 = json['cooliE_12000'];
    jobcarDNO = json['jobcarD_NO'];
    if (json['surveyList_Mdl'] != null) {
      surveyListMdl = <SurveyListMdl>[];
      json['surveyList_Mdl'].forEach((v) {
        surveyListMdl!.add(new SurveyListMdl.fromJson(v));
      });
    }
    if (json['passbookList_Mdl'] != null) {
      passbookListMdl = <PassbookListMdl>[];
      json['passbookList_Mdl'].forEach((v) {
        passbookListMdl!.add(new PassbookListMdl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farmeR_15000'] = this.farmeR15000;
    data['raithu'] = this.raithu;
    data['koulU_RAITHU'] = this.koulURAITHU;
    data['cooliE_12000'] = this.cooliE12000;
    data['jobcarD_NO'] = this.jobcarDNO;
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

class SurveyListMdl {
  String? onlinEAPPLICATIONNO;
  String? offlinEAPPLICATIONNO;
  String? area;
  String? surveYNO;
  String? guntas;

  SurveyListMdl(
      {this.onlinEAPPLICATIONNO,
      this.offlinEAPPLICATIONNO,
      this.area,
      this.surveYNO,
      this.guntas});

  SurveyListMdl.fromJson(Map<String, dynamic> json) {
    onlinEAPPLICATIONNO = json['onlinE_APPLICATION_NO'];
    offlinEAPPLICATIONNO = json['offlinE_APPLICATION_NO'];
    area = json['area'];
    surveYNO = json['surveY_NO'];
    guntas = json['guntas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onlinE_APPLICATION_NO'] = this.onlinEAPPLICATIONNO;
    data['offlinE_APPLICATION_NO'] = this.offlinEAPPLICATIONNO;
    data['area'] = this.area;
    data['surveY_NO'] = this.surveYNO;
    data['guntas'] = this.guntas;
    return data;
  }
}

class PassbookListMdl {
  String? onlinEAPPLICATIONNO;
  String? offlinEAPPLICATIONNO;
  String? passbooKNO;

  PassbookListMdl(
      {this.onlinEAPPLICATIONNO, this.offlinEAPPLICATIONNO, this.passbooKNO});

  PassbookListMdl.fromJson(Map<String, dynamic> json) {
    onlinEAPPLICATIONNO = json['onlinE_APPLICATION_NO'];
    offlinEAPPLICATIONNO = json['offlinE_APPLICATION_NO'];
    passbooKNO = json['passbooK_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onlinE_APPLICATION_NO'] = this.onlinEAPPLICATIONNO;
    data['offlinE_APPLICATION_NO'] = this.offlinEAPPLICATIONNO;
    data['passbooK_NO'] = this.passbooKNO;
    return data;
  }
}

class IndirammaIndluMdl {
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

  IndirammaIndluMdl(
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

  IndirammaIndluMdl.fromJson(Map<String, dynamic> json) {
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
}

class GruhajyothiMdl {
  String? electricitY200;
  String? electricitYCONSUMPTION;
  String? meteRNO;

  GruhajyothiMdl(
      {this.electricitY200, this.electricitYCONSUMPTION, this.meteRNO});

  GruhajyothiMdl.fromJson(Map<String, dynamic> json) {
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

class CheyuthaMdl {
  String? cheyutha;
  String? disabled;
  String? others;
  String? vrudhapya;
  String? vitantu;
  String? geetha;
  String? chenetha;
  String? dailisis;
  String? aids;
  String? beedi;
  String? paileria;
  String? singlEWOMEN;
  String? beedITEKEDARU;
  List<SadaramListMdl>? sadaramListMdl;

  CheyuthaMdl(
      {this.cheyutha,
      this.disabled,
      this.others,
      this.vrudhapya,
      this.vitantu,
      this.geetha,
      this.chenetha,
      this.dailisis,
      this.aids,
      this.beedi,
      this.paileria,
      this.singlEWOMEN,
      this.beedITEKEDARU,
      this.sadaramListMdl});

  CheyuthaMdl.fromJson(Map<String, dynamic> json) {
    cheyutha = json['cheyutha'];
    disabled = json['disabled'];
    others = json['others'];
    vrudhapya = json['vrudhapya'];
    vitantu = json['vitantu'];
    geetha = json['geetha'];
    chenetha = json['chenetha'];
    dailisis = json['dailisis'];
    aids = json['aids'];
    beedi = json['beedi'];
    paileria = json['paileria'];
    singlEWOMEN = json['singlE_WOMEN'];
    beedITEKEDARU = json['beedI_TEKEDARU'];
    if (json['sadaramList_Mdl'] != null) {
      sadaramListMdl = <SadaramListMdl>[];
      json['sadaramList_Mdl'].forEach((v) {
        sadaramListMdl!.add(new SadaramListMdl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cheyutha'] = this.cheyutha;
    data['disabled'] = this.disabled;
    data['others'] = this.others;
    data['vrudhapya'] = this.vrudhapya;
    data['vitantu'] = this.vitantu;
    data['geetha'] = this.geetha;
    data['chenetha'] = this.chenetha;
    data['dailisis'] = this.dailisis;
    data['aids'] = this.aids;
    data['beedi'] = this.beedi;
    data['paileria'] = this.paileria;
    data['singlE_WOMEN'] = this.singlEWOMEN;
    data['beedI_TEKEDARU'] = this.beedITEKEDARU;
    if (this.sadaramListMdl != null) {
      data['sadaramList_Mdl'] =
          this.sadaramListMdl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SadaramListMdl {
  String? onlinEAPPLICATIONNO;
  String? offlinEAPPLICATIONNO;
  String? sadaraMCERTIFICATENO;

  SadaramListMdl(
      {this.onlinEAPPLICATIONNO,
      this.offlinEAPPLICATIONNO,
      this.sadaraMCERTIFICATENO});

  SadaramListMdl.fromJson(Map<String, dynamic> json) {
    onlinEAPPLICATIONNO = json['onlinE_APPLICATION_NO'];
    offlinEAPPLICATIONNO = json['offlinE_APPLICATION_NO'];
    sadaraMCERTIFICATENO = json['sadaraM_CERTIFICATE_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onlinE_APPLICATION_NO'] = this.onlinEAPPLICATIONNO;
    data['offlinE_APPLICATION_NO'] = this.offlinEAPPLICATIONNO;
    data['sadaraM_CERTIFICATE_NO'] = this.sadaraMCERTIFICATENO;
    return data;
  }
}
 */
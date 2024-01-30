class ConfigurableFieldsResponse {
  ApplicantdetailsEdit? applicantdetailsEdit;
  FamilydetailsEdit? familydetailsEdit;
  AddressdetailsEdit? addressdetailsEdit;
  MahalakshmiEdit? mahalakshmiEdit;
  RythubharosaEdit? rythubharosaEdit;
  InditammaEdit? inditammaEdit;
  GruhajyothiEdit? gruhajyothiEdit;
  CheyuthaEdit? cheyuthaEdit;
  int? statusCode;
  String? statusMessage;
  String? message;

  ConfigurableFieldsResponse(
      {this.applicantdetailsEdit,
      this.familydetailsEdit,
      this.addressdetailsEdit,
      this.mahalakshmiEdit,
      this.rythubharosaEdit,
      this.inditammaEdit,
      this.gruhajyothiEdit,
      this.cheyuthaEdit,
      this.statusCode,
      this.statusMessage,
      this.message});

  ConfigurableFieldsResponse.fromJson(Map<String, dynamic> json) {
    applicantdetailsEdit = json['applicantdetails_Edit'] != null
        ? new ApplicantdetailsEdit.fromJson(json['applicantdetails_Edit'])
        : null;
    familydetailsEdit = json['familydetails_Edit'] != null
        ? new FamilydetailsEdit.fromJson(json['familydetails_Edit'])
        : null;
    addressdetailsEdit = json['addressdetails_Edit'] != null
        ? new AddressdetailsEdit.fromJson(json['addressdetails_Edit'])
        : null;
    mahalakshmiEdit = json['mahalakshmi_Edit'] != null
        ? new MahalakshmiEdit.fromJson(json['mahalakshmi_Edit'])
        : null;
    rythubharosaEdit = json['rythubharosa_Edit'] != null
        ? new RythubharosaEdit.fromJson(json['rythubharosa_Edit'])
        : null;
    inditammaEdit = json['inditamma_Edit'] != null
        ? new InditammaEdit.fromJson(json['inditamma_Edit'])
        : null;
    gruhajyothiEdit = json['gruhajyothi_Edit'] != null
        ? new GruhajyothiEdit.fromJson(json['gruhajyothi_Edit'])
        : null;
    cheyuthaEdit = json['cheyutha_Edit'] != null
        ? new CheyuthaEdit.fromJson(json['cheyutha_Edit'])
        : null;
    statusCode = json['status_Code'];
    statusMessage = json['status_Message'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.applicantdetailsEdit != null) {
      data['applicantdetails_Edit'] = this.applicantdetailsEdit!.toJson();
    }
    if (this.familydetailsEdit != null) {
      data['familydetails_Edit'] = this.familydetailsEdit!.toJson();
    }
    if (this.addressdetailsEdit != null) {
      data['addressdetails_Edit'] = this.addressdetailsEdit!.toJson();
    }
    if (this.mahalakshmiEdit != null) {
      data['mahalakshmi_Edit'] = this.mahalakshmiEdit!.toJson();
    }
    if (this.rythubharosaEdit != null) {
      data['rythubharosa_Edit'] = this.rythubharosaEdit!.toJson();
    }
    if (this.inditammaEdit != null) {
      data['inditamma_Edit'] = this.inditammaEdit!.toJson();
    }
    if (this.gruhajyothiEdit != null) {
      data['gruhajyothi_Edit'] = this.gruhajyothiEdit!.toJson();
    }
    if (this.cheyuthaEdit != null) {
      data['cheyutha_Edit'] = this.cheyuthaEdit!.toJson();
    }
    data['status_Code'] = this.statusCode;
    data['status_Message'] = this.statusMessage;
    data['message'] = this.message;
    return data;
  }
}

class ApplicantdetailsEdit {
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

  ApplicantdetailsEdit(
      {this.onlinEAPPLICATIONNO,
      this.offlinEAPPLICATIONNO,
      this.applicanTNAME,
      this.gender,
      this.caste,
      this.datEOFBIRTH,
      this.aadhaRNO,
      this.ratioNCARDNO,
      this.mobilENO,
      this.occupation});

  ApplicantdetailsEdit.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class FamilydetailsEdit {
  String? name;
  String? relation;
  String? gender;
  String? datEOFBIRTH;
  String? aadhaRNO;

  FamilydetailsEdit(
      {this.name, this.relation, this.gender, this.datEOFBIRTH, this.aadhaRNO});

  FamilydetailsEdit.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    relation = json['relation'];
    gender = json['gender'];
    datEOFBIRTH = json['datE_OF_BIRTH'];
    aadhaRNO = json['aadhaR_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['relation'] = this.relation;
    data['gender'] = this.gender;
    data['datE_OF_BIRTH'] = this.datEOFBIRTH;
    data['aadhaR_NO'] = this.aadhaRNO;
    return data;
  }
}

class AddressdetailsEdit {
  String? housENO;
  String? warDNO;
  String? panchayaTID;
  String? mandaLID;
  String? districTID;
  String? municipaLID;
  String? gPMUN;

  AddressdetailsEdit(
      {this.housENO,
      this.warDNO,
      this.panchayaTID,
      this.mandaLID,
      this.districTID,
      this.municipaLID,
      this.gPMUN});

  AddressdetailsEdit.fromJson(Map<String, dynamic> json) {
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

class MahalakshmiEdit {
  String? finhelP2500;
  String? gaS500;
  String? gaSCONNECTIONNO;
  String? gaSCOMPANYNAME;
  String? gaSCOMPANYNAMEOTHER;
  String? nOOFCYLINDERS;

  MahalakshmiEdit(
      {this.finhelP2500,
      this.gaS500,
      this.gaSCONNECTIONNO,
      this.gaSCOMPANYNAME,
      this.gaSCOMPANYNAMEOTHER,
      this.nOOFCYLINDERS});

  MahalakshmiEdit.fromJson(Map<String, dynamic> json) {
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

class RythubharosaEdit {
  String? farmeR15000;
  String? raithu;
  String? koulURAITHU;
  String? cooliE12000;
  String? jobcarDNO;
  String? passbooKNO;
  String? surveYNO;
  String? area;
  String? guntas;

  RythubharosaEdit(
      {this.farmeR15000,
      this.raithu,
      this.koulURAITHU,
      this.cooliE12000,
      this.jobcarDNO,
      this.passbooKNO,
      this.surveYNO,
      this.area,
      this.guntas});

  RythubharosaEdit.fromJson(Map<String, dynamic> json) {
    farmeR15000 = json['farmeR_15000'];
    raithu = json['raithu'];
    koulURAITHU = json['koulU_RAITHU'];
    cooliE12000 = json['cooliE_12000'];
    jobcarDNO = json['jobcarD_NO'];
    passbooKNO = json['passbooK_NO'];
    surveYNO = json['surveY_NO'];
    area = json['area'];
    guntas = json['guntas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farmeR_15000'] = this.farmeR15000;
    data['raithu'] = this.raithu;
    data['koulU_RAITHU'] = this.koulURAITHU;
    data['cooliE_12000'] = this.cooliE12000;
    data['jobcarD_NO'] = this.jobcarDNO;
    data['passbooK_NO'] = this.passbooKNO;
    data['surveY_NO'] = this.surveYNO;
    data['area'] = this.area;
    data['guntas'] = this.guntas;
    return data;
  }
}

class InditammaEdit {
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

  InditammaEdit(
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

  InditammaEdit.fromJson(Map<String, dynamic> json) {
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

class GruhajyothiEdit {
  String? electricitY200;
  String? electricitYCONSUMPTION;
  String? meteRNO;

  GruhajyothiEdit(
      {this.electricitY200, this.electricitYCONSUMPTION, this.meteRNO});

  GruhajyothiEdit.fromJson(Map<String, dynamic> json) {
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

class CheyuthaEdit {
  String? cheyutha;
  String? disabled;
  String? sadaraMCERTIFICATENO;
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

  CheyuthaEdit(
      {this.cheyutha,
      this.disabled,
      this.sadaraMCERTIFICATENO,
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
      this.beedITEKEDARU});

  CheyuthaEdit.fromJson(Map<String, dynamic> json) {
    cheyutha = json['cheyutha'];
    disabled = json['disabled'];
    sadaraMCERTIFICATENO = json['sadaraM_CERTIFICATE_NO'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cheyutha'] = this.cheyutha;
    data['disabled'] = this.disabled;
    data['sadaraM_CERTIFICATE_NO'] = this.sadaraMCERTIFICATENO;
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
    return data;
  }
}

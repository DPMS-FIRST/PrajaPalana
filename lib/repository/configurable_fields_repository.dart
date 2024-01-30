import 'package:flutter/material.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_payload.dart';
import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';

class ConfigurableFieldsRepository with ChangeNotifier {
  // final _baseClient = BaseApiClient();
  Future<ConfigurableFieldsResponse?> getConfigurableFieldsRepository(
      BuildContext context, ConfigurableFieldsPayload payload) async {
/*     final response = await _baseClient.postCall(
      context,
      ApiConstants.getConfigurableFields,
      payload.toJson(),
    ); */
    return ConfigurableFieldsResponse(
        addressdetailsEdit: AddressdetailsEdit(
          districTID: "N",
          gPMUN: "N",
          housENO: "N",
          mandaLID: "N",
          municipaLID: "N",
          panchayaTID: "N",
          warDNO: "N",
        ),
        applicantdetailsEdit: ApplicantdetailsEdit(
          aadhaRNO: "N",
          applicanTNAME: "N",
          caste: "N",
          datEOFBIRTH: "N",
          gender: "N",
          mobilENO: "N",
          occupation: "N",
          ratioNCARDNO: "N",
          offlinEAPPLICATIONNO: "N",
          onlinEAPPLICATIONNO: "N",
        ),
        cheyuthaEdit: CheyuthaEdit(
          aids: "N",
          beedITEKEDARU: "N",
          beedi: "N",
          chenetha: "N",
          cheyutha: "N",
          dailisis: "N",
          disabled: "N",
          geetha: "N",
          others: "N",
          paileria: "N",
          sadaraMCERTIFICATENO: "N",
          singlEWOMEN: "N",
          vitantu: "N",
          vrudhapya: "N",
        ),
        familydetailsEdit: FamilydetailsEdit(
          aadhaRNO: "N",
          datEOFBIRTH: "N",
          gender: "N",
          name: "N",
          relation: "N",
        ),
        gruhajyothiEdit: GruhajyothiEdit(
          electricitY200: "N",
          electricitYCONSUMPTION: "N",
          meteRNO: "N",
        ),
        inditammaEdit: InditammaEdit(
          activisTFIRNO: "N",
          activisTFIRYEAR: "N",
          activist: "N",
          finhelPHOME: "N",
          jaiLNAME: "N",
          jaiLPLACE: "N",
          martyrS250: "N",
          martyrSDEATHCERTIFICATENO: "N",
          martyrSDEATHDATE: "N",
          martyrSFAMILY: "N",
          martyrSFIRNO: "N",
          martyrSNAME: "N",
          prisoNPERIODDAYS: "N",
          prisoNPERIODMONTH: "N",
          prisoNPERIODYEAR: "N",
          wenTTOJAIL: "N",
        ),
        mahalakshmiEdit: MahalakshmiEdit(
          finhelP2500: "N",
          gaS500: "N",
          gaSCOMPANYNAME: "N",
          gaSCOMPANYNAMEOTHER: "N",
          gaSCONNECTIONNO: "N",
          nOOFCYLINDERS: "N",
        ),
        message: "Success",
        rythubharosaEdit: RythubharosaEdit(
          area: "y",
          cooliE12000: "N",
          farmeR15000: "N",
          guntas: "y",
          jobcarDNO: "N",
          koulURAITHU: "N",
          passbooKNO: "y",
          raithu: "N",
          surveYNO: "y",
        ),
        statusCode: 200,
        statusMessage: "success");
  }
}

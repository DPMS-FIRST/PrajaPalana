import 'dart:convert';

import 'package:praja_palana/models/applicant_details/applicant_schemewise_details_response.dart';
import 'package:praja_palana/models/master_data/master_geograpics_response.dart';

class CheyuthaTableInfo {
  FamilyListMdl? selectedFamilyMember;
  Cheyutha? selectedCheyuthaSubScheme;
  String? schemeInfo;

  CheyuthaTableInfo(
      {this.selectedFamilyMember,
      this.selectedCheyuthaSubScheme,
      this.schemeInfo});

  CheyuthaTableInfo.fromJson(Map<String, dynamic> json) {
    print("schemeInfo---- ${json['schemeInfo']}");
    selectedFamilyMember = FamilyListMdl(
        id: json['selectedFamilyMember']['id'],
        aadhaRNO: json['selectedFamilyMember']['aadhaR_NO'],
        datEOFBIRTH: json['selectedFamilyMember']['datE_OF_BIRTH'],
        gender: json['selectedFamilyMember']['gender'],
        name: json['selectedFamilyMember']['name'],
        offlinEAPPLICATIONNO: json['selectedFamilyMember']
            ['offlinE_APPLICATION_NO'],
        onlinEAPPLICATIONNO: json['selectedFamilyMember']
            ['onlinE_APPLICATION_NO'],
        relatioNNAME: json['selectedFamilyMember']['relatioN_NAME'],
        relation: json['selectedFamilyMember']['relation']);

    print("selectedFamilyMember---- ${jsonEncode(selectedFamilyMember)}");

    selectedCheyuthaSubScheme = Cheyutha(
        age: json['selectedCheyuthaSubScheme']["age"],
        cschemEID: json['selectedCheyuthaSubScheme']["cschemE_ID"],
        cschemENAME: json['selectedCheyuthaSubScheme']["cschemE_NAME"]);

    print("selectedCheyuthaSubScheme---- ${jsonEncode(selectedCheyuthaSubScheme)}");

    schemeInfo = json['schemeInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selectedFamilyMember'] = this.selectedFamilyMember;
    data['selectedCheyuthaSubScheme'] = this.selectedCheyuthaSubScheme;
    data['schemeInfo'] = this.schemeInfo;

    return data;
  }
}

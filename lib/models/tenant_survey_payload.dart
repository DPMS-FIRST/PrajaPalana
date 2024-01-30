class TenantSurveyPayload {
  String? passBookNo;
  String? landOwnerName;
  String? leaseDoc;
  String? periodFrom;
  String? periodTo;
  String? surveyNo;
  String? subDivision;
  String? acres;
  String? guntas;

  TenantSurveyPayload(
      {this.passBookNo,
      this.landOwnerName,
      this.leaseDoc,
      this.periodFrom,
      this.periodTo,
      this.surveyNo,
      this.subDivision,
      this.acres,
      this.guntas});

  TenantSurveyPayload.fromJson(Map<String, dynamic> json) {
    passBookNo = json['passBookNo'];
    landOwnerName = json['landOwnerName'];
    leaseDoc = json['leaseDoc'];
    periodFrom = json['periodFrom'];
    periodTo = json['periodTo'];
    surveyNo = json['surveyNo'];
    subDivision = json['subDivision'];
    acres = json['acres'];
    guntas = json['guntas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['passBookNo'] = this.passBookNo;
    data['landOwnerName'] = this.landOwnerName;
    data['leaseDoc'] = this.leaseDoc;
    data['periodFrom'] = this.periodFrom;
    data['periodTo'] = this.periodTo;
    data['surveyNo'] = this.surveyNo;
    data['subDivision'] = this.subDivision;
    data['acres'] = this.acres;
    data['guntas'] = this.guntas;
    return data;
  }
}

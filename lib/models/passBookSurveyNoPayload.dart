class PassbookSurveyAddPayload {
  String? passBookNo;
  String? surveyNo;
  String? acres;
  String? guntas;
  String? subDivion;

  PassbookSurveyAddPayload(
      {this.passBookNo, this.surveyNo, this.acres, this.guntas,this.subDivion});

  PassbookSurveyAddPayload.fromJson(Map<String, dynamic> json) {
    passBookNo = json['passBookNo'];
    surveyNo = json['surveyNo'];
    acres = json['acres'];
    guntas = json['Guntas'];
    subDivion=json['Sub Division'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['passBookNo'] = this.passBookNo;
    data['surveyNo'] = this.surveyNo;
    data['acres'] = this.acres;
    data['Guntas'] = this.guntas;
    data['Sub Division']=this.subDivion;
    return data;
  }
}

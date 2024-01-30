class UlbsMasterPayload {
  int? districtID;

  UlbsMasterPayload({this.districtID});

  UlbsMasterPayload.fromJson(Map<String, dynamic> json) {
    districtID = json['district_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_ID'] = this.districtID;
    return data;
  }
}

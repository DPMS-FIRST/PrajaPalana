class PSPayload {
  int? districTID;

  PSPayload({this.districTID});

  PSPayload.fromJson(Map<String, dynamic> json) {
    districTID = json['districT_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districT_ID'] = this.districTID;
    return data;
  }
}

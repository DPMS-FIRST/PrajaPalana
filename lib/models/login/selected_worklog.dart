class SelectedWorklogDetails {
  bool? approvedType;
  String? comments;
  String? workLogId;

  SelectedWorklogDetails({this.approvedType, this.comments, this.workLogId});

  SelectedWorklogDetails.fromJson(Map<String, dynamic> json) {
    approvedType = json['approved_type'];
    comments = json['comments'];
    workLogId = json['work_log_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approved_type'] = this.approvedType;
    data['comments'] = this.comments;
    data['work_log_id'] = this.workLogId;
    return data;
  }
}

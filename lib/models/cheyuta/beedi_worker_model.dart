class BeediWorkerModel {
  String? epf_enrollment_no;
  String? epf_enrollment_date;
  String? beediworkerName;
  

  BeediWorkerModel(
      {this.epf_enrollment_no, this.epf_enrollment_date,this.beediworkerName,});

  BeediWorkerModel.fromJson(Map<String, dynamic> json) {
    epf_enrollment_no = json['epf_enrollment_no'];
    epf_enrollment_date = json['epf_enrollment_date'];
     beediworkerName = json['beediworkerName'];
    
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['epf_enrollment_no'] = this.epf_enrollment_no;
    data['epf_enrollment_date'] = this.epf_enrollment_date;
     data['beediworkerName'] = this.beediworkerName;
    
    return data;
  }
}
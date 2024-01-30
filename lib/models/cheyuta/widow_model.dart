class WidowModel {
  String? deathCertificateNo;
  String? dateofDeath;
  String? widowName;
  

  WidowModel(
      {this.deathCertificateNo, this.dateofDeath,this.widowName,});

  WidowModel.fromJson(Map<String, dynamic> json) {
    deathCertificateNo = json['deathCertificateNo'];
    dateofDeath = json['dateofDeath'];
     widowName = json['widowName'];
    
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deathCertificateNo'] = this.deathCertificateNo;
    data['dateofDeath'] = this.dateofDeath;
     data['widowName'] = this.widowName;
    
    return data;
  }
}
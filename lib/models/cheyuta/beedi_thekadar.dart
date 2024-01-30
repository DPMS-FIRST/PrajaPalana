class BeediThekadarModel {
  String? industryName;
  String? licenseNo;
  String? licenseIssueDate;
  String? licenseValid;
   String? thekadarName;
  

  BeediThekadarModel(
      {this.industryName, this.licenseNo,this.licenseIssueDate,this.licenseValid,this.thekadarName});

  BeediThekadarModel.fromJson(Map<String, dynamic> json) {
    industryName = json['industryName'];
    licenseNo = json['licenseNo'];
     licenseIssueDate = json['licenseIssueDate'];
      licenseValid = json['licenseValid'];
       thekadarName = json['thekadarName'];
    
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['industryName'] = this.industryName;
    data['licenseNo'] = this.licenseNo;
     data['licenseIssueDate'] = this.licenseIssueDate;
     data['licenseValid'] = this.licenseValid;
     data['thekadarName'] = this.thekadarName;
    
    return data;
  }
}
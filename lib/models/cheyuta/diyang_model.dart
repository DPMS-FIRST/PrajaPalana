class DiyvangModel {
  String? diyangName;
  String? sadaramId;
  

  DiyvangModel(
      {this.diyangName, this.sadaramId,});

  DiyvangModel.fromJson(Map<String, dynamic> json) {
    diyangName = json['diyangName'];
    sadaramId = json['sadaramId'];
    
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diyangName'] = this.diyangName;
    data['sadaramId'] = this.sadaramId;
    
    return data;
  }
}
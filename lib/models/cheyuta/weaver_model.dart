class WeaverModel {
  String? weaverPersonName;
  String? society;
  

  WeaverModel(
      {this.weaverPersonName, this.society,});

  WeaverModel.fromJson(Map<String, dynamic> json) {
    weaverPersonName = json['weaverPersonName'];
    society = json['society'];
    
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weaverPersonName'] = this.weaverPersonName;
    data['society'] = this.society;
    
    return data;
  }
}
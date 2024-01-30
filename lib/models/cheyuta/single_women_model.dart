class SingleWomenModel {
  String? category;
  String? legal_document;
  String? singleWomenName;
  

  SingleWomenModel(
      {this.category, this.legal_document,this.singleWomenName,});

  SingleWomenModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    legal_document = json['legal_document'];
     singleWomenName = json['singleWomenName'];
    
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['legal_document'] = this.legal_document;
     data['singleWomenName'] = this.singleWomenName;
    
    return data;
  }
}
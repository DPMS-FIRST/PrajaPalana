class ToddyTapperModel {
  String? toddyPersonName;
  String? type;
  

  ToddyTapperModel(
      {this.toddyPersonName, this.type,});

  ToddyTapperModel.fromJson(Map<String, dynamic> json) {
    toddyPersonName = json['toddyPersonName'];
    type = json['type'];
    
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toddyPersonName'] = this.toddyPersonName;
    data['type'] = this.type;
    
    return data;
  }
}
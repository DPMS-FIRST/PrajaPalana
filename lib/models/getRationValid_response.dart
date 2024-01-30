class GetRationNumberValidResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  bool? data;

  GetRationNumberValidResponse(
      {this.statusMessage, this.message, this.statusCode, this.data});

  GetRationNumberValidResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    message = json['message'];
    statusCode = json['status_Code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['message'] = this.message;
    data['status_Code'] = this.statusCode;
    data['data'] = this.data;
    return data;
  }
}

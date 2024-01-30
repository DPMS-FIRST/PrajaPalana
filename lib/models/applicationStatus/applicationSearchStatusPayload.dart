class applicationStatusSearchPayLoad {
  String? onlinEAPPLICATIONNO;

  applicationStatusSearchPayLoad({this.onlinEAPPLICATIONNO});

  applicationStatusSearchPayLoad.fromJson(Map<String, dynamic> json) {
    onlinEAPPLICATIONNO = json['onlinE_APPLICATION_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onlinE_APPLICATION_NO'] = this.onlinEAPPLICATIONNO;
    return data;
  }
}

class DashboardData {
  String? title;
  String? icon;
  String? navigatorApproute;

  DashboardData({this.title, this.icon, this.navigatorApproute});

  DashboardData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    navigatorApproute = json['navigatorApproute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['navigatorApproute'] = this.navigatorApproute;
    return data;
  }
}

class Pager {
  int clientPage = 1;
  int everyPage = 10;
  int totalNum = 10;

  Pager({this.clientPage, this.everyPage, this.totalNum});

  Pager.fromJson(Map<String, dynamic> json) {
    clientPage = json['client_page'];
    everyPage = json['every_page'];
    totalNum = json['total_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_page'] = this.clientPage;
    data['every_page'] = this.everyPage;
    data['total_num'] = this.totalNum;
    return data;
  }
}

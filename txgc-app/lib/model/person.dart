class Person {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  String name;
  int gender;
  String phone;
  String sign;
  String idCard;
  String account;
  String password;
  int isLead;
  String lead;
  String headImg;
  bool isCheck = false; // 是否选中

  Person({
    this.id,
    this.createTime,
    this.updateTime,
    this.projectId,
    this.name,
    this.gender,
    this.phone,
    this.sign,
    this.idCard,
    this.account,
    this.password,
    this.isLead,
    this.lead,
    this.headImg,
  });

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    name = json['name'];
    gender = json['gender'];
    phone = json['phone'];
    sign = json['sign'];
    idCard = json['id_card'];
    account = json['account'];
    password = json['password'];
    isLead = json['is_lead'];
    lead = json['lead'];
    headImg = json['head_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['sign'] = this.sign;
    data['id_card'] = this.idCard;
    data['account'] = this.account;
    data['password'] = this.password;
    data['is_lead'] = this.isLead;
    data['lead'] = this.lead;
    data['head_img'] = this.headImg;
    return data;
  }
}

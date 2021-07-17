class Resource {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  int projectPersonId;
  String name;
  String url;
  int typ;
  int pid;
  String content;
  String signTime;
  String pa;
  String pb;
  Object money;
  String remark;
  String projectPersonName;
  bool isFolder = false;
  bool isCheck = false;
  bool isContract = false;

  Resource(
      {this.id,
      this.createTime,
      this.updateTime,
      this.projectId,
      this.projectPersonId,
      this.name,
      this.url,
      this.typ,
      this.pid,
      this.content,
      this.projectPersonName});

  Resource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    projectPersonId = json['project_person_id'];
    name = json['name'];
    url = json['url'];
    typ = json['typ'];
    pid = json['pid'];
    content = json['content'];
    projectPersonName = json['project_person_name'];
    signTime = json['sign_time'];
    pa = json['pa'];
    pb = json['pb'];
    money = json['money'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['project_person_id'] = this.projectPersonId;
    data['name'] = this.name;
    data['url'] = this.url;
    data['typ'] = this.typ;
    data['pid'] = this.pid;
    data['content'] = this.content;
    data['project_person_name'] = this.projectPersonName;
    data['sign_time'] = this.signTime;
    data['pa'] = this.pa;
    data['pb'] = this.pb;
    data['money'] = this.money;
    data['remark'] = this.remark;
    return data;
  }
}

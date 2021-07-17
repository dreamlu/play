class Meeting {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  int projectPersonId;
  String name;
  String startTime;
  String endTime;
  List<JoinIds> joinIds;
  int typ;
  String plat;
  String remark;
  int remind;
  int status;
  String projectPersonName;
  String record;

  Meeting(
      {this.id,
      this.createTime,
      this.updateTime,
      this.projectId,
      this.projectPersonId,
      this.name,
      this.startTime,
      this.endTime,
      this.joinIds,
      this.typ,
      this.plat,
      this.remark,
      this.remind,
      this.status,
      this.projectPersonName,
      this.record});

  Meeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    projectPersonId = json['project_person_id'];
    name = json['name'];
    projectPersonName = json['project_person_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    if (json['join_ids'] != null && json['join_ids'] != '') {
      joinIds = new List<JoinIds>();
      json['join_ids'].forEach((v) {
        joinIds.add(new JoinIds.fromJson(v));
      });
    }
    typ = json['typ'];
    plat = json['plat'];
    remark = json['remark'];
    remind = json['remind'];
    record = json['record'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['project_person_id'] = this.projectPersonId;
    data['name'] = this.name;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    if (this.joinIds != null) {
      data['join_ids'] = this.joinIds.map((v) => v.toJson()).toList();
    }
    data['typ'] = this.typ;
    data['plat'] = this.plat;
    data['remark'] = this.remark;
    data['project_person_name'] = this.projectPersonName;
    data['remind'] = this.remind;
    data['record'] = this.record;
    return data;
  }
}

class JoinIds {
  int id;
  int isR;
  String name;
  String phone;
  int status;

  JoinIds({this.id, this.isR, this.name, this.status, this.phone});

  JoinIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isR = json['is_r'];
    name = json['name'];
    status = json['status'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_r'] = this.isR;
    data['name'] = this.name;
    data['status'] = this.status;
    data['phone'] = this.phone;
    return data;
  }
}

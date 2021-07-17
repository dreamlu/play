import 'signature.dart';

class Approve {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  int projectPersonId;
  String name;
  String file;
  List<SignIds> signIds;
  int status;
  String projectName;
  String projectPersonName;
  String nowSignName;
  int signStatus;

  Approve(
      {this.id,
      this.createTime,
      this.updateTime,
      this.projectId,
      this.projectPersonId,
      this.name,
      this.file,
      this.signIds,
      this.status,
      this.projectName,
      this.projectPersonName,
      this.nowSignName,
      this.signStatus});

  Approve.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    projectPersonId = json['project_person_id'];
    name = json['name'];
    file = json['file'];
    if (json['sign_ids'] != null && json['sign_ids'] != '') {
      signIds = new List<SignIds>();
      json['sign_ids'].forEach((v) {
        signIds.add(new SignIds.fromJson(v));
      });
    }
    status = json['status'];
    projectName = json['project_name'];
    projectPersonName = json['project_person_name'];
    nowSignName = json['now_sign_name'];
    signStatus = json['sign_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['project_person_id'] = this.projectPersonId;
    data['name'] = this.name;
    data['file'] = this.file;
    if (this.signIds != null) {
      data['sign_ids'] = this.signIds.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['project_name'] = this.projectName;
    data['project_person_name'] = this.projectPersonName;
    data['now_sign_name'] = this.nowSignName;
    data['sign_status'] = this.signStatus;
    return data;
  }
}

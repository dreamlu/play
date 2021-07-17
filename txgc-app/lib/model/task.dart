import 'media.dart';

class Task {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  int projectPersonId;
  String name;
  String content;
  List<Media> img;
  List<Media> file;
  int receiveId;
  int status;
  String reason;
  String projectName;
  String projectPersonName;
  String receiveName;

  Task(
      {this.id,
      this.createTime,
      this.updateTime,
      this.projectId,
      this.projectPersonId,
      this.name,
      this.content,
      this.img,
      this.file,
      this.receiveId,
      this.status,
      this.reason,
      this.projectName,
      this.projectPersonName,
      this.receiveName});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    projectPersonId = json['project_person_id'];
    name = json['name'];
    content = json['content'];
    if (json['img'] != null && json['img'] != '') {
      img = new List<Media>();
      json['img'].forEach((v) {
        img.add(new Media.fromJson(v));
      });
    }
    if (json['file'] != null && json['file'] != '') {
      file = new List<Media>();
      json['file'].forEach((v) {
        file.add(new Media.fromJson(v));
      });
    }
    receiveId = json['receive_id'];
    status = json['status'];
    reason = json['reason'];
    projectName = json['project_name'];
    projectPersonName = json['project_person_name'];
    receiveName = json['receive_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['project_person_id'] = this.projectPersonId;
    data['name'] = this.name;
    data['content'] = this.content;
    if (this.img != null) {
      data['img'] = this.img.map((v) => v.toJson()).toList();
    }
    if (this.file != null) {
      data['file'] = this.file.map((v) => v.toJson()).toList();
    }
    data['receive_id'] = this.receiveId;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['project_name'] = this.projectName;
    data['project_person_name'] = this.projectPersonName;
    data['receive_name'] = this.receiveName;
    return data;
  }
}

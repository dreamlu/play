import 'package:txgc_app/model/media.dart';

class ShareEdit {
  int id;
  String createTime;
  String updateTime;
  String projectPersonName;
  int projectId;
  int projectPersonId;
  int receiveStatus;
  int typ;
  String name;
  String content;
  int isPublic;
  int isAy;
  List<Media> file;
  List<ReceiveIds> receiveIds;
  List<ReceiveIds> receiveIdLog;

  ShareEdit(
      {this.id,
      this.createTime,
      this.updateTime,
      this.projectId,
      this.projectPersonId,
      this.typ,
      this.name,
      this.content,
      this.isPublic,
      this.isAy,
      this.file,
      this.receiveIds,
      this.projectPersonName,
      this.receiveStatus,
      this.receiveIdLog});

  ShareEdit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    receiveStatus = json['receive_status'];
    projectPersonName = json['project_person_name'];
    projectPersonId = json['project_person_id'];
    typ = json['typ'];
    name = json['name'];
    content = json['content'];
    isPublic = json['is_public'];
    isAy = json['is_ay'];
    if (json['file'] != null && json['file'] != '') {
      file = new List<Media>();
      json['file'].forEach((v) {
        file.add(new Media.fromJson(v));
      });
    }
    if (json['receive_ids'] != null && json['receive_ids'] != '') {
      receiveIds = new List<ReceiveIds>();
      json['receive_ids'].forEach((v) {
        receiveIds.add(new ReceiveIds.fromJson(v));
      });
    }
    if (json['receive_id_log'] != null && json['receive_id_log'] != '') {
      receiveIdLog = new List<ReceiveIds>();
      json['receive_id_log'].forEach((v) {
        receiveIdLog.add(new ReceiveIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['project_person_id'] = this.projectPersonId;
    data['receive_status'] = this.receiveStatus;
    data['project_person_name'] = this.projectPersonName;
    data['typ'] = this.typ;
    data['name'] = this.name;
    data['content'] = this.content;
    data['is_public'] = this.isPublic;
    data['is_ay'] = this.isAy;
    if (this.file != null) {
      data['file'] = this.file.map((v) => v.toJson()).toList();
    }
    if (this.receiveIds != null) {
      data['receive_ids'] = this.receiveIds.map((v) => v.toJson()).toList();
    }
    if (this.receiveIdLog != null) {
      data['receive_id_log'] = this.receiveIds.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ReceiveIds {
  int id;
  String name;
  String time;
  int status;
  String content;
  List<Media> file;

  ReceiveIds(
      {this.id, this.name, this.time, this.status, this.content, this.file});

  ReceiveIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    time = json['time'];
    content = json['content'];
    if (json['file'] != null && json['file'] != '') {
      file = new List<Media>();
      json['file'].forEach((v) {
        file.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['time'] = this.time;
    data['content'] = this.content;
    if (this.file != null) {
      data['file'] = this.file.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

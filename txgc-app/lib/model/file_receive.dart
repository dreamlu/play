class FileReceive {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  int projectPersonId;
  String name;
  String endTime;
  String file;
  List<ReceiveIds> receiveIds;
  String projectPersonName;
  int receiveStatus;

  FileReceive(
      {this.id,
        this.createTime,
        this.updateTime,
        this.projectId,
        this.projectPersonId,
        this.name,
        this.endTime,
        this.file,
        this.receiveIds,
        this.projectPersonName,
        this.receiveStatus});

  FileReceive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    projectPersonId = json['project_person_id'];
    name = json['name'];
    endTime = json['end_time'];
    file = json['file'];
    if (json['receive_ids'] != null) {
      receiveIds = new List<ReceiveIds>();
      json['receive_ids'].forEach((v) {
        receiveIds.add(new ReceiveIds.fromJson(v));
      });
    }
    projectPersonName = json['project_person_name'];
    receiveStatus = json['receive_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['project_person_id'] = this.projectPersonId;
    data['name'] = this.name;
    data['end_time'] = this.endTime;
    data['file'] = this.file;
    if (this.receiveIds != null) {
      data['receive_ids'] = this.receiveIds.map((v) => v.toJson()).toList();
    }
    data['project_person_name'] = this.projectPersonName;
    data['receive_status'] = this.receiveStatus;
    return data;
  }
}

class ReceiveIds {
  int id;
  String name;
  String time;
  int status;

  ReceiveIds({this.id, this.name, this.time, this.status});

  ReceiveIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['time'] = this.time;
    data['status'] = this.status;
    return data;
  }
}

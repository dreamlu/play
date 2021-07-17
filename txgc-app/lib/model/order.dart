import 'package:txgc_app/model/media.dart';

class Order {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  int projectPersonId;
  String name;
  String endTime;
  int endHour;
  String content;
  List<Media> img;
  int receiveId;
  int status;
  String replyContent;
  List<Media> replyImg;
  bool isSms;
  String projectName;
  String projectPersonName;
  String receiveName;

  Order(
      {this.id,
      this.createTime,
      this.updateTime,
      this.projectId,
      this.projectPersonId,
      this.name,
      this.endTime,
      this.endHour,
      this.content,
      this.img,
      this.receiveId,
      this.status,
      this.replyContent,
      this.replyImg,
      this.isSms,
      this.projectName,
      this.projectPersonName,
      this.receiveName});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    projectPersonId = json['project_person_id'];
    name = json['name'];
    endTime = json['end_time'];
    endHour = json['end_hour'];
    content = json['content'];
    if (json['img'] != null && json['img'] != '') {
      img = new List<Media>();
      json['img'].forEach((v) {
        img.add(new Media.fromJson(v));
      });
    }
    receiveId = json['receive_id'];
    status = json['status'];
    replyContent = json['reply_content'];
    if (json['reply_img'] != null && json['reply_img'] != '') {
      replyImg = new List<Media>();
      json['reply_img'].forEach((v) {
        replyImg.add(new Media.fromJson(v));
      });
    }
    isSms = json['is_sms'];
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
    data['end_time'] = this.endTime;
    data['end_hour'] = this.endHour;
    data['content'] = this.content;
    if (this.img != null) {
      data['img'] = this.img.map((v) => v.toJson()).toList();
    }
    if (this.replyImg != null) {
      data['reply_img'] = this.replyImg.map((v) => v.toJson()).toList();
    }
    data['receive_id'] = this.receiveId;
    data['status'] = this.status;
    data['reply_content'] = this.replyContent;
    data['is_sms'] = this.isSms;
    data['project_name'] = this.projectName;
    data['project_person_name'] = this.projectPersonName;
    data['receive_name'] = this.receiveName;
    return data;
  }
}

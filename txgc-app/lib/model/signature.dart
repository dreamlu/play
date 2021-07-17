class Signature {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  int projectPersonId;
  int prSignatureCategoryId;
  String name;
  String file;
  List<SignIds> signIds;
  int status;
  String projectName;
  String projectPersonName;
  String prSignatureCategoryName;
  String nowSignName;
  int signStatus;

  Signature(
      {this.id,
      this.createTime,
      this.updateTime,
      this.projectId,
      this.projectPersonId,
      this.prSignatureCategoryId,
      this.name,
      this.file,
      this.signIds,
      this.status,
      this.projectName,
      this.projectPersonName,
      this.prSignatureCategoryName,
      this.nowSignName,
      this.signStatus});

  Signature.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    projectPersonId = json['project_person_id'];
    prSignatureCategoryId = json['pr_signature_category_id'];
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
    prSignatureCategoryName = json['pr_signature_category_name'];
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
    data['pr_signature_category_id'] = this.prSignatureCategoryId;
    data['name'] = this.name;
    data['file'] = this.file;
    if (this.signIds != null) {
      data['sign_ids'] = this.signIds.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['project_name'] = this.projectName;
    data['project_person_name'] = this.projectPersonName;
    data['pr_signature_category_name'] = this.prSignatureCategoryName;
    data['now_sign_name'] = this.nowSignName;
    data['sign_status'] = this.signStatus;
    return data;
  }
}

class SignIds {
  int o;
  int id;
  String name;
  String reason;
  int status;

  SignIds({this.o, this.id, this.name, this.reason, this.status});

  SignIds.fromJson(Map<String, dynamic> json) {
    o = json['o'];
    id = json['id'];
    name = json['name'];
    reason = json['reason'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['o'] = this.o;
    data['id'] = this.id;
    data['name'] = this.name;
    data['reason'] = this.reason;
    data['status'] = this.status;
    return data;
  }
}

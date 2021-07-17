class Engine {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  String name;
  String content;
  String projectName;

  Engine(
      {this.id,
        this.createTime,
        this.updateTime,
        this.projectId,
        this.name,
        this.content,
        this.projectName});

  Engine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    name = json['name'];
    content = json['content'];
    projectName = json['project_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['name'] = this.name;
    data['content'] = this.content;
    data['project_name'] = this.projectName;
    return data;
  }
}

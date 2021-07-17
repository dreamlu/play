class ProjectList {
  int id;
  String name;
  String level;
  bool isExpand = false;
  bool isSelected = false;
  List<ProjectList> child;

  ProjectList(
      {this.id,
      this.name,
      this.level,
      this.child,
      this.isExpand = false,
      this.isSelected = false});

  ProjectList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    if (json['child'] != null && json['child'] != '') {
      child = new List<ProjectList>();
      json['child'].forEach((v) {
        child.add(new ProjectList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    if (this.child != null) {
      data['child'] = this.child.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Car {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  int engineId;
  String plate;
  int typ;
  int status;
  String projectName;
  String engineName;
  String carDriverName;

  Car(
      {this.id,
      this.createTime,
      this.updateTime,
      this.projectId,
      this.engineId,
      this.plate,
      this.typ,
      this.status,
      this.projectName,
      this.engineName,
      this.carDriverName});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    engineId = json['engine_id'];
    plate = json['plate'];
    typ = json['typ'];
    status = json['status'];
    projectName = json['project_name'];
    engineName = json['engine_name'];
    carDriverName = json['car_driver_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['engine_id'] = this.engineId;
    data['plate'] = this.plate;
    data['typ'] = this.typ;
    data['status'] = this.status;
    data['project_name'] = this.projectName;
    data['engine_name'] = this.engineName;
    data['car_driver_name'] = this.carDriverName;
    return data;
  }
}

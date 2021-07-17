class CarLog {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  int engineId;
  String carDriver;
  String plate;
  String startTime;
  String endTime;
  int typ;
  String projectName;
  String engineName;

  CarLog(
      {this.id,
        this.createTime,
        this.updateTime,
        this.projectId,
        this.engineId,
        this.carDriver,
        this.plate,
        this.startTime,
        this.endTime,
        this.typ,
        this.projectName,
        this.engineName});

  CarLog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    engineId = json['engine_id'];
    carDriver = json['car_driver'];
    plate = json['plate'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    typ = json['typ'];
    projectName = json['project_name'];
    engineName = json['engine_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['engine_id'] = this.engineId;
    data['car_driver'] = this.carDriver;
    data['plate'] = this.plate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['typ'] = this.typ;
    data['project_name'] = this.projectName;
    data['engine_name'] = this.engineName;
    return data;
  }
}

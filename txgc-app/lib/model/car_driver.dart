class CarDriver {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  int engineId;
  String name;
  String phone;
  String account;
  String password;
  int prCarId;
  String projectName;
  String engineName;
  String prCarPlate;

  CarDriver(
      {this.id,
        this.createTime,
        this.updateTime,
        this.projectId,
        this.engineId,
        this.name,
        this.phone,
        this.account,
        this.password,
        this.prCarId,
        this.projectName,
        this.engineName,
        this.prCarPlate});

  CarDriver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    engineId = json['engine_id'];
    name = json['name'];
    phone = json['phone'];
    account = json['account'];
    password = json['password'];
    prCarId = json['pr_car_id'];
    projectName = json['project_name'];
    engineName = json['engine_name'];
    prCarPlate = json['pr_car_plate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['engine_id'] = this.engineId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['account'] = this.account;
    data['password'] = this.password;
    data['pr_car_id'] = this.prCarId;
    data['project_name'] = this.projectName;
    data['engine_name'] = this.engineName;
    data['pr_car_plate'] = this.prCarPlate;
    return data;
  }
}

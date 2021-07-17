class UserLogin {
  int id;
  String msg;
  int status;
  String token;
  String password;
  User user;

  UserLogin(
      {this.id, this.msg, this.status, this.token, this.user, this.password});

  UserLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msg = json['msg'];
    status = json['status'];
    token = json['token'];
    password = json['password'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['msg'] = this.msg;
    data['status'] = this.status;
    data['token'] = this.token;
    data['password'] = this.password;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  int typ;
  String token;
  List<String> role;
  String g;
  int projectId;
  String projectName;
  int engineId;
  String engineName;
  int constructId;
  String user;
  String phone;
  String sign;

  User(
      {this.id,
      this.typ,
      this.token,
      this.role,
      this.g,
      this.projectId,
      this.engineId,
      this.constructId,
      this.user,
      this.phone,
      this.sign});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typ = json['typ'];
    token = json['token'];
    role = json['role'].cast<String>();
    g = json['g'];
    projectId = json['project_id'];
    projectName = json['project_name'];
    engineId = json['engine_id'];
    engineName = json['engine_name'];
    constructId = json['construct_id'];
    user = json['user'];
    phone = json['phone'];
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typ'] = this.typ;
    data['token'] = this.token;
    data['role'] = this.role;
    data['g'] = this.g;
    data['project_id'] = this.projectId;
    data['project_name'] = this.projectName;
    data['engine_id'] = this.engineId;
    data['engine_name'] = this.engineName;
    data['construct_id'] = this.constructId;
    data['user'] = this.user;
    data['phone'] = this.phone;
    data['sign'] = this.sign;
    return data;
  }
}

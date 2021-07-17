import 'media.dart';

class CarRecord {
  int id;
  String createTime;
  String updateTime;
  int projectId;
  String prCarDriver;
  String plate;
  String carType;
  String engine;
  int typ;
  String address;
  int money;
  List<Media> imgUrl;

  CarRecord({this.id, this.createTime, this.updateTime, this.projectId, this.prCarDriver, this.plate, this.carType, this.engine, this.typ, this.address, this.money, this.imgUrl});

  CarRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectId = json['project_id'];
    prCarDriver = json['pr_car_driver'];
    plate = json['plate'];
    carType = json['car_type'];
    engine = json['engine'];
    typ = json['typ'];
    address = json['address'];
    money = json['money'];
    if (json['img_url'] != null && json['img_url'] != '') {
      imgUrl = new List<Media>();
      json['img_url'].forEach((v) {
        imgUrl.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_id'] = this.projectId;
    data['pr_car_driver'] = this.prCarDriver;
    data['plate'] = this.plate;
    data['car_type'] = this.carType;
    data['engine'] = this.engine;
    data['typ'] = this.typ;
    data['address'] = this.address;
    data['money'] = this.money;
    if (this.imgUrl != null) {
      data['img'] = this.imgUrl.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

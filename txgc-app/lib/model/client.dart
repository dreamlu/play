class Client {
  int id;
  String createtime;
  int adminId;
  String name;
  String openid;
  String unionid;
  String headImg;
  String phone;
  int sex;
  String info;
  int type;
  int disId;
  String pName;
  int pDisId;
  String pHeadImg;
  int collectNum;
  int followNum;
  int couponNum;
  double account;
  int allianceId;
  List<Status> status;
  List<Status> statusShop;

  Client(
      {this.id,
      this.createtime,
      this.adminId,
      this.name,
      this.openid,
      this.unionid,
      this.headImg,
      this.phone,
      this.sex,
      this.info,
      this.type,
      this.disId,
      this.pName,
      this.pDisId,
      this.pHeadImg,
      this.collectNum,
      this.followNum,
      this.couponNum,
      this.account,
      this.allianceId,
      this.status,
      this.statusShop});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createtime = json['createtime'];
    adminId = json['admin_id'];
    name = json['name'];
    openid = json['openid'];
    unionid = json['unionid'];
    headImg = json['head_img'];
    phone = json['phone'];
    sex = json['sex'];
    info = json['info'];
    type = json['type'];
    disId = json['dis_id'];
    pName = json['p_name'];
    pDisId = json['p_dis_id'];
    pHeadImg = json['p_head_img'];
    collectNum = json['collect_num'];
    followNum = json['follow_num'];
    couponNum = json['coupon_num'];
    account = json['account'];
    allianceId = json['alliance_id'];
    if (json['status'] != null) {
      status = new List<Status>();
      json['status'].forEach((v) {
        status.add(new Status.fromJson(v));
      });
    }
    if (json['status_shop'] != null) {
      statusShop = new List<Status>();
      json['status_shop'].forEach((v) {
        statusShop.add(new Status.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createtime'] = this.createtime;
    data['admin_id'] = this.adminId;
    data['name'] = this.name;
    data['openid'] = this.openid;
    data['unionid'] = this.unionid;
    data['head_img'] = this.headImg;
    data['phone'] = this.phone;
    data['sex'] = this.sex;
    data['info'] = this.info;
    data['type'] = this.type;
    data['dis_id'] = this.disId;
    data['p_name'] = this.pName;
    data['p_dis_id'] = this.pDisId;
    data['p_head_img'] = this.pHeadImg;
    data['collect_num'] = this.collectNum;
    data['follow_num'] = this.followNum;
    data['coupon_num'] = this.couponNum;
    data['account'] = this.account;
    data['alliance_id'] = this.allianceId;
    if (this.status != null) {
      data['status'] = this.status.map((v) => v.toJson()).toList();
    }
    if (this.statusShop != null) {
      data['status_shop'] = this.statusShop.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  int status;
  int num;

  Status({this.status, this.num});

  Status.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['num'] = this.num;
    return data;
  }
}

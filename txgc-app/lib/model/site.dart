class Site {
  int id;
  String createTime;
  String updateTime;
  int constructId;
  int constructBranchId;
  String name;
  int ctSiteBidId;
  Object lat;
  Object lng;

  Site(
      {this.id,
        this.createTime,
        this.updateTime,
        this.constructId,
        this.constructBranchId,
        this.name,
        this.ctSiteBidId,
        this.lat,
        this.lng});

  Site.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    constructId = json['construct_id'];
    constructBranchId = json['construct_branch_id'];
    name = json['name'];
    ctSiteBidId = json['ct_site_bid_id'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['construct_id'] = this.constructId;
    data['construct_branch_id'] = this.constructBranchId;
    data['name'] = this.name;
    data['ct_site_bid_id'] = this.ctSiteBidId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

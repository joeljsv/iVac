

class Districts {
  int stateId;
  String stateName;

  Districts({this.stateId, this.stateName});

  Districts.fromJson(Map<String, dynamic> json) {
    stateId = json['district_id'];
    stateName = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_id'] = this.stateId;
    data['district_name'] = this.stateName;
    return data;
  }
}

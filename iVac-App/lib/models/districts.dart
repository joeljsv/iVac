// class Districts {
//   List<Districts> districts;
//   int ttl;

//   Districts({this.districts, this.ttl});

//   Districts.fromJson(Map<String, dynamic> json) {
  //     if (json['districts'] != null) {
  //       districts = new List<Districts>();
  //       json['districts'].forEach((v) {
  //         districts.add(new Districts.fromJson(v));
  //       });
//     }
//     ttl = json['ttl'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.districts != null) {
//       data['districts'] = this.districts.map((v) => v.toJson()).toList();
//     }
//     data['ttl'] = this.ttl;
//     return data;
//   }
// }

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

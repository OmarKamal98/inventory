class RoleModel {
  String? userId;
  String? roleName;

  RoleModel({this.userId, this.roleName});

  RoleModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['userId'] =  userId;
    data['roleName'] =roleName;
    return data;
  }
}
class UserApi {
  String? lastSeen;
  String? id;
  String? userName;
  String? email;
  String? jobTitle;
  int? empId;
  String? loc;
  List<String>? roleName;
  String? token;
  String? expiration;

  UserApi(
      {this.lastSeen,
        this.id,
        this.userName,
        this.email,
        this.jobTitle,
        this.empId,
        this.loc,
        this.roleName,
        this.token,
        this.expiration});

  UserApi.fromJson(Map<String, dynamic> json) {
    lastSeen = json['lastSeen'];
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    jobTitle = json['job_title'];
    empId = json['emp_id'];
    loc = json['loc'];
    roleName = json['roleName'].cast<String>();
    token = json['token'];
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lastSeen'] = lastSeen;
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    data['job_title'] = jobTitle;
    data['emp_id'] = empId;
    data['loc'] = loc;
    data['roleName'] = roleName;
    data['token'] = token;
    data['expiration'] = expiration;
    return data;
  }
}
class LoginData{
  String? userName;
  String? password;
  LoginData({required this.userName,required this.password});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userName'] = userName;
    data['password'] = password;
    return data;
  }
}

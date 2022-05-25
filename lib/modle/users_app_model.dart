class UsersApp {
  String? id;
  String? userName;
  String? email;
  String? phoneNumber;
  String? joBTitle;
  int? empId;
  String? lastSeen;
  List<String>? roles;

  UsersApp(
      {this.id,
        this.userName,
        this.email,
        this.phoneNumber,
        this.joBTitle,
        this.empId,
        this.lastSeen,
        this.roles});

  UsersApp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    joBTitle = json['joB_title'];
    empId = json['emp_id'];
    lastSeen = json['lastSeen'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id']=id;
    data['userName']=userName;
    data['email']=email;
    data['phoneNumber']=phoneNumber;
    data['joB_title'] =joBTitle;
    data['emp_id'] =empId;
    data['lastSeen'] =lastSeen;
    data['roles'] =roles;
    return data;
  }
}

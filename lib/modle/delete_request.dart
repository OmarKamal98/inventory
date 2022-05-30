class DeleteRequest {
  String? categoryName;
  String? reason;
  String? categoryUnit;
  String? categoryCode;
  String? username;

  DeleteRequest(
      {this.categoryName,
        this.reason,
        this.categoryUnit,
        this.categoryCode,
        this.username});

  DeleteRequest.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_Name'];
    reason = json['reason'];
    categoryUnit = json['category_Unit'];
    categoryCode = json['category_Code'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['category_Name'] = this.categoryName;
    data['reason'] = this.reason;
    data['category_Unit'] = this.categoryUnit;
    data['category_Code'] = this.categoryCode;
    data['username'] = this.username;
    return data;
  }
}

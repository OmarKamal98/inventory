class DeleteRequest {
  String? reason;
  String? categoryName;
  String? categoryUnit;
  String? categoryCode;

  DeleteRequest(
      {this.reason, this.categoryName, this.categoryUnit, this.categoryCode});

  DeleteRequest.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    categoryName = json['category_Name'];
    categoryUnit = json['category_Unit'];
    categoryCode = json['category_Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    data['category_Name'] = this.categoryName;
    data['category_Unit'] = this.categoryUnit;
    data['category_Code'] = this.categoryCode;
    return data;
  }
}

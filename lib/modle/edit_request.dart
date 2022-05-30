class EditRequest {
  String? categoryName;
  String? categoryUnit;
  String? categoryPrice;
  String? categoryCode;
  String? username;

  EditRequest(
      {this.categoryName,
        this.categoryUnit,
        this.categoryPrice,
        this.categoryCode,
        this.username});

  EditRequest.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_Name'];
    categoryUnit = json['category_Unit'];
    categoryPrice = json['category_Price'];
    categoryCode = json['category_Code'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['category_Name'] = this.categoryName;
    data['category_Unit'] = this.categoryUnit;
    data['category_Price'] = this.categoryPrice;
    data['category_Code'] = this.categoryCode;
    data['username'] = this.username;
    return data;
  }
}

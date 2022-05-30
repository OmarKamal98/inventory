class StocktakingModel {
  String? icode;
  String? idscr;
  String? iunit;
  String? username;
  String? reason;
  String? branches;
  double? invqty;
  StocktakingModel(
      {this.icode,
        this.idscr,
        this.iunit,
        this.username,
        this.reason,
        this.branches,
        this.invqty});
  StocktakingModel.fromJson(Map<String, dynamic> json) {
    icode = json['icode'];
    idscr = json['idscr'];
    iunit = json['iunit'];
    username = json['username'];
    reason = json['reason'];
    branches = json['branches'];
    invqty = json['invqty'].toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icode'] = this.icode;
    data['idscr'] = this.idscr;
    data['iunit'] = this.iunit;
    data['username'] = this.username;
    data['reason'] = this.reason;
    data['branches'] = this.branches;
    data['invqty'] = this.invqty;
    return data;
  }
}

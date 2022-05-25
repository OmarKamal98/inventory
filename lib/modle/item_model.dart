class Item {
  String? icode;
  String? icode1;
  String? icode2;
  String? icode3;
  String? idscr;
  double? icprice;
  String? iunit;
  String? iunit2;
  String? iunit3;
  String? iunit4;
  double? isprice;
  double? isprice2;
  double? isprice3;
  double? isprice4;
  double? iunitf;
  double? iunitf3;
  double? iunitf4;

  Item(
      {this.icode,
        this.icode1,
        this.icode2,
        this.icode3,
        this.idscr,
        this.icprice,
        this.iunit,
        this.iunit2,
        this.iunit3,
        this.iunit4,
        this.isprice,
        this.isprice2,
        this.isprice3,
        this.isprice4,
        this.iunitf,
        this.iunitf3,
        this.iunitf4});

  Item.fromJson(Map<String, dynamic> json) {
    icode = json['icode'];
    icode1 = json['icode1'];
    icode2 = json['icode2'];
    icode3 = json['icode3'];
    idscr = json['idscr'];
    icprice = json['icprice'].toDouble();
    iunit = json['iunit'];
    iunit2 = json['iunit2'];
    iunit3 = json['iunit3'];
    iunit4 = json['iunit4'];
    isprice = json['isprice'].toDouble();
    isprice2 = json['isprice2'].toDouble();
    isprice3 = json['isprice3'].toDouble();
    isprice4 = json['isprice4'].toDouble();
    iunitf = json['iunitf'].toDouble();
    iunitf3 = json['iunitf3'].toDouble();
    iunitf4 = json['iunitf4'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['icode'] = icode;
    data['icode1'] =icode1;
    data['icode2'] = icode2;
    data['icode3'] =icode3;
    data['idscr'] =idscr;
    data['icprice'] = icprice as double;
    data['iunit'] = iunit;
    data['iunit2'] =iunit2;
    data['iunit3'] = iunit3;
    data['iunit4'] = iunit4;
    data['isprice'] = isprice as double;
    data['isprice2'] = isprice2 as double;
    data['isprice3'] =isprice3 as double;
    data['isprice4'] = isprice4 as double;
    data['iunitf'] = iunitf;
    data['iunitf3'] = iunitf3;
    data['iunitf4'] = iunitf4;
    return data;
  }
}

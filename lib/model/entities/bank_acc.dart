class BankAcc {
  String? stk;
  String? bank;
  String? branch;

  BankAcc({this.stk, this.bank, this.branch});

  BankAcc.fromJson(Map<String, dynamic> json) {
    stk = json['stk'];
    bank = json['bank'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stk'] = this.stk;
    data['bank'] = this.bank;
    data['branch'] = this.branch;
    return data;
  }


}

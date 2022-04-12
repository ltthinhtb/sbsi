class AccountStatus {
  String? cmd;
  String? oID;
  int? rc;
  String? rs;
  List<AccountAssets>? data;

  AccountStatus({this.cmd, this.oID, this.rc, this.rs, this.data});

  AccountStatus.fromJson(Map<String, dynamic> json) {
    cmd = json['cmd'];
    oID = json['oID'];
    rc = json['rc'];
    rs = json['rs'];
    if (json['data'] != null) {
      data = <AccountAssets>[];
      json['data'].forEach((v) {
        data!.add(AccountAssets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmd'] = cmd;
    data['oID'] = oID;
    data['rc'] = rc;
    data['rs'] = rs;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccountAssets {
  String? cashBalance;
  String? debt;
  String? cashAvai;
  String? withdrawalCash;
  String? withdrawalEe;
  String? payment;
  String? tempEe;
  String? apT0;
  String? apT1;
  String? apT2;
  String? arT0;
  String? arT1;
  String? arT2;
  String? collateral;
  String? sellUnmatch;
  String? buyUnmatch;
  String? cashBlock;
  String? sumAp;
  String? withdraw;
  String? depositFee;
  String? tempeeUsed;
  String? tempeeUsing;
  String? assets;
  String? cashAdvanceAvai;
  String? avaiColla;
  String? cashInout;
  String? cashTempDayOut;
  String? vsd;

  AccountAssets(
      {this.cashBalance,
      this.debt,
      this.cashAvai,
      this.withdrawalCash,
      this.withdrawalEe,
      this.payment,
      this.tempEe,
      this.apT0,
      this.apT1,
      this.apT2,
      this.arT0,
      this.arT1,
      this.arT2,
      this.collateral,
      this.sellUnmatch,
      this.buyUnmatch,
      this.cashBlock,
      this.sumAp,
      this.withdraw,
      this.depositFee,
      this.tempeeUsed,
      this.tempeeUsing,
      this.assets,
      this.cashAdvanceAvai,
      this.avaiColla,
      this.cashInout,
      this.cashTempDayOut,
      this.vsd});

  AccountAssets.fromJson(Map<String, dynamic> json) {
    cashBalance = json['cash_balance'];
    debt = json['debt'];
    cashAvai = json['cash_avai'];
    withdrawalCash = json['withdrawal_cash'];
    withdrawalEe = json['withdrawal_ee'];
    payment = json['payment'];
    tempEe = json['temp_ee'];
    apT0 = json['ap_t0'];
    apT1 = json['ap_t1'];
    apT2 = json['ap_t2'];
    arT0 = json['ar_t0'];
    arT1 = json['ar_t1'];
    arT2 = json['ar_t2'];
    collateral = json['collateral'];
    sellUnmatch = json['sell_unmatch'];
    buyUnmatch = json['buy_unmatch'];
    cashBlock = json['cash_block'];
    sumAp = json['sum_ap'];
    withdraw = json['withdraw'];
    depositFee = json['deposit_fee'];
    tempeeUsed = json['tempee_used'];
    tempeeUsing = json['tempee_using'];
    assets = json['assets'];
    cashAdvanceAvai = json['cash_advance_avai'];
    avaiColla = json['avaiColla'];
    cashInout = json['cash_inout'];
    cashTempDayOut = json['cash_temp_day_out'];
    vsd = json['vsd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cash_balance'] = cashBalance;
    data['debt'] = debt;
    data['cash_avai'] = cashAvai;
    data['withdrawal_cash'] = withdrawalCash;
    data['withdrawal_ee'] = withdrawalEe;
    data['payment'] = payment;
    data['temp_ee'] = tempEe;
    data['ap_t0'] = apT0;
    data['ap_t1'] = apT1;
    data['ap_t2'] = apT2;
    data['ar_t0'] = arT0;
    data['ar_t1'] = arT1;
    data['ar_t2'] = arT2;
    data['collateral'] = collateral;
    data['sell_unmatch'] = sellUnmatch;
    data['buy_unmatch'] = buyUnmatch;
    data['cash_block'] = cashBlock;
    data['sum_ap'] = sumAp;
    data['withdraw'] = withdraw;
    data['deposit_fee'] = depositFee;
    data['tempee_used'] = tempeeUsed;
    data['tempee_using'] = tempeeUsing;
    data['assets'] = assets;
    data['cash_advance_avai'] = cashAdvanceAvai;
    data['avaiColla'] = avaiColla;
    data['cash_inout'] = cashInout;
    data['cash_temp_day_out'] = cashTempDayOut;
    data['vsd'] = vsd;
    return data;
  }
}

class AccountMStatus {
  String? assets;
  String? imKH;
  String? h;
  String? equity;
  String? cashBalance;
  String? collateral;
  String? lmv;
  String? lmv0;
  String? debt;
  String? ee;
  String? ee50;
  String? ee60;
  String? ee70;
  String? mr;
  String? mrEe;
  String? sumAp;
  String? withdraw;
  String? debtExpire;
  String? withdrawalCash;
  String? withdrawalFull;
  String? overDraft;
  String? withdrawal;
  String? cashAvai;
  String? withdrawalEe;
  String? imKh;
  String? tempEe;
  String? marginRatio;
  String? marginRatioUb;
  String? buyUnmatch;
  String? buyMr;
  String? sellUnmatch;
  String? service;
  String? action;
  String? callLmv;
  String? sellLmv;
  String? apT0;
  String? apT1;
  String? apT2;
  String? arT0;
  String? arT1;
  String? arT2;
  String? loanFee;
  String? a1;
  String? a3;
  String? a2;
  String? a4;
  String? a5;
  String? a6;
  String? a7;
  String? eeIncApp;
  String? temp2;
  String? cashBlock;
  String? cashTempDayOut;
  String? depositFee;
  String? tdck;
  String? totalAsset;
  String? totalEquity;
  String? cashAdvanceAvai;
  String? maxRate;
  String? group;
  String? payment;
  String? maxLoan;

  AccountMStatus(
      {this.assets,
      this.imKH,
      this.h,
      this.equity,
      this.cashBalance,
      this.collateral,
      this.lmv,
      this.lmv0,
      this.debt,
      this.ee,
      this.ee50,
      this.ee60,
      this.ee70,
      this.mr,
      this.mrEe,
      this.sumAp,
      this.withdraw,
      this.debtExpire,
      this.withdrawalCash,
      this.withdrawalFull,
      this.overDraft,
      this.withdrawal,
      this.cashAvai,
      this.withdrawalEe,
      this.imKh,
      this.tempEe,
      this.marginRatio,
      this.marginRatioUb,
      this.buyUnmatch,
      this.buyMr,
      this.sellUnmatch,
      this.service,
      this.action,
      this.callLmv,
      this.sellLmv,
      this.apT0,
      this.apT1,
      this.apT2,
      this.arT0,
      this.arT1,
      this.arT2,
      this.loanFee,
      this.a1,
      this.a3,
      this.a2,
      this.a4,
      this.a5,
      this.a6,
      this.a7,
      this.eeIncApp,
      this.temp2,
      this.cashBlock,
      this.cashTempDayOut,
      this.depositFee,
      this.tdck,
      this.totalAsset,
      this.totalEquity,
      this.cashAdvanceAvai,
      this.maxRate,
      this.group,
      this.payment,
      this.maxLoan});

  AccountMStatus.fromJson(Map<String, dynamic> json) {
    assets = json['assets'];
    imKH = json['imKH'];
    h = json['h'];
    equity = json['equity'];
    cashBalance = json['cash_balance'];
    collateral = json['collateral'];
    lmv = json['lmv'];
    lmv0 = json['lmv_0'];
    debt = json['debt'];
    ee = json['ee'];
    ee50 = json['ee_50'];
    ee60 = json['ee_60'];
    ee70 = json['ee_70'];
    mr = json['mr'];
    mrEe = json['mr_ee'];
    sumAp = json['sum_ap'];
    withdraw = json['withdraw'];
    debtExpire = json['debtExpire'];
    withdrawalCash = json['withdrawal_cash'];
    withdrawalFull = json['withdrawal_full'];
    overDraft = json['overDraft'];
    withdrawal = json['withdrawal'];
    cashAvai = json['cash_avai'];
    withdrawalEe = json['withdrawal_ee'];
    imKh = json['im_kh'];
    tempEe = json['temp_ee'];
    marginRatio = json['margin_ratio'];
    marginRatioUb = json['margin_ratio_ub'];
    buyUnmatch = json['buy_unmatch'];
    buyMr = json['buy_mr'];
    sellUnmatch = json['sell_unmatch'];
    service = json['service'];
    action = json['action'];
    callLmv = json['call_lmv'];
    sellLmv = json['sell_lmv'];
    apT0 = json['ap_t0'];
    apT1 = json['ap_t1'];
    apT2 = json['ap_t2'];
    arT0 = json['ar_t0'];
    arT1 = json['ar_t1'];
    arT2 = json['ar_t2'];
    loanFee = json['loan_fee'];
    a1 = json['a1'];
    a3 = json['a3'];
    a2 = json['a2'];
    a4 = json['a4'];
    a5 = json['a5'];
    a6 = json['a6'];
    a7 = json['a7'];
    eeIncApp = json['ee_inc_app'];
    temp2 = json['temp2'];
    cashBlock = json['cash_block'];
    cashTempDayOut = json['cash_temp_day_out'];
    depositFee = json['deposit_fee'];
    tdck = json['tdck'];
    totalAsset = json['total_asset'];
    totalEquity = json['total_equity'];
    cashAdvanceAvai = json['cash_advance_avai'];
    maxRate = json['max_rate'];
    group = json['group'];
    payment = json['payment'];
    maxLoan = json['max_loan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assets'] = assets;
    data['imKH'] = imKH;
    data['h'] = h;
    data['equity'] = equity;
    data['cash_balance'] = cashBalance;
    data['collateral'] = collateral;
    data['lmv'] = lmv;
    data['lmv_0'] = lmv0;
    data['debt'] = debt;
    data['ee'] = ee;
    data['ee_50'] = ee50;
    data['ee_60'] = ee60;
    data['ee_70'] = ee70;
    data['mr'] = mr;
    data['mr_ee'] = mrEe;
    data['sum_ap'] = sumAp;
    data['withdraw'] = withdraw;
    data['debtExpire'] = debtExpire;
    data['withdrawal_cash'] = withdrawalCash;
    data['withdrawal_full'] = withdrawalFull;
    data['overDraft'] = overDraft;
    data['withdrawal'] = withdrawal;
    data['cash_avai'] = cashAvai;
    data['withdrawal_ee'] = withdrawalEe;
    data['im_kh'] = imKh;
    data['temp_ee'] = tempEe;
    data['margin_ratio'] = marginRatio;
    data['margin_ratio_ub'] = marginRatioUb;
    data['buy_unmatch'] = buyUnmatch;
    data['buy_mr'] = buyMr;
    data['sell_unmatch'] = sellUnmatch;
    data['service'] = service;
    data['action'] = action;
    data['call_lmv'] = callLmv;
    data['sell_lmv'] = sellLmv;
    data['ap_t0'] = apT0;
    data['ap_t1'] = apT1;
    data['ap_t2'] = apT2;
    data['ar_t0'] = arT0;
    data['ar_t1'] = arT1;
    data['ar_t2'] = arT2;
    data['loan_fee'] = loanFee;
    data['a1'] = a1;
    data['a3'] = a3;
    data['a2'] = a2;
    data['a4'] = a4;
    data['a5'] = a5;
    data['a6'] = a6;
    data['a7'] = a7;
    data['ee_inc_app'] = eeIncApp;
    data['temp2'] = temp2;
    data['cash_block'] = cashBlock;
    data['cash_temp_day_out'] = cashTempDayOut;
    data['deposit_fee'] = depositFee;
    data['tdck'] = tdck;
    data['total_asset'] = totalAsset;
    data['total_equity'] = totalEquity;
    data['cash_advance_avai'] = cashAdvanceAvai;
    data['max_rate'] = maxRate;
    data['group'] = group;
    data['payment'] = payment;
    data['max_loan'] = maxLoan;
    return data;
  }
}

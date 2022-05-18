class ReportStockResponse {
  List<Head>? head;
  List<Content>? content;

  ReportStockResponse({this.head, this.content});

  ReportStockResponse.fromJson(Map<String, dynamic> json) {
    if (json['Head'] != null) {
      head = <Head>[];
      json['Head'].forEach((v) {
        head!.add(new Head.fromJson(v));
      });
    }
    if (json['Content'] != null) {
      content = <Content>[];
      json['Content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.head != null) {
      data['Head'] = this.head!.map((v) => v.toJson()).toList();
    }
    if (this.content != null) {
      data['Content'] = this.content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Head {
  int? iD;
  int? companyID;
  int? yearPeriod;
  String? termCode;
  String? termName;
  String? termNameEN;
  int? reportTermID;
  int? displayOrdering;
  String? united;
  String? auditedStatus;
  String? periodBegin;
  String? periodEnd;
  int? totalRow;
  int? businessType;

  Head(
      {this.iD,
      this.companyID,
      this.yearPeriod,
      this.termCode,
      this.termName,
      this.termNameEN,
      this.reportTermID,
      this.displayOrdering,
      this.united,
      this.auditedStatus,
      this.periodBegin,
      this.periodEnd,
      this.totalRow,
      this.businessType});

  String get termYear {
    if (termCode == "N") {
      return '$yearPeriod';
    } else
      return '$termCode/$yearPeriod';
  }

  Head.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    companyID = json['CompanyID'];
    yearPeriod = json['YearPeriod'];
    termCode = json['TermCode'];
    termName = json['TermName'];
    termNameEN = json['TermNameEN'];
    reportTermID = json['ReportTermID'];
    displayOrdering = json['DisplayOrdering'];
    united = json['United'];
    auditedStatus = json['AuditedStatus'];
    periodBegin = json['PeriodBegin'];
    periodEnd = json['PeriodEnd'];
    totalRow = json['TotalRow'];
    businessType = json['BusinessType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CompanyID'] = this.companyID;
    data['YearPeriod'] = this.yearPeriod;
    data['TermCode'] = this.termCode;
    data['TermName'] = this.termName;
    data['TermNameEN'] = this.termNameEN;
    data['ReportTermID'] = this.reportTermID;
    data['DisplayOrdering'] = this.displayOrdering;
    data['United'] = this.united;
    data['AuditedStatus'] = this.auditedStatus;
    data['PeriodBegin'] = this.periodBegin;
    data['PeriodEnd'] = this.periodEnd;
    data['TotalRow'] = this.totalRow;
    data['BusinessType'] = this.businessType;
    return data;
  }
}

class Content {
  int? iD;
  int? reportNormID;
  String? name;
  String? nameEn;
  int? parentReportNormID;
  String? reportComponentName;
  String? reportComponentNameEn;
  String? unit;
  String? unitEn;
  int? reportComponentTypeID;
  int? childTotal;
  int? levels;
  double? value1;
  double? value2;
  double? value3;
  double? value4;

  List<double> get value => [value1!, value2!, value3!, value4!];

  Content(
      {this.iD,
      this.reportNormID,
      this.name,
      this.nameEn,
      this.parentReportNormID,
      this.reportComponentName,
      this.reportComponentNameEn,
      this.unit,
      this.unitEn,
      this.reportComponentTypeID,
      this.childTotal,
      this.levels,
      this.value1,
      this.value2,
      this.value3,
      this.value4});

  Content.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    reportNormID = json['ReportNormID'];
    name = json['Name'];
    nameEn = json['NameEn'];
    parentReportNormID = json['ParentReportNormID'];
    reportComponentName = json['ReportComponentName'];
    reportComponentNameEn = json['ReportComponentNameEn'];
    unit = json['Unit'];
    unitEn = json['UnitEn'];
    reportComponentTypeID = json['ReportComponentTypeID'];
    childTotal = json['ChildTotal'];
    levels = json['Levels'];
    value1 = json['Value1'];
    value2 = json['Value2'];
    value3 = json['Value3'];
    value4 = json['Value4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ReportNormID'] = this.reportNormID;
    data['Name'] = this.name;
    data['NameEn'] = this.nameEn;
    data['ParentReportNormID'] = this.parentReportNormID;
    data['ReportComponentName'] = this.reportComponentName;
    data['ReportComponentNameEn'] = this.reportComponentNameEn;
    data['Unit'] = this.unit;
    data['UnitEn'] = this.unitEn;
    data['ReportComponentTypeID'] = this.reportComponentTypeID;
    data['ChildTotal'] = this.childTotal;
    data['Levels'] = this.levels;
    data['Value1'] = this.value1;
    data['Value2'] = this.value2;
    data['Value3'] = this.value3;
    data['Value4'] = this.value4;
    return data;
  }
}

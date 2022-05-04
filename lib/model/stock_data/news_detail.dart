class NewsDetail {
  int? articleID;
  String? title;
  String? head;
  String? headImageUrl;
  String? publishTime;
  String? author;
  String? content;
  String? thumbImageUrl;
  String? uRL;
  String? source;
  int? wordCount;
  String? tag;
  List<Stock>? stock;

  NewsDetail(
      {this.articleID,
        this.title,
        this.head,
        this.headImageUrl,
        this.publishTime,
        this.author,
        this.content,
        this.thumbImageUrl,
        this.uRL,
        this.source,
        this.wordCount,
        this.tag,
        this.stock});

  NewsDetail.fromJson(Map<String, dynamic> json) {
    articleID = json['ArticleID'];
    title = json['Title'];
    head = json['Head'];
    headImageUrl = json['HeadImageUrl'];
    publishTime = json['PublishTime'];
    author = json['Author'];
    content = json['Content'];
    thumbImageUrl = json['ThumbImageUrl'];
    uRL = json['URL'];
    source = json['Source'];
    wordCount = json['WordCount'];
    tag = json['Tag'];
    if (json['Stock'] != null) {
      stock = <Stock>[];
      json['Stock'].forEach((v) {
        stock!.add(new Stock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ArticleID'] = this.articleID;
    data['Title'] = this.title;
    data['Head'] = this.head;
    data['HeadImageUrl'] = this.headImageUrl;
    data['PublishTime'] = this.publishTime;
    data['Author'] = this.author;
    data['Content'] = this.content;
    data['ThumbImageUrl'] = this.thumbImageUrl;
    data['URL'] = this.uRL;
    data['Source'] = this.source;
    data['WordCount'] = this.wordCount;
    data['Tag'] = this.tag;
    if (this.stock != null) {
      data['Stock'] = this.stock!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stock {
  String? stockCode;
  int? closePrice;
  int? change;
  double? perChange;
  int? totalVol;
  String? financeURL;
  int? colorId;
  int? catID;

  Stock(
      {this.stockCode,
        this.closePrice,
        this.change,
        this.perChange,
        this.totalVol,
        this.financeURL,
        this.colorId,
        this.catID});

  Stock.fromJson(Map<String, dynamic> json) {
    stockCode = json['StockCode'];
    closePrice = json['ClosePrice'];
    change = json['Change'];
    perChange = json['PerChange'];
    totalVol = json['TotalVol'];
    financeURL = json['FinanceURL'];
    colorId = json['ColorId'];
    catID = json['CatID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StockCode'] = this.stockCode;
    data['ClosePrice'] = this.closePrice;
    data['Change'] = this.change;
    data['PerChange'] = this.perChange;
    data['TotalVol'] = this.totalVol;
    data['FinanceURL'] = this.financeURL;
    data['ColorId'] = this.colorId;
    data['CatID'] = this.catID;
    return data;
  }
}


class NewsStock {
  String? stockCode;
  int? channelID;
  String? head;
  int? articleID;
  String? title;
  String? publishTime;
  String? content;
  String? source;
  String? author;
  String? uRL;
  int? totalRow;

  DateTime get time => DateTime.parse(publishTime!) ;

  NewsStock(
      {this.stockCode,
        this.channelID,
        this.head,
        this.articleID,
        this.title,
        this.publishTime,
        this.content,
        this.source,
        this.author,
        this.uRL,
        this.totalRow});

  NewsStock.fromJson(Map<String, dynamic> json) {
    stockCode = json['StockCode'];
    channelID = json['ChannelID'];
    head = json['Head'];
    articleID = json['ArticleID'];
    title = json['Title'];
    publishTime = json['PublishTime'];
    content = json['Content'];
    source = json['Source'];
    author = json['Author'];
    uRL = json['URL'];
    totalRow = json['TotalRow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StockCode'] = this.stockCode;
    data['ChannelID'] = this.channelID;
    data['Head'] = this.head;
    data['ArticleID'] = this.articleID;
    data['Title'] = this.title;
    data['PublishTime'] = this.publishTime;
    data['Content'] = this.content;
    data['Source'] = this.source;
    data['Author'] = this.author;
    data['URL'] = this.uRL;
    data['TotalRow'] = this.totalRow;
    return data;
  }
}

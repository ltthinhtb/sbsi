import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/configs/app_configs.dart';
import 'package:sbsi/model/stock_data/list_news_stock.dart';
import 'package:sbsi/model/stock_data/news_detail.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/date_utils.dart';
import '../../../widgets/webviewNews.dart';

class NewsComponent extends StatelessWidget {
  final NewsStock news;

  const NewsComponent({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsDetail>(
        builder: (BuildContext context, snapshot) {
          var url = "";
          final widthImage = (100 / 375) * MediaQuery.of(context).size.width;
          if (snapshot.hasData) {
            url = snapshot.data?.headImageUrl ?? "";
          }
          return GestureDetector(
            onTap: () {
              Get.to(NewsWeb(
                title: news.title ?? "",
                id: news.articleID!,
              ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    url.isEmpty
                        ? Container(
                            height: widthImage,
                            width: widthImage,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImages.newsPlace))),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CachedNetworkImage(
                              height: widthImage,
                              width: widthImage,
                              imageUrl: url,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                height: widthImage,
                                width: widthImage,
                                decoration: const BoxDecoration(
                                  color: AppColors.textGrey,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: widthImage,
                                width: widthImage,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(AppImages.newsPlace))),
                              ),
                            ),
                          ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          news.title ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontWeight: FontWeight.w700, height: 24 / 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          news.head ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              color: AppColors.textSecond, height: 16 / 12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateTimeUtils.toDateString(news.time,
                              format: AppConfigs.dateTimeDisplayFormat),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              height: 16 / 12, color: AppColors.textGrey),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          );
        },
        future: Get.find<ApiService>().getNewsDetail(news.articleID!));
  }
}

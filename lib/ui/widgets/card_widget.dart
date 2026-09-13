import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_2/core/app_color.dart';
import 'package:project_2/models/article_model.dart';
import 'package:project_2/ui/widgets/text_widget.dart';
import 'package:project_2/utils/formated_date.dart';

class CardWidget extends StatelessWidget {
  final ArticleModel article;
  const CardWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child:
                article.urlToImage.isNotEmpty ||
                    article.urlToImage != 'No Image'
                ? CachedNetworkImage(
                    imageUrl: article.urlToImage,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.kPrimaryColor4,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Image.asset(
                          'assets/images/image.png',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.asset(
                      'assets/images/image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          TextWidget(
            text: article.title,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.kPrimaryColor1,
          ),
          TextWidget(
            text: article.author,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColor.kPrimaryColor4,
          ),
          TextWidget(
            text: article.description,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColor.kPrimaryColor5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [TextWidget(text: formatedDate(article.publishedAt))],
          ),
        ],
      ),
    );
  }
}

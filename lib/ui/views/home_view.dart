import 'package:flutter/material.dart';
import 'package:project_2/core/app_color.dart';
import 'package:project_2/core/category_enum.dart';
import 'package:project_2/models/article_model.dart';
import 'package:project_2/services/news_service.dart';
import 'package:project_2/ui/widgets/card_widget.dart';
import 'package:project_2/ui/widgets/news_category_tabbar.dart';
import 'package:project_2/ui/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ==================== Pagination Variables ====================
  int currentPage = 1;
  int pageSize = 10;
  int totalResult = 0;
  bool hasMore = true;
  bool isLoadingNextPage = false;
  List<ArticleModel> articles = [];
  bool isLoadingFirstPage = true;

  // ==================== App & Services State ====================
  final List<CategoryEnum> categories = CategoryEnum.values;
  CategoryEnum selectedCategory = CategoryEnum.general;
  late NewsService newsService;
  late ScrollController scrollController;

  // ==================== Listener ====================
  void onScroll() {
    double currentScroll = scrollController.position.pixels;
    double maxScroll = scrollController.position.maxScrollExtent;
    bool nearBottom = currentScroll >= (maxScroll - 300);
    if (nearBottom && hasMore && !isLoadingNextPage) {
      print('Loading next page');
      fetchedNextPage();
    }
  }

  // ==================== PAGINATION METHODS ====================

  void resetPagination() {
    setState(() {
      currentPage = 1;
      totalResult = 0;
      hasMore = true;
      isLoadingNextPage = false;
      articles.clear();
    });
  }

  Future<void> fetchedFirstPage() async {
    resetPagination();
    setState(() {
      isLoadingFirstPage = true;
    });
    try {
      final response = await newsService.fetchedArticles(
        country: 'us',
        category: selectedCategory.label,
        page: 1,
        pageSize: pageSize,
      );
      setState(() {
        articles = response.articles;
        totalResult = response.totalResults;
        isLoadingFirstPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingFirstPage = false;
      });
      throw Exception('Error: ${e.toString()}');
    }
  }

  Future<void> fetchedNextPage() async {
    if (isLoadingNextPage || !hasMore) return;
    setState(() {
      isLoadingNextPage = true;
      currentPage += 1;
    });
    try {
      final response = await newsService.fetchedArticles(
        country: 'us',
        category: selectedCategory.label,
        page: currentPage,
        pageSize: pageSize,
      );
      setState(() {
        isLoadingNextPage = false;
        if (articles.length > response.totalResults ||
            response.articles.isEmpty) {
          hasMore = false;
        }
      });
      articles.addAll(response.articles);
    } catch (e) {
      setState(() {
        isLoadingNextPage = false;
        currentPage -= 1;
      });
      throw Exception('Error: ${e.toString()}');
    }
  }

  // ====================Opens the given [urlString] in an external web browser ====================
  Future<void> openArticleUrl(String urlString) async {
    Uri uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  void initState() {
    super.initState();
    newsService = NewsService();
    scrollController = ScrollController();
    scrollController.addListener(onScroll);
    fetchedFirstPage();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.kPrimaryColor1,
          title: TextWidget(
            text: 'News App',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColor.kPrimaryColor2,
          ),
        ),
        body: Column(
          children: [
            NewsCategoryTabbar(
              tabs: categories.map((category) {
                return Tab(text: category.label);
              }).toList(),
              onTap: (index) {
                setState(() {
                  selectedCategory = categories[index];
                });
                fetchedFirstPage();
              },
            ),
            Expanded(
              child: isLoadingFirstPage
                  ? Center(child: CircularProgressIndicator())
                  : articles.isEmpty
                  ? Center(
                      child: TextWidget(
                        text: 'No Articles Found',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.kPrimaryColor4,
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: fetchedFirstPage,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: articles.length + (hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == articles.length) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final article = articles[index];
                          return InkWell(
                            onTap: () {
                              openArticleUrl(article.url);
                            },
                            child: CardWidget(article: article),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

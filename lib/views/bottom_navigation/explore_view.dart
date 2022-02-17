import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/controllers/article_data_temp.dart';
import 'package:psychotherapy_chatbot/models/article.dart';
import 'package:psychotherapy_chatbot/router/route_generator.dart';

class ExploreView extends StatelessWidget {
  ExploreView({Key? key}) : super(key: key);

  List<String> imagesPath = [
    "assets/images/brain.jpg",
    "assets/images/meditation.jpg",
    "assets/images/sleep.jpg"
  ];
  List<String> gridTitle = [
    "Brain Trainnig Excercise",
    "Meditation",
    "Sleep Sounds"
  ];
  List<String> routes = [brainTrainingList, meditationTimer, ''];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Explore",
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Image.asset("assets/images/robot.png"),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                  top: 20, bottom: 5, left: 30, right: 30),
              child: Text(
                "Quote of the Day",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "“You cannot always control what goes on outside, but you can always control what goes on inside.”",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          "Wayne Dyer",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  image: const AssetImage(
                    "assets/images/quote.jpg",
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                  top: 20, bottom: 5, left: 30, right: 30),
              child: Text(
                "For You",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                mainAxisSpacing: 20,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: List.generate(
                    gridTitle.length,
                    (index) => GridItem(
                          imagePath: imagesPath[index],
                          title: gridTitle[index],
                          route: routes[index],
                        )),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                  top: 20, bottom: 5, left: 30, right: 30),
              child: Text(
                "Article of the Day",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            ArticleCard(article: articleData)
          ],
        ),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  ArticleCard({Key? key, this.article}) : super(key: key);

  Article? article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationController.navigateWithArg(articleDetails, {
          "article": article,
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      article?.image ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(article?.category ?? "",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black38, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.bottomLeft,
                  child: Text(article?.title ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 20)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text("By ${article?.author}",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 14)),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(article?.datePosted ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  GridItem(
      {Key? key, @required this.title, @required this.imagePath, this.route})
      : super(key: key);

  final String? title;
  final String? imagePath;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationController.navigateTo(route!);
      },
      child: Container(
        child: Center(
          child: Text(
            title!,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white, fontSize: 22),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
            image: AssetImage(
              imagePath!,
            ),
          ),
        ),
      ),
    );
  }
}

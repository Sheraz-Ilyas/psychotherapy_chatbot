import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
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
  List<String> routes = [brainTrainingList, '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: Text(
                  "Quote of the Day",
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
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: const AssetImage(
                    "assets/images/quote.jpg",
                  ),
                ),
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
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Text(
                "Article of the Day",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            ArticleCard(
              article: Article(
                  id: 1,
                  title: "Nutritional Strategies to Ease Anxiety",
                  author: "Uma Naidoo",
                  datePosted: "2 hours ago",
                  content: "",
                  image: "assets/images/brain_training_1.jpg",
                  category: "Health    -    Diet"),
            )
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
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15, top: 10),
      height: MediaQuery.of(context).size.height * 0.55,
      child: Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
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
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black38)),
                  )
                ],
              ),
            ],
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

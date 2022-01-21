import 'package:flutter/material.dart';

class ExploreView extends StatelessWidget {
  ExploreView({Key? key}) : super(key: key);

  List<String> imagesPath = [
    "assets/images/brain.jpg",
    "assets/images/meditation.jpg"
  ];

  List<String> gridTitle = ["Brain Trainnig Excercise", "Meditation"];

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            padding: const EdgeInsets.all(10),
            children: List.generate(
                gridTitle.length,
                (index) => GridItem(
                      imagePath: imagesPath[index],
                      title: gridTitle[index],
                    )),
          ),
        ));
  }
}

class GridItem extends StatelessWidget {
  GridItem({Key? key, @required this.title, @required this.imagePath})
      : super(key: key);

  final String? title;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                Colors.black.withOpacity(0.7), BlendMode.dstATop),
            image: AssetImage(
              imagePath!,
            ),
          ),
        ),
      ),
    );
  }
}

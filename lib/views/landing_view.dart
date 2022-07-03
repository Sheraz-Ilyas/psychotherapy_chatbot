import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/router/route_generator.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final List<String> _sliderImages = [
    'assets/images/conversation.png',
    'assets/images/bulb.png',
    'assets/images/schedule.png',
    'assets/images/meditation.png'
  ];

  final Map<String, String> _sliderTitles = {
    'Cognitive Behavioral Therapy':
        'Use our chatbot to get rid of distracting ideas and refocus on what\'s really important.',
    'Brain Training Excersices':
        'Mental and physical exercises that help improve your mental and emotional well-being.',
    'Keep Track': 'Keep an eye on your emotions, moods, and journals.',
    'Meditation':
        'Practicing meditation on the go is easy with our meditation section.',
  };

  var _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: blue));
    return Scaffold(
        backgroundColor: blue,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _sliderImages.map(
                  (image) {
                    int index = _sliderImages.indexOf(image);
                    return Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentCarouselIndex == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.5)),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              CarouselSlider(
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.6,
                    enableInfiniteScroll: true,
                    viewportFraction: 1,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentCarouselIndex = index;
                      });
                    }),
                items: _sliderImages.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              i,
                              fit: BoxFit.contain,
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.25,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Text(
                                _sliderTitles.keys
                                    .toList()[_sliderImages.indexOf(i)],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                _sliderTitles.values
                                    .toList()[_sliderImages.indexOf(i)],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () => navigationController.navigateTo(authBody),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  child: Text(
                    'Get Started',
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(color: blue, fontSize: 20),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              )
            ],
          ),
        ));
  }
}

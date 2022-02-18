import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:psychotherapy_chatbot/widgets/play_button.dart';

class MeditationTimer extends StatefulWidget {
  const MeditationTimer({Key? key}) : super(key: key);

  @override
  State<MeditationTimer> createState() => _MeditationTimerState();
}

class _MeditationTimerState extends State<MeditationTimer>
    with SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  final String path = "assets/audio/meditation_file.mp3";
  bool isPlaying = false;
  bool isPaused = false;
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);
  late final Animation<Offset> _animation = Tween(
          begin: Offset.zero, end: const Offset(0, 0.08))
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Meditation Timer",
            style: Theme.of(context).textTheme.headline1,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              audioPlayer.stop();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SlideTransition(
              position: _animation,
              child: Image.asset(
                "assets/images/meditation_timer_bg.jpg",
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
            SizedBox(
              height: 150,
              width: 150,
              child: PlayButton(
                pauseIcon:
                    const Icon(Icons.pause, color: Colors.black, size: 90),
                playIcon:
                    const Icon(Icons.play_arrow, color: Colors.black, size: 90),
                onPressed: () async {
                  if (!isPlaying && !isPaused) {
                    ByteData bytes = await rootBundle.load(path);
                    Uint8List soundbytes = bytes.buffer
                        .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
                    await audioPlayer.playBytes(soundbytes);
                    setState(() {
                      isPlaying = true;
                    });
                  } else if (isPlaying) {
                    audioPlayer.pause();
                    setState(() {
                      isPlaying = false;
                      isPaused = true;
                    });
                  } else if (!isPlaying && isPaused) {
                    audioPlayer.resume();
                    setState(() {
                      isPlaying = true;
                      isPaused = false;
                    });
                  }
                },
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _position.toString().split(".")[0],
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 14),
                      ),
                      Text(
                        _duration.toString().split(".")[0],
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 14),
                      )
                    ],
                  ),
                ),
                Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey.shade300,
                    min: 0.0,
                    max: _duration.inSeconds.toDouble(),
                    value: _position.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        changeToSecond(value.toInt());
                        value = value;
                      });
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}

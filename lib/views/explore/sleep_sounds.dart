import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psychotherapy_chatbot/widgets/play_button.dart';

class SleepSounds extends StatefulWidget {
  const SleepSounds({Key? key}) : super(key: key);

  @override
  _SleepSoundsState createState() => _SleepSoundsState();
}

class _SleepSoundsState extends State<SleepSounds>
    with SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  final String path = "assets/audio/quran_sleep_file.mp3";
  bool isPlaying = false;
  bool isPaused = false;
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {});
    });
    audioPlayer.onAudioPositionChanged.listen((position) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Quran For Sleep",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Colors.white,
                ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              audioPlayer.stop();
              Navigator.of(context).pop();
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: SystemUiOverlay.values);
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/sleep_sounds_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: PlayButton(
                      pauseIcon: const Icon(Icons.pause,
                          color: Colors.black, size: 90),
                      playIcon: const Icon(Icons.play_arrow,
                          color: Colors.black, size: 90),
                      onPressed: () async {
                        if (!isPlaying && !isPaused) {
                          ByteData bytes = await rootBundle.load(path);
                          Uint8List soundbytes = bytes.buffer.asUint8List(
                              bytes.offsetInBytes, bytes.lengthInBytes);
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
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.33),
              Text(
                "Dua Before Sleeping",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Image.asset(
                "assets/images/sleep_dua.png",
                filterQuality: FilterQuality.high,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

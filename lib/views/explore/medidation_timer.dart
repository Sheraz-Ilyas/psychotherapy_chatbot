import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

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
                      Text(_position.toString().split(".")[0]),
                      Text(_duration.toString().split(".")[0])
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

class PlayButton extends StatefulWidget {
  final bool initialIsPlaying;
  final Icon playIcon;
  final Icon pauseIcon;
  final VoidCallback onPressed;

  PlayButton({
    required this.onPressed,
    this.initialIsPlaying = false,
    this.playIcon = const Icon(Icons.play_arrow),
    this.pauseIcon = const Icon(Icons.pause),
  });

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);
  static const _kRotationDuration = Duration(seconds: 5);

  late bool isPlaying;

  // rotation and scale animations
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  double _rotation = 0;
  double _scale = 0.85;

  bool get _showWaves => !_scaleController.isDismissed;

  void _updateRotation() => _rotation = _rotationController.value * 2 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  @override
  void initState() {
    isPlaying = widget.initialIsPlaying;
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration)
          ..addListener(() => setState(_updateRotation))
          ..repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration)
          ..addListener(() => setState(_updateScale));

    super.initState();
  }

  void _onToggle() {
    setState(() => isPlaying = !isPlaying);

    if (_scaleController.isCompleted) {
      _scaleController.reverse();
    } else {
      _scaleController.forward();
    }

    widget.onPressed();
  }

  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: IconButton(
        icon: isPlaying ? widget.pauseIcon : widget.playIcon,
        onPressed: _onToggle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_showWaves) ...[
            Blob(
                color: const Color(0xff0092ff),
                scale: _scale,
                rotation: _rotation),
            Blob(
                color: const Color(0xff4ac7b7),
                scale: _scale,
                rotation: _rotation * 2 - 30),
            Blob(
                color: const Color(0xffa4a6f6),
                scale: _scale,
                rotation: _rotation * 3 - 45),
          ],
          Container(
            constraints: const BoxConstraints.expand(),
            child: AnimatedSwitcher(
              child: _buildIcon(isPlaying),
              duration: _kToggleDuration,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}

class Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color color;

  const Blob({required this.color, this.rotation = 0, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ),
      ),
    );
  }
}

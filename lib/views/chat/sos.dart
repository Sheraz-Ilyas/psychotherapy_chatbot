import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SOS extends StatefulWidget {
  const SOS({Key? key}) : super(key: key);

  @override
  State<SOS> createState() => _SOSState();
}

class _SOSState extends State<SOS> {
  late Timer _timer;
  int _start = 4;
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "No, I'm Okay",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.grey, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.grey,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isActive
                  ? "Mental Health Helpline\n+92 311 7786264"
                  : "Emergency Help\nNeeded?",
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            Text(
              _isActive ? "Calling in..." : "Just hold the button to call",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            // make a big  circle button
            ElevatedButton(
              onPressed: () {},
              child: GestureDetector(
                onPanCancel: () {
                  setState(() {
                    _start = 4;
                    _isActive = false;
                    _timer.cancel();
                  });
                },
                onPanDown: (_) => {
                  _isActive = true,
                  _timer = Timer.periodic(
                    const Duration(seconds: 1),
                    (timer) {
                      setState(() {
                        _start--;
                        if (_start == 0) {
                          Navigator.pop(context);
                          _timer.cancel();
                          _start = 4;
                          _isActive = false;
                          launch("tel://+923117786264");
                        }
                      });
                    },
                  ),
                },
                child: _isActive
                    ? Text('$_start',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 50, color: Colors.white))
                    : const Icon(Icons.call, size: 50),
              ),
              style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                elevation: _isActive ? 10 : 0,
                minimumSize: const Size(150, 150),
                primary: Colors.red,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

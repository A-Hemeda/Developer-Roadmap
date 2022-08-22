import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayMusic extends StatefulWidget {
  const PlayMusic({Key key}) : super(key: key);

  @override
  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool t = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assetsAudioPlayer.open(Audio('assets/a.mp3'));
    assetsAudioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage('assets/download.jpg')),
            color: Colors.grey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('hh:mm a').format(DateTime.now()).toString(),
              style: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54),
            ),
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 15,
            ),
            const CircleAvatar(
              radius: 90,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/img.png'),
            ),
            Expanded(child: Container()),
            ClipPath(
              clipper: CustomClipperButton(),
              child: Container(
                width: 300,
                height: 150,
                color: Colors.grey.shade400,
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent,
                        spreadRadius: 0,
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white, width: 5)),
                      child: Text(
                        'أذان العصر  ',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey.shade800),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                assetsAudioPlayer.stop();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                width: 210,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Container(
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent,
                        Colors.blue.shade200,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'ايقاف',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    assetsAudioPlayer.stop();
  }
}

class CustomClipperButton extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height * 0.2);
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(0, size.height, size.width * 0.1, size.height);
    path.lineTo(size.width * 0.7 - 10, size.height);
    path.quadraticBezierTo(
        size.width * 0.7, size.height, size.width * 0.7, size.height * 0.95);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.30,
        size.width - 10, size.height * 0.3);
    path.quadraticBezierTo(
        size.width, size.height * 0.3, size.width, size.height * 0.3 - 10);
    path.lineTo(size.width, size.height * 0.2);
    path.quadraticBezierTo(size.width, 0, size.width * 0.9, 0);
    path.lineTo(size.width * 0.1, 0);
    path.quadraticBezierTo(0, 0, 0, size.height * 0.2);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

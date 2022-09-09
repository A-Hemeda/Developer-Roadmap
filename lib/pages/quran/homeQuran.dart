import 'dart:convert';
import 'dart:math';
import 'package:azkark/pages/home/home_page.dart';
import 'package:azkark/pages/quran/readingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/surah.dart';
import '../../util/navigate_between_pages/scale_route.dart';

class QuranHomeScreen extends StatefulWidget {
  const QuranHomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<QuranHomeScreen> with TickerProviderStateMixin {
  List<Surah> surahList = [];
  int selectedIndex = 0;
  bool isReverse = false;
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/surah.json');
    final data = await json.decode(response);
    for (var item in data["chapters"]) {
      surahList.add(Surah.fromMap(item));
    }
    debugPrint(surahList.length.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [ Transform.rotate(
          angle: isReverse ? pi : 2 * pi,
          child: IconButton(
              icon: const Icon(Icons.sort),
              onPressed: () {
                setState(() {
                  isReverse = !isReverse;
                });
              }),
        ),

        ],
        leading:IconButton(onPressed: ()=>Navigator.push(
          context,
          ScaleRoute(page: const HomePage()),
        ), icon: const Icon(Icons.arrow_back_outlined)),

      ),
      body: surahList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : chaptersList(isReverse ? surahList.reversed.toList() : surahList),
    );
  }

  Widget chaptersList(List<Surah> chapters) {
    return ListView.separated(
      controller: _controller,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          child: Text(chapters[index].id.toString()),
        ),

        title:  Text(
          chapters[index].arabicName,
          style: GoogleFonts.cairo(
            fontSize: 18,
          ),
        ),
      //  subtitle: Text(chapters[index].versesCount.toString()),
        trailing:Text(chapters[index].name,style: const TextStyle(color: Colors.blue),),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                SurahPage(surah: chapters[index]),
          ),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemCount: chapters.length,
    );
  }
}

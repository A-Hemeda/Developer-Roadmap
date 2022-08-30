import 'dart:convert';
import 'dart:math';
import 'package:azkark/pages/quran/Sora.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/surah.dart';



class Quran extends StatefulWidget {
  const Quran({Key key}) : super(key: key);

  @override
  _QuranState createState() => _QuranState();
}

class _QuranState extends State<Quran> with TickerProviderStateMixin {
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
        leading:IconButton(
          icon:const Icon( Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
        actions: [
          Transform.rotate(
            angle: isReverse ? pi : 2 * pi,
            child: IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  setState(() {
                    isReverse = !isReverse;
                  });
                }),
          )
        ],

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
        title: Text(chapters[index].name, style:const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,

        ),),
        subtitle: Text(chapters[index].versesCount.toString()),
        trailing: Text(
          chapters[index].arabicName,
          style:const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            fontFamily: '2'
          ),
        ),
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

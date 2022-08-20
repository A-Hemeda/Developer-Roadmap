
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/prayerTiming.dart';
import '../../providers/prayerTimingService.dart';
import '../../util/background.dart';

class PrayTimes extends StatefulWidget {
  PrayTimes({Key key}) : super(key: key);

  @override
  _PrayTimesState createState() => _PrayTimesState();
}

class _PrayTimesState extends State<PrayTimes> {
  JsonConnection jsonConnection = JsonConnection();
   Data list;

  static String city = 'Cairo';
  static String country = 'Egypt';
  static int method = 4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPTData();
  }

  final String url =
      'http://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=$method';

  Future getPTData() async {
    http.Response res = await http.get(Uri.parse(url), headers: {
      "Accept":
      "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
    });
    final data = jsonDecode(res.body);

    list = Data.fromJson(data);

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('مواقيت الصلاه'),
        ),
        body: FutureBuilder(
          future: getPTData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Container(

                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [CardBoxShadow],
                    ),
                    margin: const EdgeInsets.only( bottom: 10, top:10),
                    padding: const EdgeInsets.all(5),
                    width: 300,
                    child:

                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    bulidComtainer(snapshot.data.data.timings.fajr),
                                    const SizedBox(height: 12,),
                                    bulidComtainer(snapshot.data.data.timings.dhuhr),
                                    const SizedBox(height: 12,),
                                    bulidComtainer(snapshot.data.data.timings.asr),
                                    const SizedBox(height: 12,),
                                    bulidComtainer(snapshot.data.data.timings.maghrib),
                                    const SizedBox(height: 12,),
                                    bulidComtainer(snapshot.data.data.timings.isha),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    bulidComtainer('الفجر'),
                                    const SizedBox(height: 12,),
                                    bulidComtainer('الظهر'),
                                    const SizedBox(height: 12,),
                                    bulidComtainer('العصر'),
                                    const SizedBox(height: 12,),
                                    bulidComtainer('المغرب'),
                                    const SizedBox(height: 12,),
                                    bulidComtainer('العشاء'),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:  Container(
                                height: 25,
                                width: 110,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10)
                                ),

                                child: Center(child:

                                Text(snapshot.data.data.meta.timezone),

                                ),
                              ))
                        ],
                      ),
                    )
                ),
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      )],
    );
  }
  BoxShadow CardBoxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 2,
    blurRadius: 8,

  );

  Widget bulidComtainer(String name){
    return Container(
        height: 25,
        width: 60,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)
        ),

        child: Center(child: Text(name)));
  }
}

import 'package:booking_app/core/services/maps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/utilis/constants/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
        centerTitle: true,
        elevation: 10,
        backgroundColor: AppColors.kPrimaryColor,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.transparent),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child:
                  Maps(lat: 27.259102.toString(), long: 33.812999.toString()))
        ],
      ),
    );
  }
}

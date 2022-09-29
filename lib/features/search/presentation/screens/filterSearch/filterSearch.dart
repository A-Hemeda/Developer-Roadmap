import 'package:booking_app/core/component/others.dart';
import 'package:booking_app/core/utilis/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/filterSearchWidget.dart';
import 'filterSearchDetials.dart';
import 'mapScreen.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kPrimaryColor,
        title: const Text('Explore'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context: context, widget: const MapScreen());
            },
            icon: const Icon(
              Icons.map_outlined,
            ),
          ),
          IconButton(
            onPressed: () {
              navigateTo(context: context, widget: const FilterSearchDetails());
            },
            icon: const Icon(
              Icons.filter_alt_outlined,
            ),
          ),
        ],
      ),
      body: const FilterWidget(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../core/utilis/constants/colors.dart';

class FilterSearchDetails extends StatefulWidget {
  const FilterSearchDetails({Key? key}) : super(key: key);

  @override
  State<FilterSearchDetails> createState() => _FilterSearchDetailsState();
}

class _FilterSearchDetailsState extends State<FilterSearchDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
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
      body: Column(),
    );
  }
}

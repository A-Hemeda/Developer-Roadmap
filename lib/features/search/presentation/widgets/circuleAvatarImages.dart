import 'package:flutter/material.dart';
import '../../../../core/utilis/constants/app_strings.dart';
import '../../../../core/utilis/constants/assets_manager.dart';
import '../../../../core/utilis/constants/values_manger.dart';
import '../../../../core/component/my_text.dart';

class CircleAvatarItems extends StatelessWidget {
  CircleAvatarItems({Key? key}) : super(key: key);
  final List<String> _circleAvatarName = [
    AppStrings.hotel,
    AppStrings.backPacker,
    AppStrings.resort,
    AppStrings.apartment,
    AppStrings.villa,
    AppStrings.guestHouse,
    AppStrings.accommodation,
    AppStrings.bedAndBreakFast,
  ];
  final List<String> _circleAvatarImages = [
    ImageAssets.hotel3,
    ImageAssets.backPacker,
    ImageAssets.resort,
    ImageAssets.apartment,
    ImageAssets.villa,
    ImageAssets.guestHouse,
    ImageAssets.accommodation,
    ImageAssets.bedAndBreakFast,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      itemCount: 8,
      itemBuilder: (context, index) => Column(
        children: [
          CircleAvatar(
            radius: AppSize.s40,
            backgroundImage: AssetImage(_circleAvatarImages[index]),
          ),
          const SizedBox(
            height: AppSize.s5,
          ),
          MyText(
            text: _circleAvatarName[index],
            fontSize: AppSize.s10,
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }
}

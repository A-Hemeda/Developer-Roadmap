import 'package:flutter/material.dart';

import '../../../../../../../core/component/custom_text.dart';
import '../../../../../../../core/utilis/constants/colors.dart';

class BuildBooKingOrCancelItem extends StatelessWidget {
  final String roomName;
  final String image;
  final bool isBooking;
  final double price;
  final int people;
  final int children;

  const BuildBooKingOrCancelItem(
      {Key? key,
      required this.roomName,
      required this.image,
      required this.isBooking,
      required this.price,
      required this.people,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 250,
            width: double.infinity,
          child: Stack(
            children: [
              PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    Image.network(image, fit: BoxFit.cover),
                itemCount: 3,
                scrollDirection: Axis.horizontal,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                   Expanded(
                    child: CustomText(
                      text: roomName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors.teal,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: TextButton(
                      onPressed: () {},
                      child:  CustomText(
                        text: isBooking?'  Book now  ':' Cancel ',
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children:  [
                  CustomText(
                    text: '\$$price',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  const CustomText(
                    text: '/per night',
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ],
              ),
              Row(
                children: [
                   Expanded(
                    child: CustomText(
                      text: 'sleeps $people People + $children children',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                      color: AppColors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        CustomText(
                          text: 'More Details',
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:booking_app/core/component/my_text.dart';
import 'package:booking_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../../../core/component/custom_text.dart';
import '../../../../../../../core/utilis/constants/colors.dart';

class BuildUpcomingItem extends StatelessWidget {
  final String urlImage;
  final int? id;
  final String startDate;
  final String endDate;
  final int roomsNumber;
  final int peopleNumber;
  final bool isFavorite;
  final String hotelName;
  final String city;
  final String day;
  final String location;
  final String price;
  final double initialRating;

  const BuildUpcomingItem(
      {Key? key,
      required this.urlImage,
      required this.startDate,
      required this.endDate,
      required this.roomsNumber,
      required this.peopleNumber,
      required this.isFavorite,
      required this.hotelName,
      required this.city,
      required this.day,
      required this.location,
      required this.price,
      required this.initialRating,  required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Spacer(),
            CustomText(
              text:
                  '$startDate - $endDate, $roomsNumber Room $peopleNumber People',
              fontSize: 14,
              color: AppColors.white,
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.darkGrey,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(urlImage),
                  BlocConsumer<HomeCubit,HomeState>(
                    listener: (context,state){
                      if (state is UpdateBookingSuccessState)
                        {
                          HomeCubit.get(context).getUpcomingBooking();
                        }
                    },
                    builder: (context,state){
                      var cubit = HomeCubit.get(context);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: AppColors.darkGrey,
                          child: PopupMenuButton(
                            position: PopupMenuPosition.under,
                              icon:const Icon(Icons.menu_rounded,color: AppColors.white,),
                              color: AppColors.kPrimaryColor,
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child:TextButton(
                                    onPressed: (){
                                      cubit.updateBooking(hotelId:id! , type:"completed"  );

                                    },
                                    child: const MyText(text: 'Complete',colors: AppColors.blue,fontSize: 15 ,),
                                  ),

                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child:TextButton(
                                    onPressed: (){
                                      cubit.updateBooking(hotelId:id! , type:"cancelled"  );

                                    },
                                    child: const MyText(text: 'Cancel',colors: AppColors.red,fontSize: 15 ,),
                                  ),

                                ),

                              ]),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: hotelName,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.white,
                          ),
                        ),
                        CustomText(
                          text: "\$$price",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                    Row(
                      children: [Expanded(
                        child: CustomText(
                            text: '$day, $city ',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColors.teal,
                                size: 20,
                              ),
                              Expanded(
                                child: CustomText(
                                  text: location,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const CustomText(
                          text: "/per night",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: initialRating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: AppColors.teal,
                          ),
                          onRatingUpdate: (rating) {},
                          itemSize: 20,
                        ),
                        const Expanded(
                          child: CustomText(
                            text: '  80 Reviewers',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

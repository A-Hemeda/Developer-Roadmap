import 'package:booking_app/core/app_localization/app_localization.dart';
import 'package:booking_app/core/utilis/constants/app_strings.dart';
import 'package:booking_app/core/utilis/constants/colors.dart';
import 'package:booking_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: Scaffold(
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: AppColors.darkGrey,
                selectedItemColor: AppColors.teal,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: AppColors.grey,
                currentIndex: cubit.currentIndex,
                onTap: (index) => setState(() => cubit.currentIndex = index),
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.search),
                    label: AppStrings.explore.tr(context),
                    //   backgroundColor: AppColors.backGroundColorOfNaviBar,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.favorite_border),
                    label: AppStrings.trips.tr(context),
                    //   backgroundColor: AppColors.backGroundColorOfNaviBar,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person_sharp),
                    label: AppStrings.profile.tr(context),
                    // backgroundColor: AppColors.backGroundColorOfNaviBar,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

import 'package:booking_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/utilis/constants/assets_manager.dart';
import '../../../../core/utilis/constants/colors.dart';
import '../../../../core/utilis/constants/values_manger.dart';
import '../../../../core/component/my_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchItem extends StatelessWidget {
  SearchItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          if (state is SearchHotelSuccessState) {
            return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 3),
                itemCount: cubit.searchModel!.data.data.length,
                itemBuilder: (context, index) {
                  var _item = cubit.searchModel!.data.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(AppSize.s8),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s30),
                      ),
                      color: AppColors.darkGrey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (_item.images.isEmpty)
                            const Image(
                              image: AssetImage(ImageAssets.hotel),
                              height: AppSize.s100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          if (_item.images.isNotEmpty)
                            const Image(
                              image: AssetImage(ImageAssets.guestHouse),
                              height: AppSize.s100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          MyText(
                            text: _item.name,
                            fontSize: AppSize.s15,
                            fontWeight: FontWeight.w900,
                          ),
                          const SizedBox(
                            height: AppSize.s5,
                          ),
                          const MyText(
                            text: "1 Room 3 People",
                            fontSize: AppSize.s10,
                            colors: AppColors.grey,
                          ),
                          const MyText(
                            text: "12 - 22 sep",
                            fontSize: AppSize.s10,
                            fontWeight: FontWeight.w900,
                            colors: AppColors.grey,
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          if (state is SearchHotelLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Container());
          }
        });
  }
}

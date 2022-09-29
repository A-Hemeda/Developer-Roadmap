import 'package:booking_app/core/component/my_text.dart';
import 'package:booking_app/features/search/domain/entity/search_entity.dart';
import 'package:booking_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utilis/constants/app_strings.dart';
import '../../../../core/utilis/constants/colors.dart';
import '../../../../core/utilis/constants/values_manger.dart';
import '../../../../core/component/my_text_form_field.dart';
import '../widgets/circuleAvatarImages.dart';
import '../widgets/searchItem.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = SearchCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.kPrimaryColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.kPrimaryColor,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: AppColors.transparent),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyText(
                          text: AppStrings.search,
                          fontSize: AppSize.s22,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Container(
                          height: AppSize.s50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s30),
                            color: AppColors.darkGrey,
                          ),
                          child: MyTextForm(
                            enableBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: AppColors.grey)),
                            isDense: true,
                            controller: _controller,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.searchHint;
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: IconButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.searchForHotel(
                                    userSearchEntity: UserSearchEntity(
                                      name: _controller.text,
                                      address: '',
                                      maxPrice: '',
                                      minPrice: '',
                                      facilities0: '',
                                      facilities1: '',
                                      latitude: '',
                                      longitude: '',
                                      distance: '',
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.search,
                                color: AppColors.teal,
                              ),
                            ),
                            hintText: AppStrings.whereAreYouGoing,
                            radius: AppSize.s30,
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        SizedBox(
                          height: 105,
                          child: CircleAvatarItems(),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Row(
                          children: [
                            const MyText(
                                text: AppStrings.searchResult,
                                fontSize: AppSize.s16),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: const MyText(
                                text: AppStrings.clear,
                                fontSize: AppSize.s16,
                                colors: AppColors.teal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 600,
                      width: 900,
                      child: SearchItem(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

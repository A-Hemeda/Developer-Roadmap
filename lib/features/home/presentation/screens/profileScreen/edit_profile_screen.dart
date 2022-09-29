import 'package:booking_app/core/app_localization/app_localization.dart';
import 'package:booking_app/core/component/custom_button.dart';
import 'package:booking_app/core/component/toast.dart';
import 'package:booking_app/core/utilis/constants/colors.dart';
import 'package:booking_app/features/home/domain/use_cases/update_profile_data_usecase.dart';
import 'package:booking_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetProfileDataSuccessState) {
          showToast(
            text: HomeCubit.get(context).updateProfileModel!.en.toString(),
            state: ToastStates.success,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        userNameController.text = cubit.profileModel!.profileData.name;
        emailController.text = cubit.profileModel!.profileData.email;
        return Scaffold(
          backgroundColor: AppColors.darkGrey,
          appBar: AppBar(
            backgroundColor: AppColors.darkGrey,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Profile'.tr(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 4, color: AppColors.darkGrey),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: AppColors.white.withOpacity(.1),
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: (cubit.userImage != null)
                                    ? FileImage(cubit.userImage!)
                                        as ImageProvider
                                    : NetworkImage(
                                        cubit.profileModel!.profileData.image),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.addProfileImage();
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.teal,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Column(
                      children: [
                        TextFormField(
                          controller: userNameController,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your Name'.tr(context);
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: 'UserName'.tr(context),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'User Name'.tr(context),
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.darkGrey),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.grey,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        TextFormField(
                          controller: emailController,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your Email'.tr(context);
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: 'Email'.tr(context),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'Email'.tr(context),
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.darkGrey),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.grey,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    'Cancel'.tr(context),
                                    style: const TextStyle(color: Colors.black),
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: CustomButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.updateProfileData(
                                            updateImageEntity:
                                                UpdateImageEntity(
                                          userNameController.text,
                                          emailController.text,
                                          cubit.userImage,
                                        ));
                                      }
                                    },
                                    backgroundColor: Colors.teal,
                                    child: Text(
                                      'Save'.tr(context),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ))),
                          ],
                        ),
                      ],
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

import 'package:booking_app/core/component/toast.dart';
import 'package:booking_app/features/auth/register/domain/entities/user_info_entity.dart';
import 'package:booking_app/features/auth/register/presentation/cubit/user_register_cubit.dart';
import 'package:booking_app/features/auth/widgets/google_button.dart';
import 'package:booking_app/core/component/my_button.dart';
import 'package:booking_app/core/component/my_text.dart';
import 'package:booking_app/core/component/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app/injection_container.dart' as di;
import '../../../../../core/routes/routes_manager.dart';
import '../../../../../core/utilis/constants/app_strings.dart';
import '../../../../../core/utilis/constants/colors.dart';
import '../../../../../core/utilis/constants/values_manger.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  bool _isHidePass = true;
  bool _isHidePasss = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final confirmPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<UserRegisterCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        appBar: AppBar(
          elevation: AppSize.s0,
          backgroundColor: AppColors.kPrimaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyText(
                    text: AppStrings.signUp,
                    fontSize: AppSize.s28,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: MySignButton(
                        ontap: () {},
                      )),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  const Center(
                    child: MyText(
                      text: AppStrings.orLoginWith,
                      fontSize: AppSize.s15,
                      colors: AppColors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  MyTextForm(
                    enableBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.grey)),
                    labelText: AppStrings.name,
                    isDense: true,
                    radius: AppSize.s40,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.nameHint;
                      }
                      return null;
                    },
                    textInputType: TextInputType.name,
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  MyTextForm(
                    enableBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.grey)),
                    labelText: AppStrings.email,
                    isDense: true,
                    radius: AppSize.s40,
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.emailHint;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  MyTextForm(
                    enableBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.grey)),
                    isPassword: _isHidePass,
                    suffixIcon:
                        _isHidePass ? Icons.visibility_off : Icons.visibility,
                    suffixIconPressed: () {
                      setState(() {
                        _isHidePass = !_isHidePass;
                      });
                    },
                    labelText: AppStrings.password,
                    isDense: true,
                    radius: AppSize.s40,
                    textInputType: TextInputType.visiblePassword,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.passHint;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  MyTextForm(
                    enableBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.grey)),
                    isPassword: _isHidePasss,
                    suffixIcon:
                        _isHidePasss ? Icons.visibility_off : Icons.visibility,
                    suffixIconPressed: () {
                      setState(() {
                        _isHidePasss = !_isHidePasss;
                      });
                    },
                    labelText: AppStrings.confirmedPassword,
                    isDense: true,
                    radius: AppSize.s40,
                    textInputType: TextInputType.visiblePassword,
                    controller: confirmPassController,
                    validator: (value) {
                      if (value!.isEmpty ||
                          passwordController.text !=
                              confirmPassController.text) {
                        return AppStrings.passHintMatch;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s40,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: AppSize.s50,
                        width: double.infinity,
                        child:
                            BlocConsumer<UserRegisterCubit, UserRegisterState>(
                          listener: (BuildContext context, state) {
                            if (state is UserRegisterSuccessState) {
                              showToast(
                                text: AppStrings.successRegisterEn,
                                state: ToastStates.success,
                              );
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.loginRoute,
                              );
                            }
                          },
                          builder: (BuildContext context, Object? state) {
                            var cubit = UserRegisterCubit.get(context);
                            if (state is! UserRegisterLoadingState) {
                              return MyButton(
                                label: AppStrings.signUp,
                                fontWeight: FontWeight.w700,
                                fontSize: AppSize.s15,
                                radius: AppPadding.p12,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.registerWithEmail(
                                      userInfoEntity: UserInfoEntity(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        passwordConfirmation:
                                            passwordController.text,
                                        // image: cubit.userImage ?? File('p',),
                                      ),
                                    );
                                  }
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      const MyText(
                        text: AppStrings.policy,
                        fontSize: AppSize.s15,
                        colors: AppColors.grey,
                      ),
                      const SizedBox(
                        height: AppSize.s15,
                      ),
                      Row(
                        children: [
                          const MyText(
                            text: AppStrings.haveAnAccount,
                            fontSize: AppSize.s15,
                            colors: AppColors.grey,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.loginRoute);
                            },
                            child: const Text(
                              AppStrings.logIn,
                              style: TextStyle(
                                  color: AppColors.teal,
                                  fontSize: AppSize.s18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

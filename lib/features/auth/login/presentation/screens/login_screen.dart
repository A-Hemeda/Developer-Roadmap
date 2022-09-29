import 'package:booking_app/core/component/toast.dart';
import 'package:booking_app/core/routes/routes_manager.dart';
import 'package:booking_app/features/auth/login/domain/entities/user_login_entity.dart';
import 'package:booking_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:booking_app/features/auth/login/presentation/cubit/login_state.dart';
import 'package:booking_app/features/auth/widgets/google_button.dart';
import 'package:booking_app/core/component/my_button.dart';
import 'package:booking_app/core/component/my_text.dart';
import 'package:booking_app/core/component/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app/injection_container.dart' as di;
import '../../../../../core/utilis/constants/app_strings.dart';
import '../../../../../core/utilis/constants/colors.dart';
import '../../../../../core/utilis/constants/values_manger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isHidePass = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<LoginCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        appBar: AppBar(
          elevation: AppSize.s0,
          backgroundColor: AppColors.kPrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      MyText(
                        text: AppStrings.logIn,
                        fontSize: AppSize.s28,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: MySignButton(
                        ontap: () {
                          LoginCubit.get(context).signInwithGoogle();
                        },
                      )),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  const Center(
                    child: MyText(
                      text: AppStrings.orLoginWith,
                      fontSize: AppSize.s15,
                      colors: AppColors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  MyTextForm(
                    enableBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.grey)),
                    isDense: true,
                    radius: AppSize.s40,
                    labelText: AppStrings.email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.emailHint;
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSize.s15),
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
                    isDense: true,
                    radius: AppSize.s40,
                    labelText: AppStrings.password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.passHint;
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: AppSize.s15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      MyText(
                        text: AppStrings.passForget,
                        fontSize: AppSize.s15,
                        colors: AppColors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: AppSize.s50,
                        width: double.infinity,
                        child: BlocConsumer<LoginCubit, LoginState>(
                          listener: (BuildContext context, state) {
                            if (state is LoginSuccessState) {
                              showToast(
                                  text: AppStrings.successLoginEn,
                                  state: ToastStates.success);
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.homeLayout,
                              );
                            } else {
                              showToast(
                                  text: AppStrings.errorLoginEn,
                                  state: ToastStates.success);
                            }
                          },
                          builder: (BuildContext context, Object? state) {
                            var cubit = LoginCubit.get(context);
                            if (state is! LoginLoadingState) {
                              return MyButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.loginEmail(
                                        userLoginEntity: UserLoginEntity(
                                            email: emailController.text,
                                            password: passwordController.text));
                                  }
                                },
                                label: AppStrings.logIn,
                                fontWeight: FontWeight.bold,
                                fontSize: AppSize.s20,
                                radius: AppPadding.p12,
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MyText(
                        text: AppStrings.haveNotAnAccount,
                        fontSize: AppSize.s15,
                        colors: AppColors.grey,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.registerRoute);
                          },
                          child: const Text(AppStrings.createAcc))
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

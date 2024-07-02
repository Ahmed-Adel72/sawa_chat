import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/core/theming/app_text_styles.dart';
import 'package:sawa_chat/core/widgets/app_text_button.dart';
import 'package:sawa_chat/features/login/logic/cubit/login_cubit.dart';
import 'package:sawa_chat/features/login/logic/cubit/login_states.dart';
import 'package:sawa_chat/features/login/ui/widgets/dont_have_account.dart';
import 'package:sawa_chat/features/login/ui/widgets/email_and_password.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/login.png"),
            fit: BoxFit.fill,
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      EmailAndPassword(),
                      cubit.isLoginLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.mainOrange,
                            ))
                          : AppTextButton(
                              buttonText: 'Login',
                              onPressed: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.userLogin(context: context);
                                }
                              },
                              textStyle: AppTextStyles.font22MoreLightGrayBold,
                            ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const DontHaveAccountText(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

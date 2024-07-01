import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/core/theming/app_text_styles.dart';
import 'package:sawa_chat/core/widgets/app_text_button.dart';
import 'package:sawa_chat/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:sawa_chat/features/sign_up/logic/cubit/sign_up_states.dart';
import 'package:sawa_chat/features/sign_up/ui/widgets/already_have_account.dart';
import 'package:sawa_chat/features/sign_up/ui/widgets/sign_up_form.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SignUpCubit.get(context);

          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/register.png"),
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
                        SignUpForm(),
                        cubit.isLoadingSignUp
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: AppColors.mainOrange,
                              ))
                            : AppTextButton(
                                buttonText: 'Sign Up',
                                onPressed: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.userSignUp(context: context);
                                  }
                                },
                                textStyle:
                                    AppTextStyles.font22MoreLightGrayBold,
                              ),
                        SizedBox(
                          height: 15.h,
                        ),
                        const AlreadyHaveAccountText(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

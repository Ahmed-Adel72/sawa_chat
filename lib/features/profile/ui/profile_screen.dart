import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/core/helpers/extensions.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/core/theming/app_text_styles.dart';
import 'package:sawa_chat/core/widgets/app_text_button.dart';
import 'package:sawa_chat/features/profile/logic/cubit/profile_cubit.dart';
import 'package:sawa_chat/features/profile/logic/cubit/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  final String? uid;

  const ProfileScreen({super.key, this.uid});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ProfileCubit.get(context).getUserData(uid: '$uid');
      return BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var uId = CacheHelper.getData(key: 'uId');
          var userDate = ProfileCubit.get(context).userData;
          return Scaffold(
            appBar: AppBar(),
            body: userDate == null
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.mainOrange,
                  ))
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: userDate.image != null &&
                                  userDate.image!.isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('${userDate.image}'),
                                  radius: 55,
                                )
                              : const CircleAvatar(
                                  backgroundColor: AppColors.mainOrange,
                                  radius: 55,
                                ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          '${userDate.name}',
                          style: AppTextStyles.font18DarkGrayRegular.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          '${userDate.bio}',
                          style: AppTextStyles.font18GrayBold,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        userDate.uId == uId
                            ? AppTextButton(
                                buttonText: 'Edit Profile',
                                textStyle: AppTextStyles.font22MoreLightGrayBold
                                    .copyWith(fontSize: 18.sp),
                                onPressed: () {
                                  context.pushNamed(Routes.editProfileScreen,
                                      arguments: uId);
                                },
                              )
                            : AppTextButton(
                                buttonText: 'Send Message',
                                textStyle: AppTextStyles.font22MoreLightGrayBold
                                    .copyWith(fontSize: 18.sp),
                                onPressed: () {
                                  context.pushNamed(Routes.chatScreen,
                                      arguments: userDate.uId);
                                },
                              ),
                        SizedBox(
                          height: 15.h,
                        ),
                        userDate.uId == uId
                            ? AppTextButton(
                                buttonText: 'Logout',
                                textStyle: AppTextStyles.font22MoreLightGrayBold
                                    .copyWith(fontSize: 18.sp),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          title: const Text('Are You Sure'),
                                          content: const Text(
                                            'Logout?',
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    CacheHelper.deleteData(
                                                        'uId');
                                                    context
                                                        .pushNamedAndRemoveUntil(
                                                            Routes.loginScreen,
                                                            predicate: (Route<
                                                                        dynamic>
                                                                    route) =>
                                                                false);
                                                  },
                                                  child: const Text(
                                                    'Yes',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                MaterialButton(
                                                  onPressed: () {
                                                    context.pop();
                                                  },
                                                  child: const Text(
                                                    'No',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      });
                                },
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
          );
        },
      );
    });
  }
}

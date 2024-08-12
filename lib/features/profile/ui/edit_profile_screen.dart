import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/core/helpers/extensions.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/core/theming/app_text_styles.dart';
import 'package:sawa_chat/core/widgets/app_text_button.dart';
import 'package:sawa_chat/core/widgets/app_text_form_field.dart';
import 'package:sawa_chat/features/profile/logic/cubit/profile_cubit.dart';
import 'package:sawa_chat/features/profile/logic/cubit/profile_states.dart';

class EditProfileScreen extends StatelessWidget {
  final String? uid;
  const EditProfileScreen({super.key, this.uid});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ProfileCubit.get(context).getUserData(uid: '$uid');
      return BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileImageUploadSuccessState ||
              state is UpdateUserDataSuccessState) {
            context.pushNamedAndRemoveUntil(Routes.layoutScreen,
                predicate: (Route<dynamic> route) => false);
            Fluttertoast.showToast(
                msg: 'Done (:',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.lightGray,
                timeInSecForIosWeb: 5,
                textColor: Colors.black);
          } else if (state is ProfileImageUploadErrorState) {
            Fluttertoast.showToast(
                msg: 'Failed to update Image: ${state.error}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                timeInSecForIosWeb: 5,
                textColor: Colors.white);
          } else if (state is UpdateUserDataErrorState) {
            Fluttertoast.showToast(
                msg: 'Failed to update profile: ${state.error}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                timeInSecForIosWeb: 5,
                textColor: Colors.white);
          }
        },
        builder: (context, state) {
          var uId = CacheHelper.getData(key: 'uId');
          var userDate = ProfileCubit.get(context).userData;
          var cubit = ProfileCubit.get(context);
          var profileImage = ProfileCubit.get(context).profileImage;
          return Scaffold(
            appBar: AppBar(),
            body: userDate == null
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.mainOrange,
                  ))
                : Form(
                    key: cubit.formKey,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                    child: profileImage == null
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${userDate.image}'),
                                            radius: 55,
                                          )
                                        : CircleAvatar(
                                            backgroundImage:
                                                FileImage(profileImage),
                                            radius: 55,
                                          )),
                                IconButton(
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                  icon: CircleAvatar(
                                      backgroundColor: AppColors.mainOrange,
                                      radius: 18.sp,
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: AppColors.moreLightGray,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '  Your Name',
                                style: AppTextStyles.font18DarkGrayRegular
                                    .copyWith(
                                        fontSize: 15.sp,
                                        color: AppColors.gray,
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Align(
                              child: AppTextFormField(
                                controller: cubit.emailController,
                                hintText: 'Your name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '  Your Bio',
                                style: AppTextStyles.font18DarkGrayRegular
                                    .copyWith(
                                        fontSize: 15.sp,
                                        color: AppColors.gray,
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            AppTextFormField(
                              controller: cubit.bioController,
                              hintText: 'Your bio',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your bio';
                                }
                              },
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            profileImage != null
                                ? state is ProfileImageUploadLoadingState
                                    ? const CircularProgressIndicator(
                                        color: AppColors.mainOrange,
                                      )
                                    : AppTextButton(
                                        buttonText: 'Update Image',
                                        textStyle: AppTextStyles
                                            .font22MoreLightGrayBold
                                            .copyWith(fontSize: 18.sp),
                                        onPressed: () {
                                          if (cubit.formKey.currentState!
                                              .validate()) {
                                            cubit.updateProfileImage(uid: uId);
                                          }
                                        },
                                      )
                                : state is UpdateUserDataLoadingState
                                    ? const CircularProgressIndicator(
                                        color: AppColors.mainOrange,
                                      )
                                    : AppTextButton(
                                        buttonText: 'Update',
                                        textStyle: AppTextStyles
                                            .font22MoreLightGrayBold
                                            .copyWith(fontSize: 18.sp),
                                        onPressed: () {
                                          if (cubit.formKey.currentState!
                                              .validate()) {
                                            cubit.updateUserData(uid: uId);
                                          }
                                        },
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      );
    });
  }
}

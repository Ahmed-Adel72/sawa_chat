import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/core/theming/app_text_styles.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_cubit.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        var myData = LayoutCubit.get(context).myData;
        return Scaffold(
          appBar: AppBar(),
          body: myData == null
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.mainOrange,
                ))
              : Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: myData.image != null && myData.image!.isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: NetworkImage('${myData.image}'),
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
                      '${myData.name}',
                      style: AppTextStyles.font18DarkGrayRegular.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      '${myData.bio}',
                      style: AppTextStyles.font18GrayBold,
                    ),
                  ],
                ),
        );
      },
    );
  }
}

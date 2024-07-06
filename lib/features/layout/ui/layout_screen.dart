import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/helpers/extensions.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/core/theming/app_text_styles.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_cubit.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_states.dart';
import 'package:sawa_chat/features/layout/ui/widgets/list_of_users.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppColors.mainOrange,
            clipBehavior: Clip.hardEdge,
            child: Icon(
              Icons.search,
              size: 30.sp,
              color: AppColors.moreLightGray,
            ),
          ),
          appBar: AppBar(
            backgroundColor: AppColors.moreLightGray,
            title: Text(
              'Sawa Chat',
              style: AppTextStyles.font30DarkGrayBold.copyWith(
                fontSize: 23,
                color: Colors.black54,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    LayoutCubit.get(context).getMyData();
                    context.pushNamed(Routes.profileScreen);
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.mainOrange,
                  ),
                ),
              ),
            ],
          ),
          body: ListOfUsers(),
        );
      },
    );
  }
}

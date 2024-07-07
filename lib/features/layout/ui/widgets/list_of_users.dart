import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/helpers/extensions.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/core/theming/app_text_styles.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_cubit.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_states.dart';
import 'package:sawa_chat/features/layout/ui/widgets/divider_of_list.dart';

class ListOfUsers extends StatelessWidget {
  const ListOfUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        var allUsers = LayoutCubit.get(context).allUser;
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                cubit.getUserData(uid: '${allUsers[index].uId}');
                context.pushNamed(Routes.chatScreen);
              },
              child: Row(
                children: [
                  allUsers[index].image != null &&
                          allUsers[index].image!.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage('${allUsers[index].image}'),
                        )
                      : const CircleAvatar(
                          backgroundColor: AppColors.mainOrange,
                        ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    '${allUsers[index].name}',
                    style: AppTextStyles.font18DarkGrayRegular,
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: allUsers.length,
        );
      },
    );
  }
}

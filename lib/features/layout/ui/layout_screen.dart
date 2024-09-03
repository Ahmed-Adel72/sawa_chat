import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/constants/app_constants.dart';
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
        var myData = LayoutCubit.get(context).myData;
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed(Routes.searchScreen);
            },
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
              'Sawa chat',
              style: AppTextStyles.font30DarkGrayBold.copyWith(
                fontSize: 22.sp,
                color: Colors.black54,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    context.pushNamed(Routes.profileScreen, arguments: uId);
                  },
                  child: myData?.image != null && myData!.image!.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: NetworkImage('${myData.image}'),
                          radius: 20,
                        )
                      : const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 221, 221, 221),
                          radius: 20,
                        ),
                ),
              ),
            ],
          ),
          body: const ListOfUsers(),
        );
      },
    );
  }
}

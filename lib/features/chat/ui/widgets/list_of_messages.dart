import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/core/theming/app_text_styles.dart';
import 'package:sawa_chat/features/chat/logic/cubit/chat_cubit.dart';
import 'package:sawa_chat/features/chat/logic/cubit/chat_states.dart';

class ListOfMessages extends StatelessWidget {
  const ListOfMessages({super.key});

  @override
  Widget build(BuildContext context) {
    var uId = CacheHelper.getData(key: 'uId');
    var cubit = ChatCubit.get(context);
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Expanded(
            child: ListView.separated(
          controller: cubit.scrollController,
          itemBuilder: (context, index) {
            var messages = cubit.messages[index];
            var formattedTime = messages.dataTime != null
                ? DateFormat('h:mm a').format(messages.dataTime!
                    .toDate()
                    .toLocal()
                    .add(const Duration(hours: 1)))
                : '';

            if (uId == messages.senderId) {
              return Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.mainOrange,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(14),
                        topEnd: Radius.circular(14),
                        bottomStart: Radius.circular(14),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            textAlign: TextAlign.end,
                            '${messages.text}',
                            style: AppTextStyles.font18DarkGrayRegular
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            formattedTime,
                            style:
                                TextStyle(color: Colors.white, fontSize: 8.sp),
                          ),
                        ],
                      ),
                    )),
              );
            }
            return Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.gray,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(14),
                      topEnd: Radius.circular(14),
                      bottomEnd: Radius.circular(14),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.end,
                          '${messages.text}',
                          style: AppTextStyles.font18DarkGrayRegular
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          formattedTime,
                          style: TextStyle(color: Colors.white, fontSize: 8.sp),
                        ),
                      ],
                    ),
                  )),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10.h,
            );
          },
          itemCount: cubit.messages.length,
        ));
      },
    );
  }
}

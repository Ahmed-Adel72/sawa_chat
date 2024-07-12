import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/core/theming/app_text_styles.dart';
import 'package:sawa_chat/features/chat/logic/cubit/chat_cubit.dart';

class RowOfImageAndName extends StatelessWidget {
  final bool? isTyping;
  final String? senderMessageUid;
  const RowOfImageAndName({super.key, this.isTyping, this.senderMessageUid});

  @override
  Widget build(BuildContext context) {
    var userDate = ChatCubit.get(context).userData;
    var uId = CacheHelper.getData(key: 'uId');
    return Row(
      children: [
        userDate!.image != null && userDate.image!.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage('${userDate.image}'),
              )
            : const CircleAvatar(
                backgroundColor: AppColors.mainOrange,
                radius: 18,
              ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${userDate.name}',
              style: AppTextStyles.font18DarkGrayRegular
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            senderMessageUid == uId
                ? const SizedBox()
                : isTyping!
                    ? Text(
                        ' Typing...',
                        style: AppTextStyles.font18DarkGrayRegular
                            .copyWith(color: AppColors.gray, fontSize: 13.sp),
                      )
                    : const SizedBox(),
          ],
        ),
      ],
    );
  }
}

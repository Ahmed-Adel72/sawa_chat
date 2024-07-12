import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/features/chat/logic/cubit/chat_cubit.dart';
import 'package:sawa_chat/features/chat/logic/cubit/chat_states.dart';

class TextFormAndSendButton extends StatelessWidget {
  const TextFormAndSendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ChatCubit.get(context);
        var userDate = ChatCubit.get(context).userData;

        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.lightGray,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (text) {
                      cubit.updateTypingStatus(
                        receiverId: '${userDate?.uId}',
                        isTyping: text.isNotEmpty,
                      );
                    },
                    controller: cubit.messageController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '  Type your message here...',
                    ),
                  ),
                ),
                cubit.isTypingRealy
                    ? Container(
                        color: AppColors.mainOrange,
                        child: MaterialButton(
                          minWidth: 1,
                          onPressed: () {
                            cubit.sendMessage(
                              receiverId: '${userDate?.uId}',
                            );
                            cubit.updateTypingStatus(
                              receiverId: '${userDate?.uId}',
                              isTyping: false,
                            );
                          },
                          child: Icon(
                            Icons.send_rounded,
                            color: AppColors.moreLightGray,
                            size: 20.sp,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}

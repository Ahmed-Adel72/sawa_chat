import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/features/chat/logic/cubit/chat_cubit.dart';
import 'package:sawa_chat/features/chat/logic/cubit/chat_states.dart';
import 'package:sawa_chat/features/chat/ui/widgets/list_of_messages.dart';
import 'package:sawa_chat/features/chat/ui/widgets/row_of_image_and_name.dart';
import 'widgets/text_form_and_send_button.dart';

class ChatScreen extends StatelessWidget {
  final String? uid;
  const ChatScreen({super.key, this.uid});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ChatCubit.get(context).getUserData(uid: '$uid');
      return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var uId = CacheHelper.getData(key: 'uId');
          var userDate = ChatCubit.get(context).userData;
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userDate?.uId)
                    .collection('chats')
                    .doc(uId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    var data =
                        snapshot.data!.data() as Map<String, dynamic>? ?? {};
                    bool isTyping = data['isTyping'] ?? false;
                    var senderMessageUid = data['senderId'] ?? '';
                    print(isTyping);

                    return RowOfImageAndName(
                      isTyping: isTyping,
                      senderMessageUid: senderMessageUid,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  state is GetMessagesLoadingState
                      ? const Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                          color: AppColors.mainOrange,
                        )))
                      : const ListOfMessages(),
                  SizedBox(
                    height: 5.h,
                  ),
                  const TextFormAndSendButton(),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

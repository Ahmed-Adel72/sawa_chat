import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
        var myFriendsChats = LayoutCubit.get(context).myFriendsChats;
        return state is GetAllUsersSuccessState && myFriendsChats.isEmpty
            ? const Center(child: Text('search your friend'))
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var formattedTime = myFriendsChats[index].timestamp != null
                      ? DateFormat('h:mm a').format(myFriendsChats[index]
                          .timestamp!
                          .add(const Duration(hours: 1)))
                      : '';
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(Routes.chatScreen,
                            arguments: myFriendsChats[index].uId);
                      },
                      child: Row(
                        children: [
                          myFriendsChats[index].image != null &&
                                  myFriendsChats[index].image!.isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${myFriendsChats[index].image}'),
                                )
                              : const CircleAvatar(
                                  backgroundColor: AppColors.mainOrange,
                                ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${myFriendsChats[index].name}',
                                  style: AppTextStyles.font18DarkGrayRegular,
                                ),
                                myFriendsChats[index].isTyping == true
                                    ? Text(
                                        'Typing',
                                        style:
                                            AppTextStyles.font12MainOrangeBold,
                                      )
                                    : myFriendsChats[index].senderId ==
                                            myFriendsChats[index].uId
                                        ? Text(
                                            myFriendsChats[index].lastMessage ??
                                                '',
                                            style: AppTextStyles
                                                .font12DarkGrayBold,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            'Me: ${myFriendsChats[index].lastMessage ?? ''}',
                                            style: AppTextStyles
                                                .font12DarkGrayBold,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.h, right: 3.w),
                            child: Text(
                              formattedTime,
                              style: AppTextStyles.font12MainOrangeBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => myDivider(),
                itemCount: myFriendsChats.length,
              );
      },
    );
  }
}

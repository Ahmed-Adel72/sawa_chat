import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/helpers/extensions.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/core/widgets/app_text_form_field.dart';
import 'package:sawa_chat/features/search/logic/cubit/search_cubit.dart';
import 'package:sawa_chat/features/search/logic/cubit/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = SearchCubit.get(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            AppTextFormField(
              hintText: "Search",
              isObscureText: false,
              prefixIcon: const Icon(Icons.search_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a vaild email';
                }
              },
              onChanged: (value) {
                cubit.searchUsers(context, value.toString(), value!.isNotEmpty);
              },
            ),
            Expanded(
              child: BlocConsumer<SearchCubit, SearchStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return cubit.isSearching
                      ? ListView.builder(
                          itemCount: cubit.user.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage('${cubit.user[index].image}'),
                              ),
                              title: Text('${cubit.user[index].name}'),
                              onTap: () {
                                context.pushNamed(Routes.profileScreen,
                                    arguments: cubit.user[index].uId);
                              },
                            );
                          })
                      : Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 300.h,
                              width: 400.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/search.png"),
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

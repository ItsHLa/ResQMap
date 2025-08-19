import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/text_styles.dart';

import 'package:resq_map/core/core_widgets/loading_widget.dart';

import 'package:resq_map/core/core_widgets/state_widget.dart';
import 'package:resq_map/core/core_widgets/user_status_item.dart';
import 'package:resq_map/features/safty/cubit/safty_cubit.dart';

class AddSaftyView extends StatefulWidget {
  const AddSaftyView({super.key});

  @override
  State<AddSaftyView> createState() => _AddSaftyViewState();
}

class _AddSaftyViewState extends State<AddSaftyView> {
  bool showSearch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 1.5,
        title: TextFormField(
          onFieldSubmitted: (value) {
            BlocProvider.of<SaftyCubit>(context).searchUsers(search: value);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            suffixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            hintStyle: TextStyles.textStyle14,
            hintText: "Type a username or full name",
          ),
        ),
      ),
      body: BlocConsumer<SaftyCubit, SaftyState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        buildWhen: (previous, current) {
          return current is GetSearchUserSuccess ||
              current is SearchUserLoading ||
              current is Error;
        },
        builder: (context, state) {
          Widget content = MyStateWidget(
            iconData: Icons.search_rounded,
            title: "Who are you looking for?",
          
          );
          if (state is SearchUserLoading) {
            content = LoadingAnimation();
          }
          if (state is Error) {
            content = MyStateWidget(
              iconData: Icons.error_outline,
              title: "Failed to Load",
            );
          }
          if (state is GetSearchUserSuccess) {
            content =
                state.users.isEmpty
                    ? MyStateWidget(
            iconData: Icons.find_in_page,
            title: "Result Not Found",
          
          )
                    : ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder:
                          (context, index) => UserStatusItem(
                            photo: state.users[index].photos!,
                            subtitle: state.users[index].userName,
                            firstName: state.users[index].firstName,
                            lastName: state.users[index].lastName,
                            typeStatus: false,
                            action: IconButton(
                              iconSize: 30,
                              onPressed: () {
                                BlocProvider.of<SaftyCubit>(
                                  context,
                                ).addToMySafty(
                                  user: state.users[index],
                                  users: state.users,
                                );
                              },
                              icon: Icon(Icons.person_add_alt),
                            ),
                          ),
                    );
          }
          return content;
        },
      ),
    );
  }
}

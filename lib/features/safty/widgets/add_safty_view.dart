import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/text_styles.dart';
import 'package:resq_map/core/core_widgets/loading_widget.dart';
import 'package:resq_map/core/core_widgets/state_widget.dart';
import 'package:resq_map/core/core_widgets/user_status_item.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/profile/model/user.dart';
import 'package:resq_map/features/safty/cubit/safty_cubit.dart';

class AddSaftyView extends StatefulWidget {
  const AddSaftyView({super.key});

  @override
  State<AddSaftyView> createState() => _AddSaftyViewState();
}

class _AddSaftyViewState extends State<AddSaftyView> {
  bool showSearch = false;
  List<User> users = [];
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
            fillColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
            hintStyle: TextStyles.textStyle14,
            hintText: "Type a username or full name",
          ),
        ),
      ),
      body: BlocConsumer<SaftyCubit, SaftyState>(
        listener: (context, state) {
          if(state is MySaftyLoading ){
            AppActions.showLoadingDialog(context);
          }
          if (state is AddedSaftyUsersSuccess) {
            setState(() {
              users = state.users;
            });
          }
          if (state is GetSearchUserSuccess) {
            setState(() {
              users = state.users;
            });
          }
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
       
          if(state is AddedSaftyUsersSuccess || state is GetSearchUserSuccess){
              content =
                users.isEmpty
                    ? MyStateWidget(
                      iconData: Icons.find_in_page,
                      title: "Result Not Found",
                    )
                    : ListView.builder(
                      itemCount: users.length,
                      itemBuilder:
                          (context, index) => UserStatusItem(
                            status: users[index].status ?? "Unknown",
                            photo: users[index].photos!,
                            subtitle: users[index].userName,
                            firstName: users[index].firstName,
                            lastName: users[index].lastName,
                            typeStatus: false,
                            action: IconButton(
                              iconSize: 30,
                              onPressed: () {
                                BlocProvider.of<SaftyCubit>(
                                  context,
                                ).addToMySafty(
                                  user: users[index],
                                  users: users,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/core_widgets/loading_widget.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';

class LoginActivityPage extends StatefulWidget {
  const LoginActivityPage({super.key});

  @override
  State<LoginActivityPage> createState() => _LoginActivityPageState();
}

class _LoginActivityPageState extends State<LoginActivityPage> {
  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).getAuthAudit();
    super.initState();
  }

  String _formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    return DateFormat('MMM d, yyyy').format(date); 
  }

  String _formatTime(String isoDate) {
    final date = DateTime.parse(isoDate);
    return DateFormat('h:mm a').format(date); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Activity",
          style: const TextStyle(
            color: softWhite,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthAuditLoading) {
            return LoadingAnimation();
          } else if (state is AuthLoadedAudits) {
            return ListView.builder(
              itemCount: state.audits.length,
              itemBuilder:
                  (context, index) => ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.access_time, color: Colors.red),
                    ),
                    title: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
                        children: [
                          TextSpan(
                            text: "You ${state.audits[index].action} ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                "on ${_formatDate(state.audits[index].createdAt)} ",
                          ),
                          TextSpan(
                            text:
                                "at ${_formatTime(state.audits[index].createdAt)}",
                          ),
                        ],
                      ),
                    ),
                    subtitle: Row(
                          children: [
                            Icon(Icons.computer, size: 16, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(
                              "IP: ${state.audits[index].ipAddress}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                   
                  ),
            );
          }
          return Center(child: Text("SomeThing Went Wrong Try Again Later"));
        },
      ),
    );
  }
}

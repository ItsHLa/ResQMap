import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
import 'package:resq_map/features/earthquake/cubit/quake_cubit.dart';

class TeamStatusView extends StatefulWidget {
  const TeamStatusView({super.key, required this.id, required this.locationId});
  final String id;
  final String locationId;

  @override
  State<TeamStatusView> createState() => _TeamStatusViewState();
}

class _TeamStatusViewState extends State<TeamStatusView> {
  String? selectedStatus;
  final List<String> statusOptions = [
        "Team Handled Site",
        "Team On Site",
        "Team Need Backup",
        
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: appThemeColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kToolbarHeight/2),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back, color: softWhite),
              ),
              Spacer()
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(PaddingConstants.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update Team Status',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: softWhite,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select your current operational status',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  ...statusOptions.map((status) {
                    final isSelected = selectedStatus == status;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? appThemeColor.withOpacity(0.1)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isSelected
                                  ? appThemeColor
                                  : Colors.grey.withOpacity(0.2),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  isSelected
                                      ? appThemeColor
                                      : Colors.grey[400]!,
                              width: 2,
                            ),
                          ),
                          child:
                              isSelected
                                  ? Icon(
                                    Icons.check,
                                    color: appThemeColor,
                                    size: 16,
                                  )
                                  : null,
                        ),
                        title: Text(
                          status,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedStatus = status;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 24),

                  // Confirmation button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed:
                        selectedStatus != null
                            ? () {
                              print(widget.id);
                              print({
                                "id": widget.id,
                                "location_id" : widget.locationId,
                                "status": selectedStatus!,
                              });
                              BlocProvider.of<WebSocketCubit>(
                                context,
                              ).postTeamStatus(
                                alertId: widget.id,
                                locationId: widget.locationId,
                                status: selectedStatus!

                              );
                            
                            }
                            : null,
                    child: const Text('Confirm Status'),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/models/alert_model.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/pages/damaged_user_page.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/pages/team_status_page.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/widgets/team_page_views.dart';
import 'package:resq_map/features/map_and_location/widget/route.dart';

class AlertItem extends StatelessWidget {
  const AlertItem({super.key, required this.alert});
  final Alert alert;

  @override
  Widget build(BuildContext context) {
    final dangerColor = getDangerColor(alert.dangerLevel!);
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: PaddingConstants.md,
        vertical: PaddingConstants.sm,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => DamagedUserPage(locationId: alert.location!.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with status and time
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: dangerColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, color: dangerColor, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          alert.teamStatus?.toUpperCase() ?? 'ALERT',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: dangerColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // TIME
                  Text(
                    _formatTime(alert.updatedAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),

              // Location section with icon
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "LOCATION",
                          style: theme.textTheme.labelSmall?.copyWith(
                            letterSpacing: 1,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Spacer(),
                        // Distance
                        _buildMetadataItem(
                          Icons.near_me,
                          alert.location?.distance != null
                              ? '${alert.location!.distance!.toStringAsFixed(1)} km'
                              : '-- km',
                          theme,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      textAlign: TextAlign.start,
                      alert.location!.fulladdress ?? 'Unknown Location',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Tags section - displayed as chips below location
              ...buildTag(dangerColor),

              // Metadata row

              // Affected count
              // _buildMetadataItem(
              //   Icons.people,
              //   '${alert.totalDamagedUsers ?? 0} members in team',
              //   theme,
              // ),
              Row(
                children: [
                  // Affected count
                  _buildMetadataItem(
                    Icons.report,
                    '${alert.totalReportsCount ?? 0} reports',
                    theme,
                  ),

                  const SizedBox(width: 16),

                  // Affected count
                  _buildMetadataItem(
                    Icons.people,
                    '${alert.totalDamagedUsers ?? 0} affected',
                    theme,
                  ),

                  const Spacer(),

                  // Danger level
                  Chip(
                    label: Text(
                      alert.dangerLevel ?? 'Unknown',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                    ),
                    backgroundColor: Colors.blueGrey.withOpacity(0.1),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Action buttons
              Row(
                children: [
                  IconButton(onPressed: ()=>_navigateToMap(context), icon: Icon(Icons.route, color:  dangerColor,)),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.people, size: 18, color: dangerColor),
                      label: Text(
                        'Team Status',
                        style: TextStyle(color: dangerColor),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: dangerColor),
                      ),
                      onPressed: () => _navigateToTeamStatus(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      icon: Icon(Icons.group, size: 18),
                      label: Text('Squad List'),
                      style: FilledButton.styleFrom(
                        backgroundColor: dangerColor,
                        foregroundColor: softWhite,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => _navigateToTeamPage(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataItem(IconData icon, String text, ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.blueGrey),
        const SizedBox(width: 4),
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey),
        ),
      ],
    );
  }

  void _navigateToTeamStatus(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) =>
                TeamStatusPage(locationId: alert.location!.id!, id: alert.id!),
      ),
    );
  }

  void _navigateToTeamPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) =>
                TeamPageView(
                  alert:alert,
                ),
      ),
    );
  }

  void _navigateToMap(BuildContext context) {
    if (alert.location?.lat == null || alert.location?.lon == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) =>
                RoutePage(lat: alert.location!.lat!, lon: alert.location!.lon!),
      ),
    );
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--:--';
    final timeFormat = TimeOfDay.fromDateTime(dateTime);
    return '${timeFormat.hour}:${timeFormat.minute.toString().padLeft(2, '0')}';
  }

  List<Widget> buildTag(Color dangerColor) {
    return [
      Wrap(
        spacing: 5,
        runSpacing: 6,
        children:
            alert.tags!
                .map(
                  (tag) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: dangerColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: dangerColor.withOpacity(0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 10,
                        color: dangerColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
      const SizedBox(height: 12),
    ];
  }
}

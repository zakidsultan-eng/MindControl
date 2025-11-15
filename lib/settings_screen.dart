import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;
  TimeOfDay _selectedTime = TimeOfDay(hour: 9, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final enabled = prefs.getBool('notifications_enabled');
    bool isEnabled;
    if (enabled == null) {
      isEnabled = false;
    } else {
      isEnabled = enabled;
    }

    final hour = prefs.getInt('notification_hour');
    final minute = prefs.getInt('notification_minute');
    int savedHour;
    int savedMinute;
    if (hour == null) {
      savedHour = 9;
    } else {
      savedHour = hour;
    }
    if (minute == null) {
      savedMinute = 0;
    } else {
      savedMinute = minute;
    }

    setState(() {
      _notificationsEnabled = isEnabled;
      _selectedTime = TimeOfDay(hour: savedHour, minute: savedMinute);
    });

    if (isEnabled) {
      await NotificationService().scheduleDailyCheckIn(
        hour: savedHour,
        minute: savedMinute,
      );
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', _notificationsEnabled);
    await prefs.setInt('notification_hour', _selectedTime.hour);
    await prefs.setInt('notification_minute', _selectedTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf6e8ea),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFEF626C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Color(0xFFEF626C),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: GoogleFonts.quicksand(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SwitchListTile(
                title: Text(
                  'Daily Check-in Reminder',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                subtitle: Text(
                  'Get reminded to check in daily',
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                    color: Color(0xFF718096),
                  ),
                ),
                value: _notificationsEnabled,
                activeColor: Color(0xFFEF626C),
                onChanged: (value) async {
                  setState(() {
                    _notificationsEnabled = value;
                  });

                  if (value) {
                    await NotificationService().scheduleDailyCheckIn(
                      hour: _selectedTime.hour,
                      minute: _selectedTime.minute,
                    );
                    await _saveSettings();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Daily reminders enabled at ${_selectedTime.format(context)}',
                            style: GoogleFonts.quicksand(),
                          ),
                          backgroundColor: Color(0xFF9AE6B4),
                        ),
                      );
                    }
                  } else {
                    await NotificationService().cancelAllNotifications();
                    await _saveSettings();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Daily reminders disabled',
                            style: GoogleFonts.quicksand(),
                          ),
                          backgroundColor: Color(0xFFFCA5A5),
                        ),
                      );
                    }
                  }
                },
              ),
            ),

            if (_notificationsEnabled)
              Column(
                children: [
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notification Time',
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedTime.format(context),
                              style: GoogleFonts.quicksand(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEF626C),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime,
                                );
                                if (time != null) {
                                  setState(() {
                                    _selectedTime = time;
                                  });
                                  await NotificationService().scheduleDailyCheckIn(
                                    hour: time.hour,
                                    minute: time.minute,
                                  );
                                  await _saveSettings();
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Reminder time updated to ${time.format(context)}',
                                          style: GoogleFonts.quicksand(),
                                        ),
                                        backgroundColor: Color(0xFF9AE6B4),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text('Change Time'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
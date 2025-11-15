import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'history_storage.dart';
import 'history_entry.dart';
import 'home_screen.dart';

class ActivityRatingScreen extends StatelessWidget {
  final String emotion;
  final String activity;
  final Map<String, dynamic>? activityData;

  const ActivityRatingScreen({
    super.key,
    required this.emotion,
    required this.activity,
    this.activityData,
  });

  void _submitRating(BuildContext context, String rating) {
    HistoryStorage().addEntry(HistoryEntry(
      emotion: emotion,
      activity: activity,
      timestamp: DateTime.now(),
      activityData: activityData,
      rating: rating,
    ));

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf6e8ea),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'How helpful was this activity?',
              style: GoogleFonts.quicksand(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48),

            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              elevation: 2,
              child: InkWell(
                onTap: () => _submitRating(context, 'worse'),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFFCA5A5).withOpacity(0.3), width: 2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFFCA5A5).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '😔',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          'Made it worse',
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              elevation: 2,
              child: InkWell(
                onTap: () => _submitRating(context, 'neutral'),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFFBD38D).withOpacity(0.3), width: 2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFFBD38D).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '😐',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          'No change',
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              elevation: 2,
              child: InkWell(
                onTap: () => _submitRating(context, 'helped_little'),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFF90CDF4).withOpacity(0.3), width: 2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFF90CDF4).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '🙂',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          'Helped a little',
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              elevation: 2,
              child: InkWell(
                onTap: () => _submitRating(context, 'helped_lot'),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFF9AE6B4).withOpacity(0.3), width: 2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFF9AE6B4).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '😊',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          'Helped a lot',
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
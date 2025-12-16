import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'emotion_card.dart';
import 'activity_selection_screen.dart';

class EmotionCheckInScreen extends StatelessWidget {
  const EmotionCheckInScreen({super.key});

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
      ),
      body: Column(
        children: [
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'How would you describe your mood?',
              style: GoogleFonts.quicksand(
                fontSize: 55,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEF626C),
                height: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 70),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                EmotionCard(
                  emotion: 'Happy',
                  emoji: '😊',
                  color: Color(0xFFFFF4E6),
                  accentColor: Color(0xFFEF626C),
                  onTap: () => _handleEmotionSelected(context, 'Happy'),
                ),
                EmotionCard(
                  emotion: 'Sad',
                  emoji: '😢',
                  color: Color(0xFFE3F2FD),
                  accentColor: Color(0xFFEF626C),
                  onTap: () => _handleEmotionSelected(context, 'Sad'),
                ),
                EmotionCard(
                  emotion: 'Neutral',
                  emoji: '😐',
                  color: Color(0xFFF5F5F5),
                  accentColor: Color(0xFFEF626C),
                  onTap: () => _handleEmotionSelected(context, 'Neutral'),
                ),
                EmotionCard(
                  emotion: 'Anxious',
                  emoji: '😰',
                  color: Color(0xFFF3E5F5),
                  accentColor: Color(0xFFEF626C),
                  onTap: () => _handleEmotionSelected(context, 'Anxious'),
                ),
                EmotionCard(
                  emotion: 'Stressed',
                  emoji: '😫',
                  color: Color(0xFFFFEBEE),
                  accentColor: Color(0xFFEF626C),
                  onTap: () => _handleEmotionSelected(context, 'Stressed'),
                ),
                EmotionCard(
                  emotion: 'Angry',
                  emoji: '😠',
                  color: Color(0xFFFCE4EC),
                  accentColor: Color(0xFFEF626C),
                  onTap: () => _handleEmotionSelected(context, 'Angry'),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  void _handleEmotionSelected(BuildContext context, String emotion) {
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => ActivitySelectionScreen(emotion: emotion),
      ),
    );
  }
}

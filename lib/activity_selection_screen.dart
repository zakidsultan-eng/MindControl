import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'activity_button.dart';
import 'reframe_screen.dart';
import 'message_screen.dart';
import 'breathing_screen.dart';
import 'balloon_game_screen.dart';
import 'sound_game_screen.dart';
class ActivitySelectionScreen extends StatelessWidget {
  final String emotion;

  const ActivitySelectionScreen({super.key, required this.emotion});

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
          'Choose Activity',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Color(0xFFEF626C),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 32),
            Text(
                'We suggest the following:',
                style: GoogleFonts.quicksand(fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Color(0xFFef626c),
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              child: ListView(
                children: [
                  ActivityButton(
                    title: 'Reframe',
                    description: 'Guided questions to shift your mindset',
                    icon: Icons.lightbulb_outline,
                    color: Color(0xFFef626c),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReframeScreen(emotion: emotion)),
                      );
                    },
                  ),
                  ActivityButton(
                    title: 'Message Exchange',
                    description: 'Exchange positive notes',
                    icon: Icons.mail,
                    color: Color(0xFFef626c),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessageExchangeScreen(emotion: emotion)
                        ),
                      );
                    },
                  ),
                  ActivityButton(
                    title: 'Breathing Exercise',
                    description: 'Simple breathing to take a step back',
                    icon: Icons.air,
                    color: Color(0xFFef626c),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BreathingExerciseScreen(emotion: emotion)),
                      );
                    },
                  ),
                  ActivityButton(
                    title: 'Balloon Game',
                    description: 'Focus your mind',
                    icon: Icons.bubble_chart,
                    color: Color(0xFFFFB3BA),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BalloonGameScreen(emotion: emotion),
                        ),
                      );
                    },
                  ),
                  ActivityButton(
                    title: 'Sound Match',
                    description: 'Match sounds to images',
                    icon: Icons.headphones,
                    color: Color(0xFFBAE1FF),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SoundGameScreen(emotion: emotion),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'rating_screen.dart';

class MessageExchangeScreen extends StatelessWidget {
  final String emotion;

  const MessageExchangeScreen({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

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
          'Message Exchange',
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
            SizedBox(height: 80),
            Text(
              'Share something positive',
              style: GoogleFonts.quicksand(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Maybe what you are grateful for, a quote, or words of encouragement',
              style: GoogleFonts.quicksand(
                fontSize: 16,
                color: Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 32),

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
              child: TextField(
                controller: messageController,
                maxLines: 6,
                maxLength: 200,
                style: GoogleFonts.quicksand(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (messageController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please write a message first',
                          style: GoogleFonts.quicksand(),
                        ),
                        backgroundColor: Color(0xFFFCA5A5),
                      ),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageReceivedScreen(
                        emotion: emotion,
                        userMessage: messageController.text,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                ),
                child: Text('Share Message'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageReceivedScreen extends StatelessWidget {
  final String emotion;
  final String userMessage;

  const MessageReceivedScreen({
    super.key,
    required this.emotion,
    required this.userMessage,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> messages = [
      "Remember to tell your mom you appreciate herr",
      "Sometimes all you need is a hug",
      "You are stronger than you think",
      "Slow motion is faster than no motion",
      "Remember to eat your breakfast",
      "One step at a time",
      "Tough times create tough people",
      "Sometimes its the little things in life",
    ];

    final random = Random();
    String receivedMessage = messages[random.nextInt(messages.length)];

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
          'Message Exchange',
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
            SizedBox(height: 80),
            Text(
              'Thank you for sharing!',
              style: GoogleFonts.quicksand(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 26),
            Text(
              'Here\'s a message from someone else:',
              style: GoogleFonts.quicksand(
                fontSize: 16,
                color: Color(0xFF718096),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),

            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      receivedMessage,
                      style: GoogleFonts.quicksand(
                        fontSize: 20,
                        color: Color(0xFF2D3748),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityRatingScreen(
                        emotion: emotion,
                        activity: 'Message Exchange',
                        activityData: {'message': userMessage},
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                ),
                child: Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'rating_screen.dart';

class MessageExchangeScreen extends StatelessWidget {
  final String emotion;
  final SupabaseClient _supabase = Supabase.instance.client;

  MessageExchangeScreen({super.key, required this.emotion});

  Future<void> _submitMessage(String message) async {
    await _supabase.from('messages').insert({
      'content': message,
    });
  }

  Future<String> _getRandomMessage() async {
    final countResponse = await _supabase
        .from('messages')
        .select('id');

    if (countResponse.isEmpty) {
      return "You are stronger than you think";
    }

    final randomIndex = DateTime.now().millisecondsSinceEpoch % countResponse.length;

    final response = await _supabase
        .from('messages')
        .select('content')
        .limit(1)
        .range(randomIndex, randomIndex);

    if (response.isNotEmpty) {
      return response[0]['content'];
    }

    return "You are stronger than you think";
  }

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
                onPressed: () async {
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

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Center(
                      child: CircularProgressIndicator(color: Color(0xFFEF626C)),
                    ),
                  );

                  final receivedMessage = await _getRandomMessage();
                  await _submitMessage(messageController.text.trim());


                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageReceivedScreen(
                        emotion: emotion,
                        userMessage: messageController.text,
                        receivedMessage: receivedMessage,
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
  final String receivedMessage;

  const MessageReceivedScreen({
    super.key,
    required this.emotion,
    required this.userMessage,
    required this.receivedMessage,
  });

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
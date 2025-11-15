import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'rating_screen.dart';

class ReframeScreen extends StatefulWidget {
  final String emotion;

  const ReframeScreen({super.key, required this.emotion});

  @override
  State<ReframeScreen> createState() => _ReframeScreenState();
}

class _ReframeScreenState extends State<ReframeScreen> {
  final TextEditingController _answerController = TextEditingController();
  int _currentStep = 0;
  String _initialFeeling = '';
  List<String> _answers = [];

  final List<String> _questions = [
    "What's causing you to feel this way?",
    "Is this something within your control?",
    "What's one positive thing about this situation?",
    "How might you feel about this a week from now?",
    "What would you say to a friend in this situation?",
  ];

  void _nextStep() {
    if (_answerController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please provide an answer',
            style: GoogleFonts.quicksand(),
          ),
          backgroundColor: Color(0xFFFCA5A5),
        ),
      );
      return;
    }

    setState(() {
      if (_currentStep == 0) {
        _initialFeeling = _answerController.text;
      } else {
        _answers.add(_answerController.text);
      }

      _answerController.clear();
      _currentStep++;
    });
  }

  void _finish() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ActivityRatingScreen(
          emotion: widget.emotion,
          activity: 'Reframe',
          activityData: {'feeling': _initialFeeling},
        ),
      ),
    );
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    if (_currentStep == 0) {
      currentScreen = _buildInitialQuestion();
    } else if (_currentStep <= _questions.length) {
      currentScreen = _buildQuestionStep();
    } else {
      currentScreen = _buildSummary();
    }

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
          'Reframe',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Color(0xFFEF626C),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: currentScreen,
      ),
    );
  }

  Widget _buildInitialQuestion() {
    return Column(
      children: [
        SizedBox(height: 80),
        Text(
          'Let\'s shift your perspective',
          style: GoogleFonts.quicksand(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFFef626c),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32),
        Text(
          'How are you feeling right now?',
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
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
            controller: _answerController,
            maxLines: 4,
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
            onPressed: _nextStep,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 56),
            ),
            child: Text('Next'),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionStep() {
    int questionIndex = _currentStep - 1;
    double progress = (questionIndex + 1) / _questions.length;
    int progressPercent = (progress * 100).toInt();

    String buttonText;
    if (questionIndex == _questions.length - 1) {
      buttonText = 'Finish';
    } else {
      buttonText = 'Next';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question ${questionIndex + 1} of ${_questions.length}',
              style: GoogleFonts.quicksand(
                fontSize: 14,
                color: Color(0xFF718096),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$progressPercent%',
              style: GoogleFonts.quicksand(
                fontSize: 14,
                color: Color(0xFFEF626C),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Color(0xFFEF626C).withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEF626C)),
            minHeight: 8,
          ),
        ),
        SizedBox(height: 40),
        Text(
          _questions[questionIndex],
          style: GoogleFonts.quicksand(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        SizedBox(height: 32),
        Expanded(
          child: Container(
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
              controller: _answerController,
              maxLines: null,
              expands: true,
              style: GoogleFonts.quicksand(fontSize: 16),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Your answer...',
                hintStyle: GoogleFonts.quicksand(color: Color(0xFFA0AEC0)),
                contentPadding: EdgeInsets.all(20),
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _nextStep,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 56),
            ),
            child: Text(buttonText),
          ),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Center(
            child: Text(
              'Reflection Complete',
              style: GoogleFonts.quicksand(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
          ),
          SizedBox(height: 32),
          Text(
            'You started feeling:',
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFFCA5A5).withOpacity(0.3), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              _initialFeeling,
              style: GoogleFonts.quicksand(fontSize: 16, color: Color(0xFF2D3748)),
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Through reflection, you discovered:',
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 16),

          Column(
            children: _buildAnswerList(),
          ),

          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _finish,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 56),
              ),
              child: Text('Done'),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  List<Widget> _buildAnswerList() {
    List<Widget> answerWidgets = [];

    for (int i = 0; i < _answers.length; i++) {
      answerWidgets.add(
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _questions[i],
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFEF626C),
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  _answers[i],
                  style: GoogleFonts.quicksand(fontSize: 15, color: Color(0xFF2D3748)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return answerWidgets;
  }
}
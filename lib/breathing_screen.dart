import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'rating_screen.dart';

class BreathingExerciseScreen extends StatefulWidget {
  final String emotion;

  const BreathingExerciseScreen({super.key, required this.emotion});

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen> {
  String _instruction = 'Breathe In';
  double _circleSize = 100;
  int _cyclesCompleted = 0;
  final int _totalCycles = 3;
  Timer? _timer;
  // int _start = 0
  int _phase = 0;
  bool _showDoneButton = false;

  @override
  void initState() {
    super.initState();
    _startBreathingCycle();
  }

  void _startBreathingCycle() {

    Future.delayed(Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _circleSize = 200;
        });
      }
    });

    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        if (_phase == 0) {
          _instruction = 'Hold';
          _circleSize = 200;
          _phase = 1;
        } else if (_phase == 1) {
          _instruction = 'Breathe Out';
          _circleSize = 100;
          _phase = 2;
        } else if (_phase == 2) {
          if (_cyclesCompleted + 1 >= _totalCycles) {
            _timer?.cancel();
            _showDoneButton = true;
          } else {
            _cyclesCompleted++;
            _instruction = 'Breathe In';
            _circleSize = 200;
            _phase = 0;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf6e8ea),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.close, color: Color(0xFFEF626C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Breathing Exercise',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Color(0xFFEF626C),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: AnimatedContainer(
              duration: Duration(seconds: 4),
              width: _circleSize,
              height: _circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0xFFEF626C).withOpacity(0.6),
                    Color(0xFFEF626C).withOpacity(0.2),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFEF626C).withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Text(
              _instruction,
              style: GoogleFonts.quicksand(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: _showDoneButton
                  ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActivityRatingScreen(
                          emotion: widget.emotion,
                          activity: 'Breathing Exercise',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56),
                  ),
                  child: Text('Done'),
                ),
              )
                  : Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Cycle ${_cyclesCompleted + 1} of $_totalCycles',
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
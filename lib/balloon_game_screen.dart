import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'rating_screen.dart';

class BalloonGameScreen extends StatefulWidget {
  final String emotion;

  const BalloonGameScreen({super.key, required this.emotion});

  @override
  State<BalloonGameScreen> createState() => _BalloonGameScreenState();
}

class _BalloonGameScreenState extends State<BalloonGameScreen> {
  List<Balloon> balloons = [];
  int nextToPop = 1;
  bool gameComplete = false;
  bool _isInitialized = false;

  final List<Color> balloonColors = [
    Color(0xFFFFB3BA),
    Color(0xFFBAE1FF),
    Color(0xFFBAFFBA),
    Color(0xFFFFFFBA),
    Color(0xFFE8BAFF),
    Color(0xFFFFD9BA),
    Color(0xFFBAFFFF),
    Color(0xFFFFC9DE),
  ];

  void _initializeBalloons(Size screenSize) {
    if (_isInitialized) return;

    final random = Random();
    final double topPadding = 100;
    final double bottomPadding = 150;
    final double sidePadding = 40;
    final double balloonWidth = 60;
    final double balloonHeight = 75;

    double availableWidth = screenSize.width - (sidePadding * 2) - balloonWidth;
    double availableHeight = screenSize.height - topPadding - bottomPadding - balloonHeight;

    List<Offset> positions = [];

    for (int i = 1; i <= 20; i++) {
      Offset position;
      int attempts = 0;

      do {
        position = Offset(
          sidePadding + random.nextDouble() * availableWidth,
          topPadding + random.nextDouble() * availableHeight,
        );
        attempts++;
      } while (_isTooClose(position, positions) && attempts < 100);

      positions.add(position);

      balloons.add(Balloon(
        number: i,
        position: position,
        color: balloonColors[random.nextInt(balloonColors.length)],
      ));
    }

    _isInitialized = true;
  }

  bool _isTooClose(Offset newPos, List<Offset> existingPositions) {
    for (var pos in existingPositions) {
      if ((newPos - pos).distance < 65) {
        return true;
      }
    }
    return false;
  }

  void _popBalloon(int number) {
    if (number != nextToPop) return;

    int index = balloons.indexWhere((b) => b.number == number);
    if (index == -1) return;

    setState(() {
      balloons[index] = balloons[index].copyWith(isPopping: true);
    });

    Future.delayed(Duration(milliseconds: 200), () {
      if (!mounted) return;

      setState(() {
        int idx = balloons.indexWhere((b) => b.number == number);
        if (idx != -1) {
          balloons[idx] = balloons[idx].copyWith(isPopped: true);
        }
        nextToPop++;

        if (nextToPop > 20) {
          gameComplete = true;
        }
      });
    });
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
          'Pop the Balloons',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Color(0xFFEF626C),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          _initializeBalloons(Size(constraints.maxWidth, constraints.maxHeight));

          return Stack(
            children: [
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      gameComplete
                          ? 'Great job!'
                          : 'Pop balloon #$nextToPop',
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ),
                ),
              ),


              for (int i = 0; i < balloons.length; i++)
                if (!balloons[i].isPopped)
                  Positioned(
                    key: ValueKey(balloons[i].number),
                    left: balloons[i].position.dx,
                    top: balloons[i].position.dy,
                    child: GestureDetector(
                      onTap: () => _popBalloon(balloons[i].number),
                      child: AnimatedScale(
                        scale: balloons[i].isPopping ? 0 : 1,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        child: BalloonWidget(
                          number: balloons[i].number,
                          color: balloons[i].color,
                        ),
                      ),
                    ),
                  ),


              if (gameComplete)
                Positioned(
                  bottom: 40,
                  left: 24,
                  right: 24,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityRatingScreen(
                            emotion: widget.emotion,
                            activity: 'Balloon Game',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 56),
                    ),
                    child: Text('Done'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class Balloon {
  final int number;
  final Offset position;
  final Color color;
  final bool isPopping;
  final bool isPopped;

  Balloon({
    required this.number,
    required this.position,
    required this.color,
    this.isPopping = false,
    this.isPopped = false,
  });

  Balloon copyWith({
    int? number,
    Offset? position,
    Color? color,
    bool? isPopping,
    bool? isPopped,
  }) {
    return Balloon(
      number: number ?? this.number,
      position: position ?? this.position,
      color: color ?? this.color,
      isPopping: isPopping ?? this.isPopping,
      isPopped: isPopped ?? this.isPopped,
    );
  }
}

class BalloonWidget extends StatelessWidget {
  final int number;
  final Color color;

  const BalloonWidget({
    super.key,
    required this.number,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 75,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(-0.3, -0.3),
              radius: 0.8,
              colors: [
                color.withOpacity(0.9),
                color,
                color.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$number',
              style: GoogleFonts.quicksand(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
        ),

        Container(
          width: 12,
          height: 8,
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
          ),
        ),

        Container(
          width: 2,
          height: 30,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF999999),
                Color(0xFFCCCCCC),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
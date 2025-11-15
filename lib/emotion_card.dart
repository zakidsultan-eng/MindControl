import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class EmotionCard extends StatelessWidget {
  final String emotion;
  final String emoji;
  final Color color;
  final Color accentColor;
  final VoidCallback onTap;

  const EmotionCard({
    super.key,
    required this.emotion,
    required this.emoji,
    required this.color,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: 160,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.45),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: TextStyle(fontSize: 80),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  emotion,
                  style: GoogleFonts.quicksand(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ActivityButton extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  final VoidCallback onTap;

  const ActivityButton({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.3), width: 2),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color.withOpacity(0.8), size: 32),
                ),
                SizedBox(width: 16),
                Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      Text(
                        title,
                        style: GoogleFonts.quicksand(
                          fontSize: 18,

                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        style: GoogleFonts.quicksand(
                          fontSize: 14,

                          color: Color(0xFF718096),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: color.withOpacity(0.6), size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

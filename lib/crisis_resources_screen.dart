import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CrisisResourcesScreen extends StatelessWidget {
  const CrisisResourcesScreen({super.key});

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
          'Crisis Resources',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Color(0xFFEF626C),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
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
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFEF626C).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xFFEF626C),
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You're not alone",
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Help is available 24/7",
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            color: Color(0xFF718096),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            _buildResourceCard(
              icon: Icons.phone,
              name: '988 Suicide & Crisis Lifeline',
              number: '988',
              description: 'If you need to talk, the 988 Lifeline is here.',
              color: Color(0xFFBAE1FF),
            ),

            _buildResourceCard(
              icon: Icons.textsms,
              name: 'Crisis Text Line',
              number: 'Text HOME to 741741',
              description: 'Free crisis counseling via text message, 24/7.',
              color: Color(0xFFBAFFBA),
            ),

            _buildResourceCard(
              icon: Icons.health_and_safety,
              name: 'SAMHSA National Helpline',
              number: '1-800-662-4357',
              description: 'Treatment referrals and support for mental health and substance abuse.',
              color: Color(0xFFE8BAFF),
            ),

            _buildResourceCard(
              icon: Icons.shield,
              name: 'National Domestic Violence Hotline',
              number: '1-800-799-7233',
              description: 'Support for anyone affected by domestic violence.',
              color: Color(0xFFFFD9BA),
            ),

            _buildResourceCard(
              icon: Icons.emergency,
              name: 'Emergency Services',
              number: '911',
              description: 'For immediate danger or medical emergencies.',
              color: Color(0xFFFFB3BA),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceCard({
    required IconData icon,
    required String name,
    required String number,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color.withOpacity(1),
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  number,
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEF626C),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: GoogleFonts.quicksand(
                    fontSize: 13,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'settings_screen.dart';
import 'history_screen.dart';
import 'emotion_screen.dart';
import 'auth_service.dart';
import 'auth_screens.dart';
import 'crisis_resources_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  String _quote = 'You look great today!';
  String _author = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRandomQuote();
  }

  Future<void> _fetchRandomQuote() async {
    try {
      final response = await _supabase
          .from('quotes')
          .select('content, author');

      if (response.isNotEmpty) {
        final randomIndex = DateTime.now().millisecondsSinceEpoch % response.length;
        setState(() {
          _quote = response[randomIndex]['content'];
          _author = response[randomIndex]['author'];
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching quote: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf6e8ea),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.support, color: Color(0xFFEF626C)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CrisisResourcesScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Color(0xFFEF626C)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),

          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Color(0xFFEF626C)),
            onSelected: (value) async {
              if (value == 'logout') {
                await AuthService().logout();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                        (route) => false,
                  );
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Color(0xFFEF626C)),
                    SizedBox(width: 8),
                    Text('Logout', style: GoogleFonts.quicksand()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFEF626C).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite,
                  size: 180,
                  color: Color(0xFFEF626C),
                ),
              ),
              SizedBox(height: 40),

              GestureDetector(
                onTap: _fetchRandomQuote,
                child: SizedBox(
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          _isLoading ? 'Loading...' : '"$_quote"',
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFef626c),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 5,
                        ),
                      ),
                      if (_author.isNotEmpty) ...[
                        SizedBox(height: 10),
                        Text(
                          '— $_author',
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF718096),
                          ),
                        ),
                      ],
                      SizedBox(height: 6),
                      Text(
                        'Tap for new quote',
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          color: Color(0xFF718096).withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EmotionCheckInScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                ),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.quicksand(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 25),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                  side: BorderSide(color: Color(0xFFEF626C), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('View History', style: GoogleFonts.quicksand(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFEF626C),
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
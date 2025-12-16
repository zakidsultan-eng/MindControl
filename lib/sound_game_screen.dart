import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'rating_screen.dart';

class SoundGameScreen extends StatefulWidget {
  final String emotion;

  const SoundGameScreen({super.key, required this.emotion});

  @override
  State<SoundGameScreen> createState() => _SoundGameScreenState();
}

class _SoundGameScreenState extends State<SoundGameScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final String _storageBase = 'https://nzpsrrizoikibdvzpwlq.supabase.co/storage/v1/object/public/Audios/';
  final List<SoundItem> allSounds = [
    SoundItem(
      name: 'ocean',
      audioFile: 'ocean.mp3',
      imageUrl: 'https://images.unsplash.com/photo-1505118380757-91f5f5632de0?w=400',
    ),
    SoundItem(
      name: 'rain',
      audioFile: 'rain.mp3',
      imageUrl: 'https://images.unsplash.com/photo-1515694346937-94d85e41e6f0?w=400',
    ),
    SoundItem(
      name: 'birds',
      audioFile: 'birds.mp3',
      imageUrl: 'https://images.unsplash.com/photo-1444464666168-49d633b86797?w=400',
    ),
    SoundItem(
      name: 'fire',
      audioFile: 'fire.mp3',
      imageUrl: 'https://images.unsplash.com/photo-1543393470-b2c833b98dce?w=400',
    ),
    SoundItem(
      name: 'river',
      audioFile: 'river.mp3',
      imageUrl: 'https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=400',
    ),
    SoundItem(
      name: 'cafe',
      audioFile: 'cafe.mp3',
      imageUrl: 'https://images.unsplash.com/photo-1521017432531-fbd92d768814?w=400',
    ),
  ];

  List<SoundItem> roundSounds = [];
  int currentRound = 0;
  int totalRounds = 3;
  late SoundItem currentCorrectSound;
  List<SoundItem> currentChoices = [];
  bool isPlaying = false;
  bool gameComplete = false;

  @override
  void initState() {
    super.initState();
    _setupGame();
  }

  void _setupGame() {
    List<SoundItem> shuffled = List.from(allSounds)..shuffle(Random());
    roundSounds = shuffled.take(totalRounds).toList();
    _setupRound();
  }

  void _setupRound() {
    if (currentRound >= totalRounds) {
      setState(() {
        gameComplete = true;
      });
      return;
    }

    currentCorrectSound = roundSounds[currentRound];

    List<SoundItem> wrongChoices = allSounds
        .where((s) => s.name != currentCorrectSound.name)
        .toList()
      ..shuffle(Random());

    currentChoices = [
      currentCorrectSound,
      wrongChoices[0],
      wrongChoices[1],
    ]..shuffle(Random());

    _playSound();
  }

  Future<void> _playSound() async {
    setState(() {
      isPlaying = true;
    });

    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      String url = _storageBase + currentCorrectSound.audioFile;
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      print('Error playing audio: $e');
    }

    setState(() {
      isPlaying = false;
    });
  }

  void _selectChoice(SoundItem choice) {
    if (choice.name == currentCorrectSound.name) {
      _audioPlayer.stop();
      setState(() {
        currentRound++;
      });
      _setupRound();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
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
          icon: Icon(Icons.arrow_back, color: Color(0xFFEF626C)),
          onPressed: () {
            _audioPlayer.stop();
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Sound Match',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Color(0xFFEF626C),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: gameComplete ? _buildComplete() : _buildGame(),
      ),
    );
  }

  Widget _buildGame() {
    return Column(
      children: [
        Container(
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
            'Round ${currentRound + 1} of $totalRounds',
            style: GoogleFonts.quicksand(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
        ),

        SizedBox(height: 30),

        Text(
          'Listen and tap the matching image',
          style: GoogleFonts.quicksand(
            fontSize: 16,
            color: Color(0xFF718096),
          ),
        ),

        SizedBox(height: 20),



        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: currentChoices.map((choice) {
              return GestureDetector(
                onTap: () => _selectChoice(choice),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      choice.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFEF626C),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildComplete() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Color(0xFFEF626C).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              size: 80,
              color: Color(0xFFEF626C),
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Great listening!',
            style: GoogleFonts.quicksand(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'You completed all $totalRounds rounds',
            style: GoogleFonts.quicksand(
              fontSize: 16,
              color: Color(0xFF718096),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivityRatingScreen(
                    emotion: widget.emotion,
                    activity: 'Sound Match',
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 56),
            ),
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}

class SoundItem {
  final String name;
  final String audioFile;
  final String imageUrl;

  SoundItem({
    required this.name,
    required this.audioFile,
    required this.imageUrl,
  });
}
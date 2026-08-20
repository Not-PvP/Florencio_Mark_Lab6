import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class Song {
  final String title;
  final String artist;
  final String coverAsset;

  const Song({
    required this.title,
    required this.artist,
    required this.coverAsset,
  });
}

const List<Song> kSongs = [
  Song(
    title: 'Who Knows',
    artist: 'Daniel Caesar',
    coverAsset: 'assets/covers/who_knows.jpg',
  ),
  Song(
    title: 'How to Save a Life',
    artist: 'The Fray',
    coverAsset: 'assets/covers/how_to_save_a_life.jpg',
  ),
  Song(
    title: 'Wonderwall',
    artist: 'Oasis',
    coverAsset: 'assets/covers/wonderwall.jpg',
  ),
  Song(
    title: 'oh yeah?',
    artist: 'Steve Lacy',
    coverAsset: 'assets/covers/oh_yeah.jpg',
  ),
  Song(
    title: 'Apple Cider',
    artist: 'beabadoobee',
    coverAsset: 'assets/covers/apple_cider.jpg',
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final warmScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepOrange,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'Marktify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: warmScheme,
        scaffoldBackgroundColor: Colors.brown.shade900,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown.shade900,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.orange.shade100,
          ),
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      home: const PlaylistScreen(),
    );
  }
}

class CoverArt extends StatelessWidget {
  final String assetPath;
  final double size;
  final BorderRadius borderRadius;

  const CoverArt({
    super.key,
    required this.assetPath,
    required this.size,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade400,
              borderRadius: borderRadius,
            ),
            child: Icon(
              Icons.music_note_rounded,
              color: Colors.white,
              size: size * 0.4,
            ),
          );
        },
      ),
    );
  }
}

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marktify')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: kSongs.length,
        itemBuilder: (context, index) {
          final song = kSongs[index];

          return Card(
            color: Colors.brown.shade800,
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              leading: CoverArt(
                assetPath: song.coverAsset,
                size: 52,
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(
                song.title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                song.artist,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.orange.shade100.withOpacity(0.7),
                ),
              ),
              trailing: Icon(
                Icons.play_circle_fill_rounded,
                color: Colors.orange.shade200,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NowPlayingScreen(song: song),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class NowPlayingScreen extends StatelessWidget {
  final Song song;

  const NowPlayingScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CoverArt(
                assetPath: song.coverAsset,
                size: 260,
                borderRadius: BorderRadius.circular(24),
              ),
              const SizedBox(height: 40),
              Text(
                'NOW PLAYING',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 3,
                  color: Colors.orange.shade200,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                song.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                song.artist,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Colors.orange.shade100.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Stop and Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
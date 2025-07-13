import 'package:flutter/material.dart';

import 'package:marquee/marquee.dart';
import 'package:spotifyapp/audio_player_singleton.dart';

class PlayerPage extends StatefulWidget {
  final String title;
  const PlayerPage({super.key, required this.title});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late String currentTitle;
  final _audioPlayer = GlobalAudioPlayer.instance;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    
    currentTitle = widget.title;
    _playAudio();
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.setAsset('assets/music/$currentTitle.m4a');
      await _audioPlayer.play();
      print("Playing mehabooba_fixed.mp3");

      _audioPlayer.durationStream.listen((d) {
        setState(() {});
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orangeAccent, Colors.brown],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  BackButton(color: Colors.white),
                  const SizedBox(width: 40),
                  const Text(
                    'Now Playing',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/music/player.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Marquee(
                  text: currentTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  velocity: 20,
                  blankSpace: 60,
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder<Duration>(
                stream: _audioPlayer.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final totalDuration = _audioPlayer.duration ?? Duration.zero;

                  return Slider(
                    min: 0.0,
                    max: totalDuration.inMilliseconds.toDouble(),
                    value:
                        position.inMilliseconds
                            .clamp(0, totalDuration.inMilliseconds)
                            .toDouble(),
                    onChanged: (value) {
                      _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                    },
                    activeColor: Colors.white,
                    inactiveColor: Colors.white24,
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 32,
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.black,
                        size: 36,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isPlaying) {
                            _audioPlayer.pause();
                          } else {
                            _audioPlayer.play();
                          }
                          isPlaying = !isPlaying;
                        });
                      },
                    ),
                  ),
                  const Icon(Icons.skip_next, color: Colors.white, size: 32),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

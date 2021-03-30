import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'widgets/meta_data_section.dart';
import 'widgets/play_pause_button_bar.dart';
import 'widgets/player_state_section.dart';
import 'widgets/source_input_section.dart';
import 'widgets/volume_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '動画再生ソフトだよ',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: '動画再生ソフトだよ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});
  final String title;
  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'aIYWJuNy6y0',
      params: const YoutubePlayerParams(
        playlist: [
          'dnAcjiRpp5o',
          'AaMCaQjHwPY',
          '9LABbFTQfXs',
          'VZRbUrYUqzE',
          'dyEOhxqTpTw',
          'fzFLUBye3Nw',
          'owWj2rbwYwA',
          'jSTlTrdrDTU',
          'T3T5PTYlv8M',
          'bEcPMpwh2HQ',
          'Orb6mvWMyAs',
          'ZZjeaT4-Vek',
          'LYKkjT9645E',
          'HRHVJPFKCqE',
          'PxtTn1RBos4',
          'r9V5gy-s2J0',
          '54xsjxkltqg',
          '-m0TzM5urbo',
          'xFDX0m-V9iM',
          'whqFirrmRQA',
          'aIYWJuNy6y0',
          'HJiBvuRpdfw',
          'y7kFb9o0mDA',
          '6ZAN8ZuGQ4g',
          'pJ2gLMfcy5s',
          'xLk4iBXWg58',
          '1tH7cL4JY3A',
          'Eufv6nXsmkg',
          'ADvPm2ytT-c',
          'DoXLVMEzUeU',
          'CdHT47F4SjE',
          'J7LmK_Fyevw',
          'B83-1jNul7c',
          '8y0HSSUL8iQ',
          'zBkGLx5KLO4',
          'H7jracLzCzI',
          '4gce0Pf5OQI',
          's_5hGeThiuc',
          'gAQXl2Twxy0',
          'yH72b9n1SsQ',
          'VXml38U-cGo',
        ],
        startAt: const Duration(minutes: 1, seconds: 36),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: true,
        autoPlay: true,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }
  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (kIsWeb && constraints.maxWidth > 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: player),
                  const SizedBox(
                    width: 300,
                    child: SingleChildScrollView(
                      child: Controls(),
                    ),
                  ),
                ],
              );
            }
            return ListView(
              children: [
                player,
                const Controls(),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

class Controls extends StatelessWidget {
  const Controls();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlayPauseButtonBar(),
          VolumeSlider(),
          PlayerStateSection(),
        ],
      ),
    );
  }

  Widget get _space => const SizedBox(height: 10);
}

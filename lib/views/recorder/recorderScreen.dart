import 'dart:async';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartnote/services/storage/localStorage.dart';
import 'package:smartnote/theme.dart';
import 'package:smartnote/services/generativeAI.dart';
import 'package:smartnote/services/transcribe.dart';

class Recorder extends StatefulWidget {
  // intialize constant constructor
  const Recorder({Key? key}) : super(key: key);
  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  bool _isGeneratingNote = false; // New variable to track note generation state

  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  bool _isPaused = false;
  String? pathToRecorded;
  Duration _duration = Duration();
  Timer? _timer;

  String transcribedText = 'No trascription yet...';
  FlutterSoundPlayer? _player;

  Future initPlayer() async {
    _player = FlutterSoundPlayer();
    await _player!.openAudioSession();
  }

  Future playAudio() async {
    await _player!.startPlayer(fromURI: '$pathToRecorded');
  }

  Future stopAudio() async {
    await _player!.stopPlayer();
  }

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _initAudioRecorder();
  }

  Future<void> _initAudioRecorder() async {
    await _audioRecorder!.openAudioSession();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration += Duration(seconds: 1);
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _duration = Duration();
    });
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.microphone.status;
    if (status.isDenied) {
      // Request microphone permission
      Map<Permission, PermissionStatus> statuses = await [
        Permission.microphone,
        Permission.storage,
      ].request();
      print(statuses[Permission.microphone]);
    }
  }

  Future<void> _startRecording() async {
    await _requestPermissions();
    Directory tempDir = await getApplicationDocumentsDirectory();
    print(
        '=============$tempDir====================${tempDir.path}=============================================');
    pathToRecorded = '${tempDir.path}/smartnotes_audio.wav';

    await _audioRecorder!.startRecorder(
      toFile: pathToRecorded,
      // decode it to mp3
      // codec: Codec.mp3,
    );

    setState(() {
      _isRecording = true;
    });

    _startTimer();
  }

  Future<void> _pauseRecording() async {
    await _audioRecorder!.pauseRecorder();
    _pauseTimer();

    setState(() {
      _isPaused = true;
    });
  }

  Future<void> _resumeRecording() async {
    await _audioRecorder!.resumeRecorder();
    _startTimer();

    setState(() {
      _isPaused = false;
    });
  }

  Future<void> _stopRecording() async {
    _audioRecorder!.pauseRecorder();
    await _audioRecorder!.stopRecorder();

    _resetTimer();

    setState(() {
      _isRecording = false;
      _isPaused = false;
    });
  }

  @override
  void dispose() {
    _audioRecorder!.closeAudioSession();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Recorder'),
        title: Text('Record'),
        centerTitle: true,
        backgroundColor: bgColor,
        elevation: 0.0,
        // add a sign in button on the right side
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.login),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 32, 8, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(children: [
                    // SizedBox(height: 25),
                    Text(
                      '${_duration.inHours}:${(_duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 32),
                    ),
                    SizedBox(height: 15),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      _isRecording
                          ? Icon(
                              // add circular dot icon
                              Icons.circle,
                              color: Colors.red,
                            )
                          : Container(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _isRecording ? 'Recording...' : '',
                        style: TextStyle(
                          // color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ]),
                  ]),
                ),

                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // =================Recorder Area=================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // suround the following widgets with a container

                            _isRecording
                                ? Container(
                                    decoration: BoxDecoration(
                                      // add elevation
                                      boxShadow: [
                                        BoxShadow(
                                          color: bgColor.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: textColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: IconButton(
                                      onPressed: _isRecording && !_isPaused
                                          ? _pauseRecording
                                          : _resumeRecording,
                                      icon: Icon(
                                        _isPaused
                                            ? Icons.play_arrow
                                            : Icons.pause,
                                        color: bgColor,
                                        size: 30,
                                      ),
                                      // child: Text(_isPaused ? 'Resume' : 'Pause'),
                                    ),
                                  )
                                : Container(),

                            // SizedBox(width: 10),

                            GestureDetector(
                              onTap: !_isRecording ? _startRecording : null,
                              child: AvatarGlow(
                                animate: !_isPaused && _isRecording,
                                glowColor: bgColor,
                                endRadius: 100.0, // Adjust the glow size
                                duration: Duration(milliseconds: 2000),
                                repeatPauseDuration:
                                    Duration(milliseconds: 100),
                                repeat: true,
                                child: CircleAvatar(
                                  backgroundColor: bgColor,
                                  radius: 60, // Increase the avatar radius
                                  child: Icon(Icons.mic,
                                      color: Colors.white,
                                      size: 60), // Increase the icon size
                                ),
                              ),
                            ),

                            // SizedBox(width: 10),

                            _isRecording
                                ? Container(
                                    decoration: BoxDecoration(
                                      // add elevation
                                      boxShadow: [
                                        BoxShadow(
                                          color: bgColor.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: textColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: IconButton(
                                      onPressed:
                                          _isRecording ? _stopRecording : null,
                                      icon: Icon(
                                        Icons.stop,
                                        color: bgColor,
                                        size: 30,
                                      ),
                                    ),
                                  )
                                : Container()

                            // ElevatedButton(
                            //   onPressed: _isRecording ? _stopRecording : null,
                            //   child: Text('Stop'),
                            // ),
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        // ======================= Generate Note ================

                        ElevatedButton(
                          // Add decoration
                          style: ElevatedButton.styleFrom(
                            // set with of 80% of it's container
                            minimumSize: Size(300, 50),
                            maximumSize: Size(600, 100),
                            foregroundColor: textColor,
                            backgroundColor: bgColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed:
                              _isGeneratingNote // Disable button if note is being generated
                                  ? null
                                  : () async {
                                      setState(() {
                                        _isGeneratingNote =
                                            true; // Start loading state
                                      });

                                      try {
                                        String value = await transcribeAudio(
                                            pathToRecorded!);
                                        String gptResponseText =
                                            await generateNote(value);
                                        saveNoteAndQuestion(gptResponseText);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: bgColor,
                                            content: Text(
                                                'Note has been generated successfully'),
                                          ),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red[700],
                                            content:
                                                Text('Couldn\'t generate note'),
                                          ),
                                        );
                                      } finally {
                                        setState(() {
                                          _isGeneratingNote =
                                              false; // End loading state
                                        });
                                      }
                                    },
                          child: Text(
                            'Generate Short Note',
                            style: TextStyle(
                              // give it a font size
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ]),
                ),

                // Text(transcribedText ?? 'No text found'),
                // SizedBox(height: 20),

                // add a text widget containing a red icon the text 'Recording...' when recorder start

                // Button to save the recording
                // SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: _isRecording
                //       ? null
                //       : () {
                //           // save the recorded audio

                //           print('Audio saved at $pathToRecorded');
                //         },
                //   child: Text('Save'),
                // ),

                // Button to play the recording
                // SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () async {
                //     await initPlayer();
                //     await playAudio();
                //   },
                //   child: Text('Play'),
                // ),

                // SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () async {
                //     await stopAudio();
                //   },
                //   child: Text('Stop'),
                // ),
              ],
            ),
          ),
          if (_isGeneratingNote)
            // Loading overlay
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color: bgColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

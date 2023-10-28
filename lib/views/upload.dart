import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartnote/models/user.dart';
import 'package:smartnote/services/generativeai.dart';
import 'package:smartnote/services/storage/cloud/storage_helper.dart';
import 'package:smartnote/services/storage/local/local_storage.dart';
import 'package:smartnote/services/transcribe.dart';
import 'package:file_picker/file_picker.dart';
import 'package:smartnote/theme.dart';
import 'package:smartnote/views/widgets/appbar.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<Upload> {
  String?
      TofilePath; // This variable will hold the path of the selected audio file
  bool _isGeneratingNote = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return Scaffold(
        appBar: SmartNoteAppBar(appBarTitle: "Upload Local Recordings"),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline,
                          color: themeColor), // Info icon in theme color
                      SizedBox(width: 10), // Spacing between the icon and text
                      Text(
                        'Max File Size: 7MB',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: themeColor, // Text in theme color
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5), // Vertical spacing between the two texts
                  Text(
                    'Supported audio formats: .m4a, .mp3, .mp4',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: themeColor, // Text in theme color
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(type: FileType.audio);
                          if (result != null) {
                            setState(() {
                              TofilePath = result.files.single
                                  .path; // Store the path of the selected file
                            });
                          }
                        },
                        child: DottedBorder(
                          // You'll need the dotted_border package
                          child: Padding(
                            padding: const EdgeInsets.all(90.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.cloud_upload_outlined, size: 50),
                                Text(TofilePath == null
                                    ? "DRAG A FILE HERE"
                                    : "File Selected: ${TofilePath!.split('/').last}"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // set with of 80% of it's container
                      minimumSize: Size(300, 50),
                      maximumSize: Size(600, 100),
                      foregroundColor: textColor,
                      backgroundColor: themeColor,
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
                                  print("============Transcribing==========");
                                  String value =
                                      await transcribeAudio(TofilePath!);

                                  print(value);
                                  print(
                                      "==========transcribing done==========");
                                  String gptResponseText =
                                      await generateNote(value);
                                  if (gptResponseText == '') {
                                    throw Exception('Note generation failed');
                                  }
                                  if (gptResponseText == '') {
                                    print(
                                        "==========Empty Gpt Response==========");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: themeColor,
                                        content:
                                            Text('Could\'t generate note!'),
                                      ),
                                    );
                                    throw Exception('Note generation failed');
                                  }

                                  // if user is logged in call cloud saveNoteAndQuestion function
                                  int saveStatus = 0;
                                  if (user != null) {
                                    print(
                                        "==========Saving to cloud==========");
                                    saveStatus =
                                        await supabaseSaveNoteAndQuestion(
                                            gptResponseText);
                                  } else {
                                    print(
                                        "==========Saving to local==========");
                                    saveStatus = await localSaveNoteAndQuestion(
                                        gptResponseText);
                                  }

                                  if (saveStatus == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: themeColor,
                                        content: Text(
                                            'Could\'t save note. Please regenerate note!'),
                                      ),
                                    );
                                    throw Exception('Note generation failed');
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: themeColor,
                                      content: Text(
                                          'Note has been generated successfully!'),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red[700],
                                      content: Text('Couldn\'t generate note!'),
                                    ),
                                  );
                                  throw Exception(
                                      'Note generation failed for unknown reason');
                                } finally {
                                  setState(() {
                                    _isGeneratingNote =
                                        false; // End loading state
                                  });
                                }
                              },
                    child: Text('Generate Short Note',
                        style: themeFontFamily.copyWith(
                            // give it a font size
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            if (_isGeneratingNote)
              // Loading overlay
              Container(
                color: Colors.black.withOpacity(0.6),
                child: const Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // add
                      children: [
                        SizedBox(height: 200),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Hang tight! Generating your note...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        CircularProgressIndicator(
                          color: Colors.white,
                        ),

                        SizedBox(height: 40),

                        // show progress with text
                      ]),
                ),
              ),
          ],
        ));
  }
}

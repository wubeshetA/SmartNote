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
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Video/Audio URL',
                      suffixIcon: Icon(Icons.lock),
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
                            padding: const EdgeInsets.all(100.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.upload_rounded, size: 50),
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
                        style: TextStyle(
                          // give it a font size
                          fontSize: 18,
                        )),
                  ),
                ],
              ),
            ),
            if (_isGeneratingNote)
              // Loading overlay
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: themeColor,
                  ),
                ),
              ),
          ],
        ));
  }
}

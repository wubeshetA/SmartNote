// Create a stateful widget that can just display helloworld
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/services/transcribe.dart';
import 'package:file_picker/file_picker.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<Upload> {
  String transcribedText = 'No transcription yet...';
  bool _isUploading = false;
  String? _selectedFilePath;

  Future<void> _selectFile() async {
    // Use a package like 'file_picker' to select a file
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFilePath = result.files.single.path;
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> _uploadAndTranscribe() async {
    if (_selectedFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a file first!')),
      );
      return;
    }

    try {
      setState(() {
        _isUploading = true;
      });

      // Implement your upload and transcription logic here
      // For example, you could use a service to upload the file and then transcribe
      String transcription = await transcribeAudio(_selectedFilePath!);

      setState(() {
        transcribedText = transcription;
        _isUploading = false;
      });
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload"),
        centerTitle: true,
      ),
      body: Padding(
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
                child: DottedBorder(
                  // You'll need the dotted_border package
                  child: Padding(
                    padding: const EdgeInsets.all(100.0),
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // This makes the column take up only as much space as needed
                      children: [
                        Icon(Icons.cloud_upload_outlined, size: 50),
                        Text("DRAG A FILE HERE"),
                        SizedBox(
                          height: 50,
                          width: 50,
                        ),
                        ElevatedButton(onPressed: () {}, child: Text("Browse")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Generate Note"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

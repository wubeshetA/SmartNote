import 'package:flutter/material.dart';
import 'package:smartnote/backend/gpt/prompt.dart';
import 'package:smartnote/backend/gpt/request.dart';
import 'package:smartnote/backend/storage/local/local_storage.dart';

Future<String> getResponseFromGPT(transcribedText) async {
  print("============sending request to get note==========");
  String gptResponseText = await generateContent(
      NOTE_QUESTIONS_TITLE_GENERATOR_PROMPT, transcribedText);

  int splittedText = splitText(gptResponseText).length;

  if (splittedText == 1) {
    // this means question and title was not generate
    // send antoher request to get the question and title
    print("==========resending request to get question and title==========");
    String questionTitle = await generateContent(
        NOTE_QUESTIONS_TITLE_GENERATOR_PROMPT, transcribedText);

    // concat the question and title with the note with ---------- as a seperator
    gptResponseText = '$gptResponseText  \n ---------- \n $questionTitle';
  } else if (splittedText == 2) {
    // this means title is not generated
    // send antoher request to get the title
    print("==========resending requst to get title==========");
    String title =
        await generateContent(ONLY_TITLE_GENERATOR_PROMPT, transcribedText);
    // concat the title with the note with ---------- as a seperator
    gptResponseText = '$gptResponseText  \n ---------- \n $title';
  }

  print("============response from gpt==========");
  debugPrint(gptResponseText);
  print("========================================");

  return gptResponseText;
}

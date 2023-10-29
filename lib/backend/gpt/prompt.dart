const NOTE_QUESTIONS_TITLE_GENERATOR_PROMPT = '''
The given text is a transcription of the audio recording of educational content.
Generate shortnotes(summaries) about the content in HTML format as shown in the example output.
Format the notes using different html tags such as <b>, <mark>, heardings, <ul> to make the notes well strucuture and emphasis on important words and phrases. There should be at least 2 important words or phrases with <mark> tag. After the notes add "----------" as separator on a new line and generate five to ten questions relevant to the content in JSON format. After the questions add "----------" on a new line and add a title for the note.

Example Output:

<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
<body>
  <style>
  body {font-family: poppins, sans-serif;}
  body > ul {padding: 0; margin: 20px;} body > ul > * {padding: 5px;} h2 {text-align: center;}
  
  </style>
  <ul>
    <h2>Topic</h2>
    <ul>
        <li><b>Point 1</b></li>
        <li><mark>Point 2</mark></li>
        
    </ul>
    <ul>
    <h3>Subtopic</h3>
        <li><b>Point 3</b></li>
        <li><mark>Point 4</mark></li>
  </ul>
</body>
</html>
----------
[
  {"question": "Q1?", "answer": "A1"},
  {"question": "Q2?", "answer": "A2"}
]
----------
Title

''';

const ONLY_QUESTIONS_TITLE_GENERATOR_PROMPT = '''
The given text is a transcription of the audio recording of educational content.
Generate five to ten questions relevant to the content in JSON format. After the questions add "----------" on a new line and add a title for the note.

Example Output:

----------
[
  {"question": "Q1?", "answer": "A1"},
  {"question": "Q2?", "answer": "A2"},
  {"question": "Q3?", "answer": "A3"},
]
----------
Title
''';

const ONLY_TITLE_GENERATOR_PROMPT = '''
The given text is a transcription of the audio recording of educational content.
response should be a title for the note with out including other extra information.

Example Output:
Title
''';

# SmartNote - AI Note Taking App

## Introduction

SmartNote is your next-generation note-taking companion, equipped with AI to transform the way you capture and understand information. It is designed for students, professionals, and anyone eager to turn speeches, lectures, and online content into comprehensive notes and interactive learning materials.

## Features

- **AI-Powered Summaries:** SmartNote employs Generative AI to transform audio content from classrooms, YouTube videos, online courses, and more into concise, understandable notes.
- **Interactive Learning:** It doesn't just stop at notes; SmartNote also crafts customized questions with answers directly derived from the content, offering an enhanced learning experience.
- **Accessibility:** With our intuitive design and user-friendly interface, accessing and navigating through your notes is a breeze.

### Visual Design

Get a glimpse of the app’s aesthetics and functionalities on [Figma](https://www.figma.com/file/ZuzGX4w0x4oG8sTfDRYoco/SmartNote?type=design&node-id=32%3A1610&mode=design&t=EzG4vhixAetbWJFU-1). For a more dynamic overview, check out the video demo [here](https://drive.google.com/file/d/1-PCBwfZUp4IVmuRftEyM_jJ2-Iu8DqUI/view?usp=sharing).

## Technical Structure

SmartNote is crafted with Flutter and Dart, ensuring a smooth, cross-platform experience. We're also utilizing Firebase for robust authentication and storage, guaranteeing technical reliability and seamless user interaction.

### Repository Organization:

- `lib/`: Holds the app’s source code
    - `views/`: Houses the UI components and screens
    - `services/`: Encapsulates the business logic, including:
        - `storage`: Manages data storage and database interactions
        - `generativeAI`: Handles API requests to OpenAI's Generative AI models
        - `transcribe`: Employs Google Speech Recognition API for audio transcription

## Our Mission

SmartNote aspires to revolutionize note-taking by eliminating the interruptions and inconveniences associated with traditional methods. We're opening our repository to the public to foster a community of innovators and learners committed to enhancing education and information retention.

## The AI Edge

In the traditional setting, students juggle between listening and note-taking, often losing the essence of the learning material. SmartNote’s AI swiftly converts audio inputs into structured notes, allowing users to focus solely on comprehension and interaction. We integrate Speech Recognition and Natural Language Processing, powered by OpenAI’s `gpt-3.5_turbo`, ensuring the generated content is accurate and tailored to the source material.

## Get Involved!

Join us in refining and expanding SmartNote! Your insights and contributions are valuable in making education accessible and engaging for everyone. Kindly refer to our [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines on how to be a part of this innovative journey.

## Deployement

Please keep your eye out as the app will be on Playstore very soon.

---

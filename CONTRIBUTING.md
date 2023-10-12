# CONTRIBUTIONS

## How to install and run the project

1. Clone this repository

```bash
git clone https://github.com/wubeshetA/smartnote.git
```

2. Change your current working directory to the project directory

```bash
cd smartnote
```

3. Configure settings for the project

    1. Create a file named `.env` in the assets folder
    2. Copy the contents of `.env.example` to `.env` and change the value of variables to your own
    3. As the this app uses Google's speech to text api to transcribe an audio, create a project on GCP. Then enable the speech to text api and create a service account. Download the service account key and save it in the assets folder as `speech_to_text.json`. 
    
    You may watch this video to assist you on this process. [https://www.youtube.com/watch?v=aqUCoOWA3Ec](https://www.youtube.com/watch?v=aqUCoOWA3Ec)


4. Install dependencies.

```bash
flutter pub get
```

5. Run the project

```bash
flutter run
```

All the above steps install and run the project. To contribute to the project, follow the steps below.

5. Create your own branch

```bash
git checkout -b <branch_name>
```

6. Make your changes, check if the changes are working as expected, commit changes and push the branch.


```bash
git add <modified_files>
```

```bash
git commit -m "your commit message goes here."
```
```bash
git push origin <branch_name>
```

7. Create a pull request to the `dev` branch for review.


Thank you for time and effort to contribute to the project. :smiley:



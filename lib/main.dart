import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartnote/models/user.dart';
import 'package:smartnote/services/auth_services.dart';
import 'package:smartnote/services/storage/local/sqlite_db_helper.dart';
import 'package:smartnote/views/auth/login_page.dart';
import 'package:smartnote/views/auth/signup_page.dart';
import 'package:smartnote/views/profile.dart';
import 'package:smartnote/views/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as Supabase;
import 'views/widgets/bottom_navigator.dart';
import 'views/note/note_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // await FirebaseAppCheck.instance.activate(
  //   // webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),

  //   // Set androidProvider to `AndroidProvider.debug`
  //   androidProvider: AndroidProvider.debug
  // );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

// =============== playground ===============
  // SqliteDatabaseHelper db = SqliteDatabaseHelper();
  // final all_data = await db.getPaths();
  

  // remove database
  // db.deleteAll();

  // Add mock data
  // saveNoteAndQuestion(await rootBundle.loadString('assets/mock_data.html'))
  //     .then((value) => print(value))
  //     .onError((error, stackTrace) {
  //   print("Error while saving mockdata");
  //   print(error);
  // });

  print("=============== ALL DATA IN DB ===================");
  // print(all_data);
  print("=================PRINT ALL DATA IN DB ENDS HERE===================");

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          value: AuthService().user,
          initialData: null,
        ),
      ],
      child: SmartNote(),
    ),
  );
}

class SmartNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // '/': (context) => Home(),
        '/note': (context) => NoteView(
            htmlFilePath: 'path_to_your_html_file.html',
            topicTitle: 'Topic Title'),
        '/main': (context) => BottomNavBarNavigator(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/profile': (context) => UserProfilePage(),
      },
      // remove debug banner
      debugShowCheckedModeBanner: false,

      title: 'Recorder',
      theme: ThemeData(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavBarNavigator();
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}

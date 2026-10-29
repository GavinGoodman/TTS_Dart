import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/communicator.dart';
import 'screens/start_screen.dart';

/*
This is the main program file for the application to run and start. Essentially,
this is the driver for the application. Here we call the methods and other files
used for creating the application like the screen layouts, the tts utilization,
and the actual board information utilized for the application to run. Additionally,
we set the theme of the application in this instance as well. Not much new in
this main file that was learned, just is similar to other assignments done. 
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // required for the async work of
  // tts package being used.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          CommunicationProvider(), // creates the communication provider
      child: MaterialApp(
        // method to share across screens and is used for the
        // rebuild process of the application
        title: 'AAC Communicator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // sets the theme data for the application in use
          useMaterial3: true,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            // this will apply the theme style for the app
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        home: StartScreen(), // runs the start screen which is the blue screen
      ), // at the beginning of the application.
    );
  }
}

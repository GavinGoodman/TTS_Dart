import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
This is the communicator file that hosts the information to turn this colorful
grid of buttons into an application that will speak the words for the user. The
entire point of this file is to allow the device to speak for the user. In here,
we have the tts operation with list utility to add words and speak the words
selected. We also have the inital state and saved state in order to allow the
user to reenter the app and still have the same previous words selected in the
communicator still. Not much more to be said, we will explain each call in the
file with in-line citations.
 */

class CommunicationProvider extends ChangeNotifier {
  FlutterTts _tts = FlutterTts(); // This is the tts package call to utilize tts

  List<String> _words = []; // This is the array to hold the words

  List<String> get words =>
      List.unmodifiable(_words); // This will read the list
  // utilized to access without modification

  String get sentence => _words.join(' '); // This joins selected words with a
  bool get isEmpty => _words.isEmpty; // separator and checks if sentence bar
  // is empty
  static const String _wordKey =
      'saved_sentence'; // key to read and write sentence
  // in sentence bar with communicator
  CommunicationProvider() {
    _initTts(); // runs to start the app with tts and the next will save the
    _loadSaved(); // state of tts to run again when reloaded.
  }

  /*
  Runs to ensure the start of the tts package is correct at the right values.
  This will set the language to english, set the speed of the spoken words,
  set the volume of the speaker (very quiet in general), and the pitch of the
  speaker.
   */
  Future<void> _initTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.35);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.1);
  }

  /*
  This is the saving and restoring of the tts and sentences once the application
  is reloaded.
   */
  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_wordKey);

    if (saved != null && saved.isNotEmpty) {
      _words = saved.split(' '); // splits the words again and then notifies for
      notifyListeners(); // the save state to work correctly.
    }
  }

  /*
  This method is utilized for sentence storage and restore when reloading
   */
  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_wordKey, sentence);
  }

  /*
  This method adds the words to the sentence bar and notifies of the change
   */
  void addWord(String word) {
    _words.add(word);
    notifyListeners();
    _persist();
  }

  /*
  This method clears the entire sentence bar and notifies the listeners once
  it is completed.
   */
  void clearSentence() {
    _words.clear();
    notifyListeners();
    _persist();
  }

  /*
  THis is the method is what is used to read the full sentence
   */
  Future<void> speakSentence() async {
    if (_words.isEmpty)
      return; // checks and will not read an empty sentence bar
    await _tts.stop(); // stops speech if reclicked and reads words.
    await _tts.speak(sentence);
  }

  /*
  This is a similar method but is just utilized to speak the word, on long
  press or inserting into a word into the sentence bar
   */
  Future<void> speakWord(String word) async {
    await _tts.stop();
    await _tts.speak(word);
  }

  /*
  This is similar to garbage collection and just frees up space and tts for use
  again in the future.
   */
  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }
}

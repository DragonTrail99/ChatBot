import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';



class SpeechText {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  var _lastWords;
  /// Initialize - happens once
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  /// Stop Listening
  void _stopListening() async {
    await _speechToText.stop();
  }


  /// Result
  void _onSpeechResult(SpeechRecognitionResult result) {
      _lastWords = result.recognizedWords;
  }
}




import 'package:chat_bot/components/open_ai.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_bot/components/constants.dart';
import 'package:rive/rive.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:chat_bot/components/avatar_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Speech to Text

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  var _lastWords;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Stop listening
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

   void _onSpeechResult(SpeechRecognitionResult result) async {
   setState(() {
     _lastWords = result.recognizedWords;
   });
  }

  @override
  void dispose(){
    super.dispose();
    _speechToText.stop();
}
// Rive Animation
  RiveAvatar riveAvatar = RiveAvatar(motion:'Wave Trigger');
  @override
  Widget build(BuildContext context) {
    print(_lastWords);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: const Text(
          'ATOM',
          style: TextStyle(fontFamily: 'Righteous'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Avtar Background
            Stack(alignment: Alignment.center, children: [
              Container(
                margin: const EdgeInsetsDirectional.only(top: 20.0),
                height: MediaQuery.of(context).size.height / 5.5,
                decoration: const BoxDecoration(
                  color: Color(0xFF666666),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                height: 200,
                child: GestureDetector(
                  onTap: riveAvatar.hitAnimation,
                  child: RiveAnimation.asset('assets/atom_home.riv',
                      onInit: riveAvatar.onRiveInit),
                ),
              ),
            ]),
            // Large Label
            const Text(
              'What can i help you with?',
              textAlign: TextAlign.center,
              style: kMainLabel,
            ),

            SizedBox(height: 10.0),
            Stack(children: [
              Container(
                margin: const EdgeInsets.all(20.0).copyWith(
                  bottom: 100.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF666666),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0).copyWith(
                    bottom: 0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Try saying: Who is the owner of Tesla?',
                          style: kSuggestionText,
                        ),
                        Text(
                          'Try saying: Give me an image of Cat!',
                          style: kSuggestionText,
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'ChatGPT + Dall-E',
                              style: kPoweredText,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              const Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: AssetImage('images/open_ai.png'),
                    height: 40,
                  )),
            ])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
          () async {
          if (_speechToText.isNotListening) {
            _startListening();
          }
          else {
            _stopListening();
          }
        },
        backgroundColor: Color(0xffFB2576),
        foregroundColor: Color(0xffffffff),
        highlightElevation: 100.0,
        tooltip: 'Listen',
        child: Icon(
          _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:chat_bot/components/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
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
      body: Column(
        children: [
          // Avtar Background
          Stack(children: [
            Container(
              margin: const EdgeInsetsDirectional.only(top: 20.0),
              height: MediaQuery.of(context).size.height / 4.5,
              decoration: const BoxDecoration(
                color: Color(0xFF666666),
                shape: BoxShape.circle,
              ),
            ),
            Align(alignment: Alignment.center,child: const Image(image: AssetImage('images/atom 1.png'), height:160,)),
          ]),
          const SizedBox(height: 5.0),
          // Large Label
          const Text(
            'What can i help you with?',
            textAlign: TextAlign.center,
            style: kMainLabel,
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Stack(children: [
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
                    bottom:0,
                  ),
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
                      Align(alignment: Alignment.bottomRight, child: Text('ChatGPT + Dall-E', style: kPoweredText,))
                    ],
                  ),
                ),
              ),
              const Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: AssetImage('images/open_ai.png'),
                    height: 40,
                  )),
            ]),
          )
        ],
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        backgroundColor: Color(0xffFB2576),
        foregroundColor: Color(0xffffffff),
        highlightElevation: 100.0,
        child: Icon(
          Icons.mic,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

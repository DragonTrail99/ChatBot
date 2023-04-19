import 'package:chat_bot/components/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenAi {

  String chatGPTurl = 'https://api.openai.com/v1/chat/completions';


  Future<void> getResponse() async{
    http.Response response = await http.post(Uri.parse(chatGPTurl),
        headers: {
          'Content-Type' : 'application/json',
          'Authorization' : 'Bearer $kOpenAi_APIKEY',
        },
        body: jsonEncode(
        {
          'model': 'gpt-3.5-turbo',
          'messages' : [{
            'role': 'user', 'content': "Who's the owner of Tesla?"
        }]
        }
    ),
    );
    if(response.statusCode == 201) {
      String data = response.body;
      return jsonDecode(data);
    }
    else{
      print(response.statusCode);
    }

  }
}
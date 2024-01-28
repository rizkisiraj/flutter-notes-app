import 'dart:convert';
import 'package:notes_app/model/ChatResponse.dart';
import '../constant/api_constant.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  Future<ChatResponse> fetchChatResponse(String message) async {

    final response = await http.post(
      Uri.parse(ApiConstant.baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${ApiConstant.apiKey}",
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo', // or another available model
        'messages': [{'role': 'system', 'content': ApiConstant.prePrompt},{'role': 'user', 'content': message}],
      }),
    );

    if (response.statusCode == 200) {
      return ChatResponse.fromJson(jsonDecode(response.body));
    } else {
      throw throw Exception('Failed to load chat response. Status code: ${response.statusCode}');
    }
  }
}
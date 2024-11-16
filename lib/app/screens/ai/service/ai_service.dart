import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ChatGPT {
  final String apiKey =
      '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'; // Replace with your API key
  Future<String> sendMessageToChatGPT(var prompt) async {
    const String apiUrl = 'https://api.openai.com/v1/chat/completions';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o',
          'messages': prompt,
          'temperature': 0.1,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'];
      } else {
        return 'ChatGPT error...';
      }
    } catch (e) {
      return 'ChatGPT error...';
    }
  }
}

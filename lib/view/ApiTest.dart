
import 'package:flutter/material.dart';
import 'package:notes_app/model/ChatResponse.dart';
import 'package:notes_app/services/api_service.dart';

class ApiTest extends StatefulWidget {
  ApiTest({Key? key}) : super(key: key);

  @override
  _ApiTestState createState() => _ApiTestState();
}

class _ApiTestState extends State<ApiTest> {
  final OpenAIService openAIService = OpenAIService();

  String _dummyText = "In the quaint village of Willowbrook, nestled amidst lush greenery and rolling hills, the annual Harvest Festival is a highly anticipated event that brings the community together. Every autumn, the townsfolk come together to celebrate the bountiful harvest, with colorful decorations adorning the streets and a grand parade featuring vibrant floats and marching bands. The festival's centerpiece is the massive pumpkin contest, where local farmers compete to grow the largest and most impressive pumpkins, with the winner receiving a coveted trophy and bragging rights for the year.";
  String _summary = "Loading...";

  void _updateSumary(String summary) {
    setState(() {
      _summary = summary;
    });
  }

  void submitQuery() async {
    try {
      ChatResponse chatResponse = await openAIService.fetchChatResponse(_dummyText);
      print(chatResponse);
      _updateSumary(chatResponse.content);
    } catch(e) {
      _updateSumary("Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_summary),
        ElevatedButton(onPressed: submitQuery, child: Text("Coba"))
      ],
    );
  }
}
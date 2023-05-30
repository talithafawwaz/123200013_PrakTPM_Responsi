import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsi_123200013/model/valorant_agent_model.dart';

class Detail extends StatefulWidget {
  final String agentUuid;

  Detail({required this.agentUuid});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  ValorantAgentModel? _agent;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://valorant-api.com/v1/agents/${widget.agentUuid}'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final valorantAgentModel = ValorantAgentModel.fromJson(jsonData['data']);
      setState(() {
        _agent = valorantAgentModel;
      });
    } else {
      // Handle error response
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agent Detail'),
      ),
      body: _agent != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _agent!.displayName ?? '',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  if (_agent!.displayIcon != null)
                    Image.network(
                      _agent!.displayIcon!,
                      height: 200,
                      width: 200,
                    ),
                  SizedBox(height: 16),
                  Text(
                    _agent!.description ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Role: ${_agent!.role ?? ''}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

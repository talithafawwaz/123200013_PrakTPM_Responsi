import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsi_123200013/view/detail_page.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsi_123200013/model/list_valorant_model.dart';
import 'package:responsi_123200013/view/auth/login_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Data> _dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Replace the URL with your actual API endpoint
    final response =
        await http.get(Uri.parse('https://valorant-api.com/v1/agents'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final listValorantModel = valorant_list.fromJson(jsonData);
      setState(() {
        _dataList = listValorantModel.data ?? [];
      });
    } else {
      // Handle error response
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f1f5),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            _validasi();
          },
        ),
      ),
      body: _dataList.isNotEmpty
          ? ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                final data = _dataList[index];
                return ListTile(
                  title: Text(data.displayName ?? ''),
                  subtitle: Text(data.description ?? ''),
                  leading: data.displayIcon != null
                      ? Image.network(data.displayIcon!)
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(agentUuid: ''),
                      ),
                    );
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  _validasi() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Logout"),
              content: Text("Are you sure want to logout?"),
              actions: [
                TextButton(
                    onPressed: () => _logoutProcess(), child: Text("Yes")),
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text("No")),
              ],
            ));
  }

  _logoutProcess() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('status', false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }
}

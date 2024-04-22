import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  List<Map<String, dynamic>> _users = [];
  Map<String, int> _badgeStatistics = {};

  @override
  void initState() {
    super.initState();
    // Fetch registered users and badge statistics when the widget initializes
    _fetchUsers();
    _fetchBadgeStatistics();
  }

  // Fetch registered users from the backend
  Future<void> _fetchUsers() async {
    final response = await http.get(Uri.parse('http://localhost:3000/users'));//use local Ip address
    if (response.statusCode == 200) {
      setState(() {
        _users = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Fetch badge statistics from the backend
  Future<void> _fetchBadgeStatistics() async {
    final response = await http.get(Uri.parse('http://localhost:3000/badge_statistics'));//use local Ip address
    if (response.statusCode == 200) {
      setState(() {
        _badgeStatistics = Map<String, int>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load badge statistics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registered Users:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_users[index]['username']),
                    subtitle: Text(_users[index]['email']),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Badge Statistics:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _badgeStatistics.length,
                itemBuilder: (context, index) {
                  final badgeName = _badgeStatistics.keys.elementAt(index);
                  final badgeCount = _badgeStatistics.values.elementAt(index);
                  return ListTile(
                    title: Text(badgeName),
                    subtitle: Text('Sent: $badgeCount'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

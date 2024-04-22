import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BadgeStatisticsScreen extends StatefulWidget {
  @override
  _BadgeStatisticsScreenState createState() => _BadgeStatisticsScreenState();
}

class _BadgeStatisticsScreenState extends State<BadgeStatisticsScreen> {
  List<String> predefinedBadges = ["Great Job", "Team Player", "Innovator"];
  String selectedBadge;
  List<dynamic> receivedBadges = []; 

  // Function to fetch received badges from backend
  Future<void> fetchReceivedBadges() async {
    // Make HTTP request to fetch received badges
    final response = await http.get(Uri.parse('http://localhost:3000/fetchBadges'));

    if (response.statusCode == 200) {
      setState(() {
        receivedBadges = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load received badges');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchReceivedBadges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Badge Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Badge',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedBadge,
              hint: Text('Select Badge'),
              onChanged: (String value) {
                setState(() {
                  selectedBadge = value;
                });
              },
              items: predefinedBadges.map((String badge) {
                return DropdownMenuItem<String>(
                  value: badge,
                  child: Text(badge),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                // Code to send badge to another user
              },
              child: Text('Send Badge'),
            ),
            SizedBox(height: 20),
            Text(
              'Received Badges',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: receivedBadges.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(receivedBadges[index]['badge']),
                    subtitle: Text(
                        'From: ${receivedBadges[index]['sender']}, To: ${receivedBadges[index]['receiver']}'),
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

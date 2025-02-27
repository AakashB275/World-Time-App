import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location name for UI
  String flag; // URL to an asset flag icon
  String url; // Timezone (e.g., "Europe/Amsterdam")
  String time =
      "Loading..."; // Does not work if we initialize as non nullable variable

  WorldTime({required this.flag, required this.location, required this.url});

  Future<void> getData() async {
    try {
      String apiUrl = 'https://timeapi.io/api/Time/current/zone?timeZone=$url';

      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String datetime = data['dateTime'];

        DateTime now = DateTime.parse(datetime);
        time = DateFormat.jm().format(now); // Update time after fetching data
        print("Time in $location: $time");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        time = "Error fetching time";
      }
    } catch (e) {
      print("Exception: $e");
      time = "Error: Could not fetch time";
    }
  }
}

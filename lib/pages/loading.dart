import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = "Loading...";

  void setUp() async {
    WorldTime choice = WorldTime(
        flag: 'Netherlands.png',
        location: 'Amsterdam',
        url: 'Europe/Amsterdam');
    await choice.getData();
    print(choice.time);

    setState(() {
      time = choice.time; // Update UI with the fetched time
    });

    Navigator.pushNamed(context, '/home', arguments: {
      'location': choice.location,
      'flag': choice.flag,
      'time': choice.time,
    }); //we used the arguments parameter to send the data to that route which is mentioned as the other argument from this page/route
  }

  @override
  void initState() {
    super.initState();
    setUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 50.0,
        ),
        // child: Text(
        //   time,
        //   style: TextStyle(fontSize: 24),
        // ),
      ),
    );
  }
}

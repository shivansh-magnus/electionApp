import 'package:election/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Client? httpClient;
  Web3Client? ethClient;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Election'),
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                hintText: "Enter Election_Name",
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {}, child: Text("Start Election")))
        ],
      )),
    );
  }
}

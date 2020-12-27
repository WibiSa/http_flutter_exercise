import 'package:flutter/material.dart';
import 'package:http_flutter_exercise/user_model.dart';
import 'package:http/http.dart' as http;

//Class ini cuma sample coba-coba API lain.
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<User> createUser(String name, String job) async {
  final String apiUrl = 'https://reqres.in/api/users';

  final response = await http.post(apiUrl, body: {"name": name, "job": job});

  if (response.statusCode == 201) {
    final String responseString = response.body;

    return userFromJson(responseString);
  } else {
    return null;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  User _user;
  final String name = 'wibi';
  final String job = 'android developer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Data yang akan di kirim ke API reqres.in/api/users'),
            SizedBox(height: 16),
            Text(name),
            Text(job),
            SizedBox(height: 32),
            _user == null
                ? Container()
                : Text('Data yang telah dibuat pada: ${_user.createdAt}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final User user = await createUser(name, job);
          setState(() {
            _user = user;
          });
        },
        child: Icon(Icons.cloud_download),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Contact US'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hasan BAHAR',
                style: TextStyle(
                    fontSize: 45,
                    color: Colors.brown[900],
                    fontFamily: 'Pacifico'),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 30,
                  color: Colors.brown[900],
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 45),
                color: Colors.black54,
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  title: Text(
                    'hasan.bhr20@gmail.com',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 45),
                color: Colors.black54,
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  title: Text(
                    '0535-315-0295',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Divider(),
              Divider(),
              Divider(),
              Divider(),
              Text(
                'Şikayet ve önerileriniz için benimle iletişime geçin',
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,

                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

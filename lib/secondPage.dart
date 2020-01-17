import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String url;

  SecondPage(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Unsplash photo viewer',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: _Image()
    );
  }
  
  Widget _Image() {
    return new Container(
      child: Center(
        child: Image.network(url),
      )
    );
  } 
}

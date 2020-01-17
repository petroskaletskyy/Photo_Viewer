import 'package:flutter/material.dart';
import 'package:photo_viewer/secondPage.dart';
import 'src.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class FirstPage extends StatefulWidget {

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List data;

  Future<String> getJSONData() async {
    var response = await http.get(
      Uri.encodeFull("https://api.unsplash.com/photos/?client_id=$apiKey"),
    );

    setState(() {
      data = json.decode(response.body);
    });

    return "Successfull";
  }


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
      body: _buildListView(),
      backgroundColor: Color.fromRGBO(232, 232, 232, 0.9),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return _buildImageColumn(data[index]);
        }
    );
  }

  Widget _buildImageColumn(dynamic item) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(color: Colors.white60),
      margin: const EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          _image(item),
          new Container(
            child: new Column(
              children: <Widget>[
                _buildRow(item)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _image(dynamic item) {
    return new Container(
      child: new InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(item['urls']['full'])));
        },
        child: CachedNetworkImage(
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
          imageUrl: item['urls']['small'],
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => new Icon(Icons.error),
          fadeOutDuration: new Duration(seconds: 1),
          fadeInDuration: new Duration(seconds: 3),
        ),
      ),
    );
  }

  Widget _buildRow(dynamic item) {
    return Container(
      width: 270.0,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.fromLTRB(0, 3.0, 0, 0),
                child: title(item)
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 5.0, 0),
                child: description(item)
            )
          ],
        ),
      ),
    );
  }

  Widget title(dynamic item) {
    return new Text(
        item['user']['name'] == null ? '' : 'Author: ' + item['user']['name'],
        overflow: TextOverflow.ellipsis,
        style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500
        )
    );
  }

  Widget description(dynamic item) {
    return new Text(
      item['description'] == null ? 'There is no description' : item['description'],
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      maxLines: 3,
      textAlign: TextAlign.justify,
      style: new TextStyle(
        fontSize: 12.0,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getJSONData();
  }

}

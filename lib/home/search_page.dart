import 'package:flutter/material.dart';
import '../global_config.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = new TextEditingController();

  Widget searchInput() {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
            child: new FlatButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.black54,
              ),
              label: new Text(""),
            ),
            width: 60.0,
          ),
          new Expanded(
            child: new TextField(
              controller: _textController,
              autofocus: true,
              decoration: new InputDecoration.collapsed(
                  hintText: "请输入城市名称",
                  hintStyle: new TextStyle(color: Colors.black54)),
            ),
          ),
          new Container(
            width: 60.0,
            child: new FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context, _textController.text);
                },
                icon: new Icon(
                  Icons.check,
                  color: Colors.black54,
                ),
                label: new Text("")),
          )
        ],
      ),
      decoration: new BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        color: Colors.white70,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: GlobalConfig.themeData,
      home: new Scaffold(
        appBar: new AppBar(
          title: searchInput(),
        ),
      ),
    );
  }
}

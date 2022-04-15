import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fake_common/fake_common.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await FakeCommon.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, i)=> renderRow(i,context),
          ),
        ),
      ),
    );
  }

  void showPrivacyAlert(String text, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: const Text("隐私协议"),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: const Text("同意"),
                onPressed: () {
                  // 关闭弹框
                  Navigator.of(context).pop();
                  FakeCommon.submitPolicyGrantResult(true, (dynamic ret, Map err) => {
                    if(err!=null) {
                      // nothing to do
                    } else {
                      // nothing to do
                    }
                  });
                },
              ),
              FlatButton(
                child: const Text("拒绝"),
                onPressed: () {
                  Navigator.of(context).pop();
                  FakeCommon.submitPolicyGrantResult(false, (dynamic ret, Map err) => {
                    if(err!=null)
                      {
                        // nothing to do
                      }
                    else
                      {
                        // nothing to do
                      }
                  });
                },
              )
            ]));
  }

  Widget renderRow(i, BuildContext context){
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 30,
        ),
        Text('Running on: $_platformVersion\n'),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: FlatButton(
            color: Colors.blueGrey,
            textColor: Colors.white,
            child: const Text('打开隐私协议弹框'),
            onPressed: (){
              showPrivacyAlert('是否同意隐私协议？',context);
            },
          ),
        ),
      ],
    );
  }
}

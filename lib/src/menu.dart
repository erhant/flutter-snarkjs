import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOptions {
  navigationDelegate,
  userAgent,
  javascriptChannel,
  loadFlutterAsset,
  loadLocalFile,
  loadHtmlString,
  loadSnarkjs
}

class Menu extends StatefulWidget {
  const Menu({required this.controller, super.key});

  final WebViewController controller;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuOptions>(
      onSelected: (value) async {
        switch (value) {
          case _MenuOptions.navigationDelegate:
            await widget.controller
                .loadRequest(Uri.parse('https://youtube.com'));
            break;
          case _MenuOptions.userAgent:
            final userAgent = await widget.controller
                .runJavaScriptReturningResult('navigator.userAgent');
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('$userAgent'),
            ));
            break;
          case _MenuOptions.javascriptChannel:
            await widget.controller.runJavaScript('''
var req = new XMLHttpRequest();
req.open('GET', "https://api.ipify.org/?format=json");
req.onload = function() {
  if (req.status == 200) {
    let response = JSON.parse(req.responseText);
    SnackBar.postMessage("IP Address: " + response.ip);
  } else {
    SnackBar.postMessage("Error: " + req.status);
  }
}
req.send();''');
            break;
          case _MenuOptions.loadFlutterAsset:
            await _onLoadFlutterAssetExample(widget.controller, context);
            break;
          case _MenuOptions.loadLocalFile:
            await _onLoadLocalFileExample(widget.controller, context);
            break;
          case _MenuOptions.loadHtmlString:
            await _onLoadHtmlStringExample(widget.controller, context);
            break;
          case _MenuOptions.loadSnarkjs:
            await _onLoadSnarkjsExample(widget.controller, context);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.navigationDelegate,
          child: Text('Navigate to YouTube'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.userAgent,
          child: Text('Show user-agent'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.javascriptChannel,
          child: Text('Lookup IP Address'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.loadFlutterAsset,
          child: Text('Load Flutter Asset'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.loadHtmlString,
          child: Text('Load HTML string'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.loadLocalFile,
          child: Text('Load local file'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.loadSnarkjs,
          child: Text('Load SnarkJS example'),
        ),
      ],
    );
  }
}

Future<void> _onLoadFlutterAssetExample(
    WebViewController controller, BuildContext context) async {
  await controller.loadFlutterAsset('assets/www/demo.html');
}

Future<void> _onLoadLocalFileExample(
    WebViewController controller, BuildContext context) async {
  final String pathToIndex = await _prepareLocalFile();

  await controller.loadFile(pathToIndex);
}

Future<void> _onLoadSnarkjsExample(
    WebViewController controller, BuildContext context) async {
  await controller.loadFlutterAsset('assets/www/snarkjs.html');
}

Future<String> _prepareLocalFile() async {
  final String tmpDir = (await getTemporaryDirectory()).path;
  final File indexFile = File('$tmpDir/www/demo.html');

  await Directory('$tmpDir/www').create(recursive: true);
  await indexFile.writeAsString('''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
 This is an example page used to demonstrate how to load a local file or HTML
 string using the <a href="https://pub.dev/packages/webview_flutter">Flutter
 webview</a> plugin.
</p>

</body>
</html>
''');

  return indexFile.path;
}

Future<void> _onLoadHtmlStringExample(
    WebViewController controller, BuildContext context) async {
  await controller.loadHtmlString('''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
 Tiny paragraph.
</p>

</body>
</html>
''');
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UpdateIcons extends StatefulWidget {
  const UpdateIcons({required this.controller, super.key});

  final Completer<WebViewController> controller;

  @override
  State<UpdateIcons> createState() => _UpdateIconsState();
}

class _UpdateIconsState extends State<UpdateIcons> {
  WebViewController? _controller;
  Timer? chk;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: widget.controller.future,
      builder: (context, snapshot) {
        final WebViewController? controller = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done ||
            controller == null) {
          return Row(
            children: const <Widget>[
              Icon(Icons.replay),
            ],
          );
        }

        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () {
                controller.reload();
                _controller?.reload();
              },
            ),
          ],
        );
      },
    );
  }
}

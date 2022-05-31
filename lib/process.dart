import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:reapply_dates/main.dart';
import 'package:reapply_dates/navigation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({Key? key, required this.controller}) : super(key: key);
  final Completer<WebViewController> controller;
  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  final controller = Completer<WebViewController>();
  WebViewController? _controller;
  Map<String, dynamic> map = {};
  var loading = 0;
  @override
  Widget build(BuildContext context) {
    return reapply();
  }

  Widget reapply() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.primaryColor,
        title:
            'Visa Date Updates'.text.xl2.caption(context).fontFamily("Times New Roman").bold.make(),
        actions: [
          UpdateIcons(controller: controller).px(20),
        ],
      ),
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'https://cgifederal.secure.force.com/',
            onWebViewCreated: (webViewController) {
              widget.controller.complete(webViewController);
              _controller = webViewController;
            },
            onPageStarted: (url) {
              setState(() {
                loading = 0;
              });
            },
            onProgress: (progress) {
              setState(() {
                loading = progress;
              });
            },
            onPageFinished: (url) async {
              Future<String> innerData = _controller!.evaluateJavascript(
                  "document.querySelector('#ctl00_nav_side1').innerText");
              final date = await innerData;
              setState(() {
                map = {
                  "Date": date,
                };
                loading = 100;
              });
              final kversion = map.toString();
              final regex0 = RegExp(("First(.*)\."));
              final match0 = regex0.firstMatch(kversion);
              final formatetd = match0?.group(0) ?? 0;
              final finalDate = formatetd
                  .toString()
                  .eliminateLast
                  .eliminateLast
                  .eliminateLast
                  .eliminateLast
                  .eliminateLast
                  .eliminateLast
                  .eliminateLast
                  .eliminateLast;
              final regex2 =
                  RegExp("(?<=First Available Appointment Is ).*(?=, )");
              final match1 = regex2.firstMatch(finalDate);
              final onlyDate = match1?.group(0) ?? 0;
              if (finalDate.isNotEmpty) {
                if (onlyDate.toString().contains(userDate)) {
                  final feedback = await http
                      .post(Uri.parse(
                          "https://api.telegram.org/bot${userToken}/sendMessage?chat_id=${userID}&text=𝐔𝐩𝐝𝐚𝐭𝐞: $onlyDate, ${DateTime.now().year}\n\n<---𝐕𝐢𝐬𝐚 𝐃𝐚𝐭𝐞𝐬 𝐔𝐩𝐝𝐚𝐭𝐞--->\n\n$finalDate\n\n<--------------𝑬𝑵𝑫-------------->"))
                      .timeout(10.seconds, onTimeout: () {
                    return http.Response("", 500);
                  });

                  if (feedback.statusCode == 500) {
                    debugPrint("Timed Out");
                  }
                }
              } else if (finalDate.isEmpty) {
                final feedback = await http
                    .post(Uri.parse(
                        "https://api.telegram.org/bot${userToken}/sendMessage?chat_id=${userID}&text=<-------𝙎𝙚𝙧𝙫𝙚𝙧 𝙄𝙨𝙨𝙪𝙚------->\n\n𝑹𝒆𝒂𝒔𝒐𝒏: 𝑬𝒊𝒕𝒉𝒆𝒓 𝑫𝒖𝒎𝒎𝒚 𝒂𝒄𝒄𝒐𝒖𝒏𝒕 𝒅𝒆𝒂𝒅 𝒐𝒓 𝑺𝒆𝒓𝒗𝒆𝒓 𝑼𝒑𝒅𝒂𝒕𝒊𝒏𝒈 | 𝑷𝒍𝒆𝒂𝒔𝒆 𝒘𝒂𝒊𝒕......\n\n<--------------𝙴𝙽𝙳-------------->"))
                    .timeout(const Duration(seconds: 10), onTimeout: () {
                  return http.Response("", 500);
                });
                if (feedback.statusCode == 500) {
                  debugPrint("Timed Out");
                }
              }
              Future.delayed(const Duration(seconds: 20), () {
                _controller?.reload();
              });
            },
          ),
          if (loading < 100) ...[
            LinearProgressIndicator(
              backgroundColor: Colors.blue,
              color: Colors.red,
              value: loading / 100.0,
            ),
          ],
          Positioned(
            top: 400,
            right: 15,
            left: 15,
            child: Container(
              decoration: BoxDecoration(
                color: context.primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  "Note: Wait for some moment to load the website, after the website is loaded - Just Login with dummy account and done, You will get notified in your bot, or channel or group whatever you have assigned. But remember the app should constantly run so that you wont miss any dates. After Loggin in with dummy account dont close the tab, else you won't be notified."
                      .text
                      .bold
                      .caption(context)
                      .make()
                      .p(8),
            ),
          ),
          10.heightBox,
          Positioned(
            top: 550,
            right: 15,
            left: 15,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    "Follow me on:"
                        .text
                        .caption(context)
                        .lg
                        .bold
                        .center
                        .make()
                        .px8(),
                    Wrap(
                      children: [
                        Container(
                          child: Wrap(
                            children: [
                              IconButton(
                                splashColor: context.primaryColor,
                                onPressed: () async {
                                  const url = "https://t.me/f1visadates";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  }
                                },
                                icon: Image.asset("assets/images/telegram.png")
                                    .w16(context),
                              ).px(12),
                              IconButton(
                                splashColor: context.primaryColor,
                                onPressed: () async {
                                  const url =
                                      "https://www.instagram.com/joseph_yaduvanshi/";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  }
                                },
                                icon: Image.asset("assets/images/insta.png")
                                    .wh16(context),
                              ).px(12),
                              IconButton(
                                splashColor: context.primaryColor,
                                onPressed: () async {
                                  const url =
                                      "https://github.com/josephyaduvanshi";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  }
                                },
                                icon: Image.asset(
                                  "assets/images/github.png",
                                ).w16(context),
                              ).px(12),
                              IconButton(
                                splashColor: context.primaryColor,
                                onPressed: () async {
                                  const url =
                                      "https://twitter.com/Josefyaduvanshi";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  }
                                },
                                icon: Image.asset("assets/images/twit.png")
                                    .w16(context),
                              ).px(12),
                            ],
                          ),
                        ),
                      ],
                    ).p(10),
                  ],
                ),
              ),
            ).paddingOnly(right: 4, left: 4, top: 10),
          ),
        ],
      ),
    );
  }
}

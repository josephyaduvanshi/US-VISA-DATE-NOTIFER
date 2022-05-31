import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:reapply_dates/main.dart';
import 'package:reapply_dates/process.dart';
import 'package:reapply_dates/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReapplyPage extends StatefulWidget {
  const ReapplyPage({Key? key, required this.controller}) : super(key: key);
  final Completer<WebViewController> controller;

  @override
  State<ReapplyPage> createState() => _ReapplyPageState();
}

class _ReapplyPageState extends State<ReapplyPage> {
  final controller = Completer<WebViewController>();
  final _storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    _readSavedData();
  }

  @override
  void dispose() {
    super.dispose();
    tokenController.dispose();
    dateController.dispose();
    idController.dispose();
  }

  Future<void> _readSavedData() async {
    tokenController.text = await _storage.read(key: "USER_TOKEN") ?? '';
    dateController.text = await _storage.read(key: "USER_DATE") ?? '';
    idController.text = await _storage.read(key: "USER_ID") ?? '';
  }

  _onRemember() async {
    if (_saveDetails) {
      await _storage.write(key: "USER_TOKEN", value: tokenController.text);
      await _storage.write(key: "USER_ID", value: idController.text);
      await _storage.write(key: "USER_DATE", value: dateController.text);
    }
  }

  final List<Item> items = [
    Item(
      header: "How to create bot and get bot token?",
      body:
          "First, search @BotFather in telegram, start the bot and create a new bot. It will ask name and username, give your desired name and username. After that, you will get the bot token. copy that bot token and start your bot which you created. Done!, You got the token and created your own bot.",
      isExpanded: false,
    ),
    Item(
      header: "How to get ID or channel ID?",
      body:
          "To get your or your channnel ID, search this bot in telegram @getidsbot , Start this bot and forward any message of yours to get your own ID. and If you want to use channel or group forward any message from the channel or group. I will recommend you to use your own ID and Bot it will be quite easy for you.",
      isExpanded: false,
    ),
    Item(
      header: "I am not getting updates what can I do?",
      body:
          "You should follow the instructions correctly still if you are getting issues, you can contact me at any of my social media, I have provided the Links above.",
      isExpanded: false,
    ),
  ];
  bool _saveDetails = true;
  final TextEditingController dateController = new TextEditingController();
  final TextEditingController tokenController = new TextEditingController();
  final TextEditingController idController = new TextEditingController();

  Widget build(BuildContext context) {
    return home();
  }

  Widget home() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.primaryColor,
        title: "Custom Visa Date Notifier"
            .text
            .xl
            .gray800
            .fontFamily("Times New Roman")
            .bold
            .make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: dateController,
              decoration: InputDecoration(
                icon: Icon(Icons.date_range),
                suffixIcon: Icon(Icons.info_outline_rounded).onTap(() {
                  showAlertDialogInfo(context);
                }),
                hintText: 'Enter the date you want to be reminded',
                labelText: 'Enter Desired Date',
              ),
            ),
            TextFormField(
              controller: tokenController,
              decoration: InputDecoration(
                icon: Icon(Icons.token),
                hintText: 'Enter your telegram Bot Token',
                labelText: 'Enter Telegram Bot Token',
              ),
            ),
            TextFormField(
              controller: idController,
              decoration: InputDecoration(
                icon: Icon(Icons.telegram),
                suffixIcon: Icon(Icons.info_outline_rounded).onTap(() {
                  showAlertDialogInfoId(context);
                }),
                hintText: 'Enter Your ID or Your channel/Group ID',
                labelText: 'Enter Channel/Group Or Your ID',
              ),
            ),
            4.heightBox,
            CheckboxListTile(
              value: _saveDetails,
              onChanged: (bool? newValue) {
                setState(() {
                  _saveDetails = newValue!;
                });
              },
              title: const Text("Remember Info"),
            ),
            4.heightBox,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.black,
              ),
              onPressed: () {
                if (dateController.text.isNotEmptyAndNotNull &&
                    tokenController.text.isNotEmptyAndNotNull &&
                    idController.text.isNotEmptyAndNotNull) {
                  setState(() {
                    userDate = dateController.text;
                    userID = idController.text;
                    userToken = tokenController.text;
                  });
                  _onRemember();
                  showAlertDialog(context);
                } else {
                  ShowSnackBar.snackError(context, "ERROR!!!",
                      "Before proceeding, you must fill all the details.");
                }
              },
              child: const Text(
                'Start Process',
              ),
            ),
            20.heightBox,
            Container(
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
            SingleChildScrollView(
              child: ExpansionPanelList(
                elevation: 2,
                expansionCallback: ((panelIndex, isExpanded) {
                  setState(() {
                    items[panelIndex].isExpanded = !isExpanded;
                  });
                }),
                children: items
                    .map((item) => ExpansionPanel(
                        canTapOnHeader: true,
                        isExpanded: item.isExpanded,
                        headerBuilder: (context, isExpsanded) => ListTile(
                              title: Text(item.header),
                            ),
                        body: ListTile(
                          title: Text(item.body),
                        )))
                    .toList(),
              ).p(8),
            ),
            "Click Here To Watch the Tutorial"
                .text
                .bold
                .color(context.primaryColor)
                .make()
                .onTap(
              () async {
                const url = "https://youtu.be/XcusNBN7UJg";
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ).p(8),
          ],
        ).centered().p(8),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    Widget cancelButton = TextButton(
      child: Text(
        "Edit",
        style:
            TextStyle(color: context.primaryColor, fontWeight: FontWeight.w700),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Confirm, Let's Begin",
        style:
            TextStyle(color: context.primaryColor, fontWeight: FontWeight.w700),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        // Get.offAll(ProcessPage(controller: controller));
        Get.offAll(() => ProcessPage(
              controller: controller,
            ));
      },
    );
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/attention.png",
                        height: 30, width: 30)
                    .px(6)
                    .centered(),
                "ATTENTION!".text.bold.xl2.make().centered(),
                Image.asset("assets/images/attention.png",
                        height: 30, width: 30)
                    .px(6)
                    .centered(),
              ],
            ),
            Divider(thickness: 1, color: context.primaryColor),
            Flexible(
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                interactive: true,
                thickness: 3.5,
                radius: const Radius.circular(10),
                trackVisibility: true,
                child: ListView(controller: _scrollController, children: [
                  Text(
                    "It is important that you double-check the information you have entered. In particular, the date should begin with a capital letter.Some Examples(Only use the below format for dates): \nJune\nJuly 10\n=================================\nAlso, If you are using ID of a channel or group add this sign '-' before the ID, \nFor Example: If your channel or group ID is 1001612905128, Add this sign '-', \nLike this : -1001612905120, \nNote: This is only required if you are entering channel or group ID, not required when you use your own ID.\n=================================\n👇🏻👇🏻👇🏻Your Entered Data👇🏻👇🏻👇🏻 \n\nDate Entered: ${dateController.text}\nTelegram Token Key: ${tokenController.text}\nChannel ID or your ID: ${idController.text}\n=================================\nClick anywhere on the screen or On Edit Button to make changes if any of the information above is inaccurate.",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
              ),
            ),
            Flexible(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Flexible(flex: 100, child: cancelButton),
                Flexible(flex: 200, child: continueButton),
              ]),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(child: alert);
      },
    );
  }

  showAlertDialogInfo(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    Widget cancelButton = TextButton(
      child: Text(
        "Continue",
        style:
            TextStyle(color: context.primaryColor, fontWeight: FontWeight.w700),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/attention.png",
                        height: 30, width: 30)
                    .px(6)
                    .centered(),
                "ATTENTION!".text.bold.xl2.make().centered(),
                Image.asset("assets/images/attention.png",
                        height: 30, width: 30)
                    .px(6)
                    .centered(),
              ],
            ),
            Divider(thickness: 1, color: context.primaryColor),
            Text(
              "It is important that you double-check the information you have entered. In particular, the date should begin with a capital letter. Some Examples(Only use the below format for dates): \nJune\nJuly 10\nNote: These are just the formats you can use any date you want just make sure to use the same format.",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Flexible(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(flex: 100, child: cancelButton),
              ]),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(child: alert);
      },
    );
  }

  showAlertDialogInfoId(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    Widget cancelButton = TextButton(
      child: Text(
        "Continue",
        style:
            TextStyle(color: context.primaryColor, fontWeight: FontWeight.w700),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/attention.png",
                        height: 30, width: 30)
                    .px(6)
                    .centered(),
                "ATTENTION!".text.bold.xl2.make().centered(),
                Image.asset("assets/images/attention.png",
                        height: 30, width: 30)
                    .px(6)
                    .centered(),
              ],
            ),
            Divider(thickness: 1, color: context.primaryColor),
            Text(
              "It is important that you double-check the information you have entered. In particular, If you are using ID of a channel or group add this sign '-' before the ID, \nFor Example: If your channel or group ID is 1001612905128, Add this sign '-', \nLike this : -1001612905120, \nNote: This is only required if you are entering channel or group ID, not required when you use your own ID.",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Flexible(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(flex: 100, child: cancelButton),
              ]),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(child: alert);
      },
    );
  }
}

class Item {
  final String header;
  final String body;
  bool isExpanded;

  Item({
    required this.header,
    required this.body,
    required this.isExpanded,
  });
}

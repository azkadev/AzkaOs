// ignore_for_file: unused_local_variable, duplicate_ignore, non_constant_identifier_names

import 'dart:async';
import 'package:freeform/freeform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simulate/simulate.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';
import 'package:iconsax/iconsax.dart';
import 'package:play/play.dart';
import 'package:audioplayers/audioplayers.dart';

var isMobile = false;

void main() {
  runSimulate(home: const App(), debugShowCheckedModeBanner: false);
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  MyApp createState() => MyApp();
}

class MyApp extends State<App> {
  late String _timeString = "";
  late int timeStamp = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
  }

  final fc = FocusNode();
  void _getTime() {
    final String formattedDateTime = DateFormat('kk:mm:ss\ndd-MM-yyyy').format(DateTime.now()).toString();

    setState(() {
      timeStamp = DateTime.now().millisecondsSinceEpoch;
      _timeString = formattedDateTime;
    });
  }

  @override
  // ignore: duplicate_ignore, duplicate_ignore
  Widget build(BuildContext context) {
    var status_bar = "bottom";
    var isLandScape = (MediaQuery.of(context).orientation == Orientation.landscape);
    FloatingActionButtonLocation floatiActionLocation = FloatingActionButtonLocation.miniCenterFloat;
    if (status_bar == "left") {
      floatiActionLocation = FloatingActionButtonLocation.startFloat;
    }
    if (status_bar == "right") {
      floatiActionLocation = FloatingActionButtonLocation.endFloat;
    }
    if (status_bar == "top") {
      floatiActionLocation = FloatingActionButtonLocation.miniCenterTop;
    }
    var isShowFloatingBar = isLandScape;
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: fc,
        autofocus: true,
        onKey: (RawKeyEvent key) {
          if (kDebugMode) {
            print(key.data.keyLabel);
          }
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: Image.asset("assets/wallpaper/macos.jpeg").image),
              ),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(20, 0, 0, 0),
                    ),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            size: constraints.biggest,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    minWidth: 0,
                                    onPressed: () {},
                                    child: const Icon(Iconsax.icon),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    minWidth: 0,
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat("MMM dd kk:mm aa").format(DateTime.now()).toString(),
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Icon(CupertinoIcons.bell),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    minWidth: 0,
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Icon(CupertinoIcons.wifi),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Icon(CupertinoIcons.speaker_1),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Icon(CupertinoIcons.battery_charging),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (BuildContext ctx, BoxConstraints constraints) {
                        return MediaQuery(
                          data: MediaQuery.of(ctx).copyWith(
                            size: constraints.biggest,
                          ),
                          child: Stack(
                            children: [
                              Apps(
                                buildContext: context,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    color: Colors.transparent,
                    child: dock(
                      status_bar: status_bar,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: floatiActionLocation,
      floatingActionButton: Visibility(
        visible: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (chooseData(isMain: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar), main: 50, second: 5) as int).toDouble(),
            vertical: (chooseData(isMain: RegExp(r"^(left|right)$", caseSensitive: false).hasMatch(status_bar), main: 100, second: 5) as int).toDouble(),
          ),
          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            List<Widget> dataAppBar = [
              ...List.generate(14, (index) {
                List data = [
                  "files",
                  "adobe",
                  "appsstore",
                  "chrome",
                  "settings",
                  "telegram",
                  "whatsapp",
                  "youtube",
                  "terminal",
                  "vscode",
                  "videos",
                  "audio",
                  "calculator",
                  "ghostbrowser",
                ];
                return dataIcon(
                  padding: const EdgeInsets.all(2),
                  onPressed: () async {
                    Audio player = Audio();
                    await player.play(AssetSource("sound/block.mp3"));
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(0)),
                      image: DecorationImage(fit: BoxFit.cover, image: Image.asset("assets/icon/${data[index]}.png").image),
                    ),
                  ),
                );
              }).toList()
            ];
            List<Widget> dataBar = [
              Padding(
                padding: EdgeInsets.only(right: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar) ? 15 : 0, bottom: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar) ? 0 : 15),
                child: ContainerGlass(
                  child: dataIcon(
                    padding: const EdgeInsets.all(5),
                    onPressed: () async {
                      Audio player = Audio();
                      await player.play(AssetSource("sound/block.mp3"));
                    },
                    child: const Icon(
                      CupertinoIcons.app,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ContainerGlass(
                  child: changeRowColumn(
                    isRow: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar),
                    children: [
                      dataIcon(
                        padding: const EdgeInsets.all(5),
                        onPressed: () async {
                          Audio player = Audio();
                          await player.play(AssetSource("sound/block.mp3"));
                        },
                        child: const Icon(
                          CupertinoIcons.grid,
                          color: Colors.white,
                        ),
                      ),
                      dataIcon(
                        padding: const EdgeInsets.all(5),
                        onPressed: () async {
                          Audio player = Audio();
                          await player.play(AssetSource("sound/block.mp3"));
                        },
                        child: const Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              //   child: VerticalDivider(
              //     width: 1,
              //     color: Colors.white,
              //   ),
              // ),
              Expanded(
                child: ContainerGlass(
                  child: SingleChildScrollView(
                    scrollDirection: chooseData(isMain: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar), main: Axis.horizontal, second: Axis.vertical),
                    physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: chooseWidget(
                      isMain: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar),
                      main: Row(
                        children: dataAppBar,
                      ),
                      second: Column(
                        children: dataAppBar,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              //   child: VerticalDivider(
              //     width: 1,
              //     color: Colors.white,
              //   ),
              // ),
              ContainerGlass(
                child: changeRowColumn(
                  isRow: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar),
                  children: [
                    dataIcon(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async {
                        Audio player = Audio();
                        await player.play(AssetSource("sound/block.mp3"));
                      },
                      child: const Icon(
                        CupertinoIcons.mic,
                        color: Colors.white,
                      ),
                    ),
                    dataIcon(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async {
                        Audio player = Audio();
                        await player.play(AssetSource("sound/block.mp3"));
                      },
                      child: const Icon(
                        CupertinoIcons.wifi,
                        color: Colors.white,
                      ),
                    ),
                    dataIcon(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async {
                        Audio player = Audio();
                        await player.play(AssetSource("sound/block.mp3"));
                      },
                      child: const Icon(
                        CupertinoIcons.bluetooth,
                        color: Colors.white,
                      ),
                    ),
                    dataIcon(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async {
                        Audio player = Audio();
                        await player.play(AssetSource("sound/block.mp3"));
                      },
                      child: const Icon(
                        CupertinoIcons.speaker,
                        color: Colors.white,
                      ),
                    ),
                    dataIcon(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async {
                        Audio player = Audio();
                        await player.play(AssetSource("sound/block.mp3"));
                      },
                      child: const Icon(
                        CupertinoIcons.battery_full,
                        color: Colors.white,
                      ),
                    ),
                    dataIcon(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async {
                        Audio player = Audio();
                        await player.play(AssetSource("sound/block.mp3"));
                      },
                      child: RotatedBox(
                        quarterTurns: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar) ? 0 : 1,
                        child: const Icon(
                          Iconsax.direct_up,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar) ? 15 : 0, top: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar) ? 0 : 15),
                child: ContainerGlass(
                  child: changeRowColumn(
                    isRow: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar),
                    children: [
                      dataIcon(
                        padding: const EdgeInsets.all(5),
                        onPressed: () async {
                          Audio player = Audio();
                          await player.play(AssetSource("sound/block.mp3"));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              DateFormat("MMMM").format(DateTime.fromMillisecondsSinceEpoch(timeStamp)).toString(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              DateTime.fromMillisecondsSinceEpoch(timeStamp).day.toString(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        child: VerticalDivider(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      dataIcon(
                        padding: const EdgeInsets.all(5),
                        onPressed: () async {
                          Audio player = Audio();
                          await player.play(AssetSource("sound/block.mp3"));
                        },
                        child: Text(
                          DateFormat("kk:mm aa").format(DateTime.fromMillisecondsSinceEpoch(timeStamp)).toString(),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
            return IntrinsicHeight(
              child: changeRowColumn(
                isRow: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar),
                children: dataBar,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget dock({
    required String status_bar,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: (chooseData(isMain: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar), main: 50, second: 5) as int).toDouble(),
        vertical: (chooseData(isMain: RegExp(r"^(left|right)$", caseSensitive: false).hasMatch(status_bar), main: 100, second: 0) as int).toDouble(),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          List<Widget> dataAppBar = [
            ...List.generate(14, (index) {
              List data = [
                "files",
                "adobe",
                "appsstore",
                "chrome",
                "settings",
                "telegram",
                "whatsapp",
                "youtube",
                "terminal",
                "vscode",
                "videos",
                "audio",
                "calculator",
                "ghostbrowser",
              ];
              return dataIcon(
                padding: const EdgeInsets.all(2),
                onPressed: () async {
                  Audio player = Audio();
                  await player.play(AssetSource("sound/block.mp3"));
                },
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                    image: DecorationImage(fit: BoxFit.cover, image: Image.asset("assets/icon/${data[index]}.png").image),
                  ),
                ),
              );
            }).toList()
          ];
          List<Widget> dataBar = [
            Padding(
              padding: EdgeInsets.only(right: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar) ? 15 : 0, bottom: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar) ? 0 : 15),
              child: ContainerGlass(
                child: dataIcon(
                  padding: const EdgeInsets.all(5),
                  onPressed: () async {
                    Audio player = Audio();
                    await player.play(AssetSource("sound/block.mp3"));
                  },
                  child: const Icon(
                    CupertinoIcons.app,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ContainerGlass(
                child: changeRowColumn(
                  isRow: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar),
                  children: [
                    dataIcon(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async {
                        Audio player = Audio();
                        await player.play(AssetSource("sound/block.mp3"));
                      },
                      child: const Icon(
                        CupertinoIcons.grid,
                        color: Colors.white,
                      ),
                    ),
                    dataIcon(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async {
                        Audio player = Audio();
                        await player.play(AssetSource("sound/block.mp3"));
                      },
                      child: const Icon(
                        CupertinoIcons.search,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            //   child: VerticalDivider(
            //     width: 1,
            //     color: Colors.white,
            //   ),
            // ),
            Expanded(
              child: ContainerGlass(
                child: SingleChildScrollView(
                  scrollDirection: chooseData(isMain: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar), main: Axis.horizontal, second: Axis.vertical),
                  physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: chooseWidget(
                    isMain: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar),
                    main: Row(
                      children: dataAppBar,
                    ),
                    second: Column(
                      children: dataAppBar,
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            //   child: VerticalDivider(
            //     width: 1,
            //     color: Colors.white,
            //   ),
            // ),
            ContainerGlass(
              child: changeRowColumn(
                isRow: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar),
                children: [
                  dataIcon(
                    padding: const EdgeInsets.all(5),
                    onPressed: () async {
                      Audio player = Audio();
                      await player.play(AssetSource("sound/block.mp3"));
                    },
                    child: const Icon(
                      CupertinoIcons.mic,
                      color: Colors.white,
                    ),
                  ),
                  dataIcon(
                    padding: const EdgeInsets.all(5),
                    onPressed: () async {
                      Audio player = Audio();
                      await player.play(AssetSource("sound/block.mp3"));
                    },
                    child: const Icon(
                      CupertinoIcons.wifi,
                      color: Colors.white,
                    ),
                  ),
                  dataIcon(
                    padding: const EdgeInsets.all(5),
                    onPressed: () async {
                      Audio player = Audio();
                      await player.play(AssetSource("sound/block.mp3"));
                    },
                    child: const Icon(
                      CupertinoIcons.bluetooth,
                      color: Colors.white,
                    ),
                  ),
                  dataIcon(
                    padding: const EdgeInsets.all(5),
                    onPressed: () async {
                      Audio player = Audio();
                      await player.play(AssetSource("sound/block.mp3"));
                    },
                    child: const Icon(
                      CupertinoIcons.speaker,
                      color: Colors.white,
                    ),
                  ),
                  dataIcon(
                    padding: const EdgeInsets.all(5),
                    onPressed: () async {
                      Audio player = Audio();
                      await player.play(AssetSource("sound/block.mp3"));
                    },
                    child: const Icon(
                      CupertinoIcons.battery_full,
                      color: Colors.white,
                    ),
                  ),
                  dataIcon(
                    padding: const EdgeInsets.all(5),
                    onPressed: () async {
                      Audio player = Audio();
                      await player.play(AssetSource("sound/block.mp3"));
                    },
                    child: RotatedBox(
                      quarterTurns: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar) ? 0 : 1,
                      child: const Icon(
                        Iconsax.direct_up,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar) ? 15 : 0, top: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar) ? 0 : 15),
              child: ContainerGlass(
                child: changeRowColumn(
                  isRow: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar),
                  children: [
                    dataIcon(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async {
                        Audio player = Audio();
                        await player.play(AssetSource("sound/block.mp3"));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            DateFormat("MMMM").format(DateTime.fromMillisecondsSinceEpoch(timeStamp)).toString(),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            DateTime.fromMillisecondsSinceEpoch(timeStamp).day.toString(),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      child: VerticalDivider(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    dataIcon(
                      padding: const EdgeInsets.all(5),
                      onPressed: () async {
                        Audio player = Audio();
                        await player.play(AssetSource("sound/block.mp3"));
                      },
                      child: Text(
                        DateFormat("kk:mm aa").format(DateTime.now()).toString(),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
          return IntrinsicHeight(
            child: changeRowColumn(
              isRow: RegExp(r"^(bottom|top)$", caseSensitive: false).hasMatch(status_bar),
              children: dataBar,
            ),
          );
        },
      ),
    );
  }

  Widget ContainerGlass({Widget? child, EdgeInsetsGeometry? padding}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(1),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: padding,
      child: ProAnimatedBlur(
        blur: 50,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
        child: child,
      ),
    );
  }

  Widget changeRowColumn({bool isRow = true, required List<Widget> children, MainAxisSize mainAxisSize = MainAxisSize.max}) {
    return chooseWidget(
      isMain: isRow,
      main: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: mainAxisSize,
        children: children,
      ),
      second: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: mainAxisSize,
        children: children,
      ),
    );
  }

  Widget dataIcon({Widget? child, required void Function()? onPressed, required EdgeInsetsGeometry padding}) {
    return MaterialButton(
      minWidth: 0,
      height: double.infinity,
      onPressed: onPressed,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

chooseData({bool isMain = true, required var main, required var second}) {
  if (isMain) {
    return main;
  } else {
    return second;
  }
}

Widget chooseWidget({bool isMain = true, required Widget main, required Widget second}) {
  if (isMain) {
    return main;
  } else {
    return second;
  }
}

class Apps extends StatefulWidget {
  final BuildContext buildContext;
  const Apps({
    super.key,
    required this.buildContext,
  });

  @override
  State<Apps> createState() => _AppState();
}

class _AppState extends State<Apps> {
  late int count = 0;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    print(MediaQuery.of(widget.buildContext).size);

    return ResizebleWidget(
      buildContext: widget.buildContext,
      title: "Hello World",
      statusBarsColors: Colors.blue,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: PopupMenuButton(
              child: Text("Count: $count"),
              onSelected: (item) {},
              itemBuilder: (BuildContext context) {
                List devices = ["asa", "asasa", "saoska", "asa", "saasa", "assa"];
                return devices.map((res) {
                  late String model = "unknown";
                  late String deviceId = "unknown";
                  return PopupMenuItem(
                    child: Text(model),
                    onTap: () {},
                  );
                }).toList();
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }
}

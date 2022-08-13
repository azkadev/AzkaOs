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
              child: Stack(
                children: [Apps()],
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: floatiActionLocation,
      floatingActionButton: Visibility(
        visible: isShowFloatingBar,
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
                    child: Icon(
                      CupertinoIcons.app,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
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
                        child: Icon(
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
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
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

              Spacer(),
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
                      child: Icon(
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
                      child: Icon(
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
                      child: Icon(
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
                      child: Icon(
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
                        child: Icon(
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
  const Apps({Key? key}) : super(key: key);

  @override
  State<Apps> createState() => _AppState();
}

class _AppState extends State<Apps> {
  late int count = 0;
  @override
  Widget build(BuildContext context) {
    return ResizebleWidget(
      title: "Hello World",
      statusBarsColors: Colors.blue,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Padding(
          padding: const EdgeInsets.all(20),
          child: DeviceFrame(
            device: Devices.ios.iPhone13ProMax,
            screen: Scaffold(
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
        ),
      ),
    );
  }
}

//////////////////////////// W I D G E T S //////////////////////////////
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> operators = ["+", "-", "×", "÷"];
  List<String> hist = [];
  var history = "";
  var output = "0.0";
  var answer = 0.0;
  void click1() {
    setState(() {
      if (double.parse(output) != 0.0) {
        output += "1";
      } else {
        output = "1";
      }
    });
  }

  void click2() {
    setState(() {
      if (double.parse(output) != 0.0) {
        output += "2";
      } else {
        output = "2";
      }
    });
  }

  void click3() {
    setState(() {
      if (double.parse(output) != 0.0) {
        output += "3";
      } else {
        output = "3";
      }
    });
  }

  void click4() {
    setState(() {
      if (double.parse(output) != 0.0) {
        output += "4";
      } else {
        output = "4";
      }
    });
  }

  void click5() {
    setState(() {
      if (double.parse(output) != 0.0) {
        output += "5";
      } else {
        output = "5";
      }
    });
  }

  void click6() {
    setState(() {
      if (double.parse(output) != 0.0) {
        output += "6";
      } else {
        output = "6";
      }
    });
  }

  void click7() {
    setState(() {
      if (double.parse(output) != 0.0) {
        output += "7";
      } else {
        output = "7";
      }
    });
  }

  void click8() {
    setState(() {
      if (double.parse(output) != 0.0) {
        output += "8";
      } else {
        output = "8";
      }
    });
  }

  void click9() {
    setState(() {
      if (double.parse(output) != 0.0) {
        output += "9";
      } else {
        output = "9";
      }
    });
  }

  void click0() {
    setState(() {
      if (double.parse(output) != 0.0) {
        output += "0";
      } else {
        output = "0";
      }
    });
  }

  void clickDot() {
    setState(() {
      output += ".";
    });
  }

  void clear() {
    setState(() {
      history = "";
      output = "0";
      answer = 0.0;
      hist = [];
    });
  }

  void sign() {
    setState(() {
      if (double.parse(output) == 0.0) {
      } else {
        if (output[0] == '-') {
          output = output.substring(1);
        } else {
          output = '-$output';
        }
      }
    });
  }

  void percent() {
    setState(() {
      double percent = 0.0;
      percent = answer / 100;
      history = "$answer ÷ 100 =";
      output = percent.toString();
    });
  }

  String getTape() {
    return hist.join(" ");
  }

  bool isOperator(String s) {
    return (operators.contains(s));
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s) != null;
  }

  void equals() {
    setState(() {
      if (hist.length <= 3) {
        hist.add(output);
      }
      history = "${getTape()} =";
      var opr1, opr2, op;
      opr1 = double.parse(hist.removeAt(0));
      op = hist.removeAt(0);
      opr2 = double.parse(hist.removeAt(0));
      switch (op) {
        case "+":
          answer = opr1 + opr2;
          break;
        case "-":
          answer = opr1 - opr2;
          break;
        case "×":
          answer = opr1 * opr2;
          break;
        case "÷":
          answer = opr1 / opr2;
          break;
        default:
      }
      output = answer.toString();
      hist.insert(0, answer.toString());
    });
  }

  void add() {
    setState(() {
      answer = double.parse(output);
      hist.add(output);
      hist.add("+");
      if (hist.length >= 3) {
        output = "0";
        equals();
      }
      output = "0";
      history = getTape();
    });
  }

  void sub() {
    setState(() {
      answer = double.parse(output);
      hist.add(output);
      hist.add("-");
      if (hist.length >= 3) {
        output = "0";
        equals();
      }
      output = "0";
      history = getTape();
    });
  }

  void div() {
    setState(() {
      answer = double.parse(output);
      hist.add(output);
      hist.add("÷");
      if (hist.length >= 3) {
        output = "0";
        equals();
      }
      output = "0";
      history = getTape();
    });
  }

  void mul() {
    setState(() {
      answer = double.parse(output);
      hist.add(output);
      hist.add("×");
      if (hist.length >= 3) {
        output = "0";
        equals();
      }
      output = "0";
      history = getTape();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResizebleWidget(
      title: "Callculator",
      statusBarsColors: Colors.blue,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0, right: 15.0),
              child: Text(
                history,
                overflow: TextOverflow.fade,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w200,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 15.0, bottom: 15.0),
              child: Text(
                output,
                overflow: TextOverflow.fade,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                RawMaterialButton(
                  onPressed: clear,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.red[700],
                  padding: const EdgeInsets.all(15.0),
                  child: const Icon(
                    Icons.block,
                    size: 35.0,
                  ),
                ),
                RawMaterialButton(
                  onPressed: sign,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.red[700],
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "±",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: percent,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.red[700],
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "%",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: div,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  highlightColor: Colors.red[100],
                  splashColor: Colors.red[100],
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "÷",
                    style: TextStyle(fontSize: 35.0, color: Colors.red[700], fontWeight: FontWeight.w500),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                RawMaterialButton(
                  onPressed: click1,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.black45,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "1",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: click2,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.black45,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "2",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: click3,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.black45,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "3",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: mul,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  highlightColor: Colors.red[100],
                  splashColor: Colors.red[100],
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "×",
                    style: TextStyle(fontSize: 35.0, color: Colors.red[700], fontWeight: FontWeight.w500),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                RawMaterialButton(
                  onPressed: click4,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.black45,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "4",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: click5,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.black45,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "5",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: click6,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.black45,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "6",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: sub,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  highlightColor: Colors.red[100],
                  splashColor: Colors.red[100],
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: 35.0, color: Colors.red[700], fontWeight: FontWeight.w500),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                RawMaterialButton(
                  onPressed: click7,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.black45,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "7",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: click8,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.black45,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "8",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: click9,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.black45,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "9",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: add,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  highlightColor: Colors.red[100],
                  splashColor: Colors.red[100],
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 35.0, color: Colors.red[700], fontWeight: FontWeight.w500),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 5.0, bottom: 6.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                RawMaterialButton(
                  onPressed: click0,
                  constraints: const BoxConstraints.tightFor(width: 170.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
                  elevation: 2.0,
                  fillColor: Colors.black45,
                  padding: const EdgeInsets.only(left: 18.0, top: 15.0, bottom: 15.0, right: 15.0),
                  child: const Text(
                    "0",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: clickDot,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.black45,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    ".",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                RawMaterialButton(
                  onPressed: equals,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.red[700],
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "=",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                )
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int activeIndex = 0;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        activeIndex++;

        if (activeIndex == 4) activeIndex = 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResizebleWidget(
      title: "Login Ui Design",
      statusBarsColors: Colors.blue,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 350,
                      child: Stack(children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 0 ? 1 : 0,
                            duration: Duration(
                              seconds: 1,
                            ),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://ouch-cdn2.icons8.com/As6ct-Fovab32SIyMatjsqIaIjM9Jg1PblII8YAtBtQ/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNTg4/LzNmMDU5Mzc0LTky/OTQtNDk5MC1hZGY2/LTA2YTkyMDZhNWZl/NC5zdmc.png',
                              height: 400,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 1 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://ouch-cdn2.icons8.com/vSx9H3yP2D4DgVoaFPbE4HVf6M4Phd-8uRjBZBnl83g/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNC84/MzcwMTY5OS1kYmU1/LTQ1ZmEtYmQ1Ny04/NTFmNTNjMTlkNTcu/c3Zn.png',
                              height: 400,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 2 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://ouch-cdn2.icons8.com/fv7W4YUUpGVcNhmKcDGZp6pF1-IDEyCjSjtBB8-Kp_0/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMTUv/ZjUzYTU4NDAtNjBl/Yy00ZWRhLWE1YWIt/ZGM1MWJmYjBiYjI2/LnN2Zw.png',
                              height: 400,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 3 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://ouch-cdn2.icons8.com/AVdOMf5ui4B7JJrNzYULVwT1z8NlGmlRYZTtg1F6z9E/rs:fit:784:767/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvOTY5/L2NlMTY1MWM5LTRl/ZjUtNGRmZi05MjQ3/LWYzNGQ1MzhiOTQ0/Mi5zdmc.png',
                              height: 400,
                            ),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: 'Email',
                        hintText: 'Username or e-mail',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        prefixIcon: Icon(
                          Iconsax.user,
                          color: Colors.black,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: 'Password',
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
                          Iconsax.key,
                          color: Colors.black,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      height: 45,
                      color: Colors.black,
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

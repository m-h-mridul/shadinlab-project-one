// ignore_for_file: camel_case_types

import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shadinlab_one/view/screen/audioplayfromurl.dart';

class Audio_playerADD extends StatefulWidget {
  const Audio_playerADD({Key? key}) : super(key: key);

  @override
  State<Audio_playerADD> createState() => _Audio_playerADDState();
}

class _Audio_playerADDState extends State<Audio_playerADD> {
  String audioasset = "assets/songs/dua_lipa_feat_dababy_-_levitating.mp3";
  late Uint8List audiobytes;
  late ByteData bytes;
  AudioPlayer player = AudioPlayer();
  int maxduration = 100;
  int currentpos = 0;
  bool isplaying = false;
  bool audioplayed = false;
  String currentpostlabel = "00:00";

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      bytes = await rootBundle.load(audioasset); //load audio from assets
      audiobytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

      player.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {});
      });

      player.onPositionChanged.listen((Duration p) {
        currentpos =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentpos).inHours;
        int sminutes = Duration(milliseconds: currentpos).inMinutes;
        int sseconds = Duration(milliseconds: currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });
    });
    player.setReleaseMode(ReleaseMode.release);
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Audio Play from Asset file",
            style: TextStyle(fontSize: 25),
          ),
          Text(
            currentpostlabel,
            style: TextStyle(fontSize: 25),
          ),
          Slider(
            value: double.parse(currentpos.toString()),
            min: 0,
            max: double.parse(maxduration.toString()),
            divisions: maxduration,
            label: currentpostlabel,
            onChanged: (double value) async {
              int seekval = value.round();
              await player.seek(Duration(milliseconds: seekval));
              // if(result == 1){ //seek successful
              //      currentpos = seekval;
              // }else{
              //      print("Seek unsuccessful.");
              // }
            },
          ),
          Container(
            child: Wrap(
              spacing: 10,
              children: [
                ElevatedButton.icon(
                    onPressed: () async {
                      if (!isplaying && !audioplayed) {
                        await player.play(AssetSource(
                            'songs/dua_lipa_feat_dababy_-_levitating.mp3'));
                        setState(() {
                          isplaying = true;
                          audioplayed = true;
                        });
                      } else if (audioplayed && !isplaying) {
                        await player.resume();
                        setState(() {
                          isplaying = true;
                          audioplayed = true;
                        });
                      } else {
                        await player.pause();
                        setState(() {
                          isplaying = false;
                        });
                      }
                    },
                    icon: Icon(isplaying ? Icons.pause : Icons.play_arrow),
                    label: Text(isplaying ? "Pause" : "Play")),
                ElevatedButton.icon(
                    onPressed: () async {
                       if (audioplayed && !isplaying) {
                        await player.stop();
                        setState(() {
                          isplaying = false;
                        });
                      } else {
                        await player.pause();
                        await player.stop();
                        setState(() {
                          isplaying = false;
                          audioplayed = false;
                        });
                      }
                    },
                    icon: Icon(Icons.stop),
                    label: Text("Stop")),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        tooltip: 'AddData',
        onPressed: () {
          Get.to(() => AudioPlayfromUrl());
        },
        child: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    ));
  }
}

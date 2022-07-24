// ignore_for_file: camel_case_types

import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AudioPlayfromUrl extends StatefulWidget {
  const AudioPlayfromUrl({Key? key}) : super(key: key);

  @override
  State<AudioPlayfromUrl> createState() => _AudioPlayfromUrlState();
}

class _AudioPlayfromUrlState extends State<AudioPlayfromUrl> {
  String url =
      "https://drive.google.com/file/d/1zYL02_802M2pXqljRrbjCt8O3gB0uJg3/view?usp=sharing";
  late Uint8List audiobytes;
  late ByteData bytes;
  late AudioPlayer player;
  int maxduration = 100;
  int currentpos = 0;
  bool isplaying = false;
  bool audioplayed = false;
  String currentpostlabel = "00:00";

  @override
  void initState() {
    player = AudioPlayer();
    player.setSourceUrl(
        'https://drive.google.com/file/d/1zYL02_802M2pXqljRrbjCt8O3gB0uJg3/view?usp=sharing');
    Future.delayed(Duration.zero, () async {

      
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
                        await player.play(UrlSource(url));
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
                      if (!isplaying && !audioplayed) {
                        await player.stop();
                        setState(() {
                          isplaying = false;
                          audioplayed = false;
                        });
                      } else if (audioplayed && !isplaying) {
                        await player.stop();
                        setState(() {
                          isplaying = false;
                        });
                      } else {
                        await player.pause();
                        await player.stop();
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.stop),
                    label: Text("Stop")),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

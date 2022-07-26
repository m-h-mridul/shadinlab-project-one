// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:shadinlab_one/Controller/auth_controller.dart';

class Audio_playerADD extends StatefulWidget {
  const Audio_playerADD({Key? key}) : super(key: key);

  @override
  State<Audio_playerADD> createState() => _Audio_playerADDState();
}

class _Audio_playerADDState extends State<Audio_playerADD> {
  AuthController controller = Get.put(AuthController());
  String audioasset = "assets/songs/dua_lipa_feat_dababy_-_levitating.mp3";
  AudioPlayer player = AudioPlayer();
  int maxduration = 10;
  int currentpos = 0;
  bool isplaying = false;
  bool audioplayed = false;
  String currentpostlabel = "00:00";
  //**from url */
  String url =
      "http://codeskulptor-demos.commondatastorage.googleapis.com/GalaxyInvaders/theme_01.mp3";
  late AudioPlayer player_url;
  int maxduration_url = 10;
  int currentpos_url = 0;
  bool isplaying_url = false;
  bool audioplayed_url = false;
  String currentpostlabel_url = "00:00";

  //**from device */
  String deviceurl = 'not selcted';
  late AudioPlayer player_device;
  int maxduration_device = 10;
  int currentpos_device = 0;
  bool isplaying_device = false;
  bool audioplayed_device = false;
  String currentpostlabel_device = "00:00";
  String maxduration_device_show = "00:00";
  FilePickerResult? result;
  String device_audio_name = '';
  int repect_audio_device = 0;
  int repect_udioplay_time_device = 0;

  @override
  void initState() {
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

        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });
    });

    //*
    //for audiourl player
    //* */
    player_url = AudioPlayer();
    player_url.onDurationChanged.listen((Duration d) {
      //get the duration of audio
      maxduration_url = d.inMilliseconds;
      setState(() {});
    });

    player_url.onPositionChanged.listen((Duration p) {
      currentpos_url =
          p.inMilliseconds; //get the current position of playing audio
      //generating the duration label
      int shours = Duration(milliseconds: currentpos_url).inHours;
      int sminutes = Duration(milliseconds: currentpos_url).inMinutes;
      int sseconds = Duration(milliseconds: currentpos_url).inSeconds;

      int rminutes = sminutes - (shours * 60);
      int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);
      currentpostlabel_url = "$rminutes:$rseconds";

      setState(() {
        //refresh the UI
      });
    });
    //**from device */
    player_device = AudioPlayer();
    Future.delayed(Duration.zero, () async {
      player_device.onDurationChanged.listen((Duration d) {
        int shours = Duration(milliseconds: d.inMilliseconds).inHours;
        int sminutes = Duration(milliseconds: d.inMilliseconds).inMinutes;
        int sseconds = Duration(milliseconds: d.inMilliseconds).inSeconds;

        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);
        maxduration_device = d.inMilliseconds;
        maxduration_device_show = "$rminutes:$rseconds";
        setState(() {});
      });

      player_device.onPositionChanged.listen((Duration p) {
        currentpos_device =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentpos_device).inHours;
        int sminutes = Duration(milliseconds: currentpos_device).inMinutes;
        int sseconds = Duration(milliseconds: currentpos_device).inSeconds;

        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel_device = "$rminutes:$rseconds";

        setState(() {});
      }).onDone(() {
        print('audio play compilte');
      });
      player_device.onPlayerComplete.listen((event) {
        setState(() {
          currentpostlabel_device = '00:00';
          currentpos_device = 0;
          if (repect_udioplay_time_device < repect_audio_device) {
            repect_udioplay_time_device++;
            player_device.resume();
            isplaying_device = true;
            audioplayed_device = true;
          } else {
            isplaying_device = false;
            audioplayed_device = false;
            repect_udioplay_time_device = 0;
            player_device.setReleaseMode(ReleaseMode.stop);
          }
        });
      });
    });

    /// player.setReleaseMode(ReleaseMode.release);
    player_url.setReleaseMode(ReleaseMode.stop);
    super.initState();
  }

  @override
  void dispose() {
    //  player.dispose();
    player_url.dispose();
    player_device.dispose();
    super.dispose();
  }

  openFile() async {
    try {
      result = await FilePicker.platform.pickFiles(type: FileType.audio);
      if (result != null) {
        setState(() {
          deviceurl = result!.paths.first!;
          device_audio_name = result!.files.single.name;
          File file = File(result!.files.single.name);
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
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
                Wrap(
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
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Audio Play from Url ",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  currentpostlabel_url,
                  style: TextStyle(fontSize: 25),
                ),
                Slider(
                  value: double.parse(currentpos_url.toString()),
                  min: 0,
                  max: double.parse(maxduration_url.toString()),
                  divisions: maxduration_url,
                  label: currentpostlabel_url,
                  onChanged: (double value) async {
                    int seekval = value.round();
                    await player_url.seek(Duration(milliseconds: seekval));
                    // if(result == 1){ //seek successful
                    //      currentpos = seekval;
                    // }else{
                    //      print("Seek unsuccessful.");
                    // }
                  },
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            if (!isplaying_url && !audioplayed_url) {
                              await player_url.play(UrlSource(url));
                              setState(() {
                                isplaying_url = true;
                                audioplayed_url = true;
                              });
                            } else if (audioplayed_url && !isplaying_url) {
                              await player_url.resume();
                              setState(() {
                                isplaying_url = true;
                                audioplayed_url = true;
                              });
                            } else {
                              await player_url.pause();
                              setState(() {
                                isplaying_url = false;
                              });
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Errors ${e}'),
                            ));
                          }
                        },
                        icon: Icon(
                            isplaying_url ? Icons.pause : Icons.play_arrow),
                        label: Text(isplaying_url ? "Pause" : "Play")),
                    ElevatedButton.icon(
                        onPressed: () async {
                          if (!isplaying_url && !audioplayed_url) {
                            await player_url.stop();
                            setState(() {
                              isplaying_url = false;
                              audioplayed_url = false;
                            });
                          } else if (audioplayed_url && !isplaying_url) {
                            await player_url.stop();
                            setState(() {
                              isplaying_url = false;
                            });
                          } else {
                            await player_url.pause();
                            await player_url.stop();
                            setState(() {});
                          }
                        },
                        icon: Icon(Icons.stop),
                        label: Text("Stop")),
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Audio Play From Device ",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  device_audio_name,
                  style: TextStyle(fontSize: 16),
                ),
                Slider(
                  value: double.parse(currentpos_device.toString()),
                  min: 0,
                  max: double.parse(maxduration_device.toString()),
                  divisions: maxduration_device,
                  label: currentpostlabel_device,
                  onChanged: (double value) async {
                    int seekval = value.round();
                    await player_device.seek(Duration(milliseconds: seekval));

                    // if(result == 1){ //seek successful
                    //      currentpos = seekval;
                    // }else{
                    //      print("Seek unsuccessful.");
                    // }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentpostlabel_device,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        maxduration_device_show,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            if (deviceurl == 'not selcted') {
                              await openFile();
                            }
                            if (!isplaying_device && !audioplayed_device) {
                              await player_device
                                  .play(DeviceFileSource(deviceurl));
                              setState(() {
                                isplaying_device = true;
                                audioplayed_device = true;
                              });
                            } else if (audioplayed_device &&
                                !isplaying_device) {
                              await player_device.resume();
                              setState(() {
                                isplaying_device = true;
                                audioplayed_device = true;
                              });
                            } else {
                              await player_device.pause();
                              setState(() {
                                isplaying_device = false;
                              });
                            }
                          } catch (e) {
                            print('find error music get ${e}');
                          }
                        },
                        icon: Icon(
                            isplaying_device ? Icons.pause : Icons.play_arrow),
                        label: Text(isplaying_device ? "Pause" : "Play")),
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            if (repect_audio_device < 2) {
                              repect_audio_device++;
                            } else {
                              repect_audio_device = 0;
                            }
                          });
                        },
                        child: Text("Repact $repect_audio_device")),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

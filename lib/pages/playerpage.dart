import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/const/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/playercontroller.dart';

class PlayerPage extends StatefulWidget {
  final List<SongModel> data;
  const PlayerPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  var controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
            children: [
              Obx(
                () => Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(49),
                      color: Colors.deepPurple[200],
                    ),
                    alignment: Alignment.center,
                    child: QueryArtworkWidget(
                      id: widget.data[controller.playIndex.value].id,
                      type: ArtworkType.AUDIO,
                      artworkFit: BoxFit.fill,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                      nullArtworkWidget: const Icon(
                        Icons.music_note,
                        size: 84,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        widget
                            .data[controller.playIndex.value].displayNameWOExt,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            color: whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "${widget.data[controller.playIndex.value].artist}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            color: whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: const TextStyle(
                                color: whiteColor,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                  thumbColor: sliderColor,
                                  activeColor: sliderColor,
                                  inactiveColor: whiteColor,
                                  min: const Duration(seconds: 0)
                                      .inSeconds
                                      .toDouble(),
                                  max: controller.max.value,
                                  value: controller.value.value,
                                  onChanged: (newValue) {
                                    controller.changeDurationToSeconds(
                                        newValue.toInt());
                                    newValue = newValue;
                                  }),
                            ),
                            Text(
                              controller.duration.value,
                              style: const TextStyle(color: whiteColor),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.playSong(
                                  widget
                                      .data[controller.playIndex.value - 1].uri,
                                  controller.playIndex.value - 1);
                            },
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              size: 40,
                              color: whiteColor,
                            ),
                          ),
                          Obx(
                            () => CircleAvatar(
                              radius: 35,
                              backgroundColor: whiteColor,
                              child: Transform.scale(
                                  scale: 2.5,
                                  child: controller.isPlaying.value
                                      ? IconButton(
                                          onPressed: () {
                                            if (controller.isPlaying.value) {
                                              controller.audioPlayer.pause();
                                              controller.isPlaying(false);
                                            } else {
                                              controller.audioPlayer.play();
                                              controller.isPlaying(true);
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.pause,
                                            color: bgDarkColor,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            if (controller.isPlaying.value) {
                                              controller.audioPlayer.pause();
                                              controller.isPlaying(false);
                                            } else {
                                              controller.audioPlayer.play();
                                              controller.isPlaying(true);
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.play_arrow,
                                            color: bgDarkColor,
                                          ),
                                        )),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.playSong(
                                  widget
                                      .data[controller.playIndex.value + 1].uri,
                                  controller.playIndex.value + 1);
                            },
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              size: 40,
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        padding: EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
            children: [
              Obx(
                () => Expanded(
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple[200],
                            borderRadius: BorderRadius.circular(15)),
                        alignment: Alignment.center,
                        child: QueryArtworkWidget(
                          id: widget.data[controller.playIndex.value].id,
                          type: ArtworkType.AUDIO,
                          artworkHeight: double.infinity,
                          artworkWidth: double.infinity,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            size: 54,
                            color: whiteColor,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            widget.data[controller.playIndex.value]
                                .displayNameWOExt,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                color: bgDarkColor,
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
                                color: bgDarkColor,
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
                                    color: bgDarkColor,
                                  ),
                                ),
                                Expanded(
                                  child: Slider(
                                      thumbColor: sliderColor,
                                      activeColor: sliderColor,
                                      inactiveColor: bgColor,
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
                                  style: const TextStyle(color: bgDarkColor),
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
                                          .data[controller.playIndex.value - 1]
                                          .uri,
                                      controller.playIndex.value - 1);
                                },
                                icon: const Icon(
                                  Icons.skip_previous_rounded,
                                  size: 40,
                                  color: bgDarkColor,
                                ),
                              ),
                              Obx(
                                () => CircleAvatar(
                                  radius: 35,
                                  backgroundColor: bgDarkColor,
                                  child: Transform.scale(
                                      scale: 2.5,
                                      child: controller.isPlaying.value
                                          ? IconButton(
                                              onPressed: () {
                                                if (controller
                                                    .isPlaying.value) {
                                                  controller.audioPlayer
                                                      .pause();
                                                  controller.isPlaying(false);
                                                } else {
                                                  controller.audioPlayer.play();
                                                  controller.isPlaying(true);
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.pause,
                                                color: whiteColor,
                                              ),
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                if (controller
                                                    .isPlaying.value) {
                                                  controller.audioPlayer
                                                      .pause();
                                                  controller.isPlaying(false);
                                                } else {
                                                  controller.audioPlayer.play();
                                                  controller.isPlaying(true);
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.play_arrow,
                                                color: whiteColor,
                                              ),
                                            )),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.playSong(
                                      widget
                                          .data[controller.playIndex.value + 1]
                                          .uri,
                                      controller.playIndex.value + 1);
                                },
                                icon: const Icon(
                                  Icons.skip_next_rounded,
                                  size: 40,
                                  color: bgDarkColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

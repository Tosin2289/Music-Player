import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controllers/playercontroller.dart';
import 'package:music_app/pages/playerpage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:lottie/lottie.dart';
import '../const/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          leading: const Icon(
            Icons.sort_rounded,
            color: whiteColor,
          ),
          elevation: 0,
          backgroundColor: bgDarkColor,
          title: Text(
            "Musica".toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: whiteColor,
                ))
          ],
        ),
        body: FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: Lottie.asset('assets/loading.json'));
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No song found",
                  style: TextStyle(fontSize: 20, color: whiteColor),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: Obx(
                        () => ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          tileColor: bgColor,
                          leading: QueryArtworkWidget(
                            id: snapshot.data![index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: const Icon(
                              Icons.music_note,
                              color: whiteColor,
                              size: 32,
                            ),
                          ),
                          title: Text(
                            snapshot.data![index].displayNameWOExt,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          subtitle: Text(
                            "${snapshot.data![index].artist}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                          trailing: controller.playIndex.value == index &&
                                  controller.isPlaying.value
                              ? const Icon(
                                  Icons.play_arrow,
                                  color: whiteColor,
                                  size: 26,
                                )
                              : null,
                          onTap: () {
                            Get.to(() => const PlayerPage());
                            // controller.playSong(
                            //     snapshot.data![index].uri, index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ));
  }
}

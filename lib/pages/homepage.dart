import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controllers/playercontroller.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
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
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: bgColor,
                        leading: const Icon(Icons.music_note,
                            color: whiteColor, size: 32),
                        title: Text(
                          "${snapshot.data![index].displayNameWOExt}",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        subtitle: Text(
                          "${snapshot.data![index].artist}",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        trailing: const Icon(
                          Icons.play_arrow,
                          color: whiteColor,
                          size: 26,
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

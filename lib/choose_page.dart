
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:spotifyapp/player_page.dart';

class ChoosePage extends StatelessWidget {
  final String genre;
  const ChoosePage({super.key, required this.genre});

  List<String> getSongsForGenre(String genre) {
    if (genre == 'Feel Good\nSongs' || genre == 'Feel Good Songs') {
      return [
        'Elamalakaadinullil',
        'June_Video_Song_Minni Minni',
        'Perilla_Raajyathe',
        'Haalaake_Maarunne'
      ];
    } else if (genre == 'Chill/Lo-Fi') {
      return [
        'Cousins',
        'Whistleu_Bigilu_Lyrical',
        'Jalebi BabyTesher_x_Jason_Derulo',
        'Main_Tera_Boyfriend_Song',
        'JIL_JIL_JIL _Song'
      ];
    } 
    else if (genre == 'Favourites') {
      return [
        'Njano_Ravo_Kammara_Sambhavam',
         'Pasoori _ Ali Sethi_Shae_Gill', 
         'Perilla_Raajyathe',
          'Irulil_Oru_Kaithiri_SpanishMasala '];
    } else if (genre == 'Melody') {
      return [
        'AjayAtul_Abhi_Mujh_MeinKahin',
        'Ae_Dil_Hai_Mushkil',
        'Innalakale_Honey_Bee',
        'Mersal_Neethanae_Tamil_Lyric',
      ];
    } else if (genre == 'Romantic') {
      return [
        'Mehabooba',
        'Jeevamshamayi_Theevandi',
        'Neela_Nilave_Song',
        'Dil_Wale_Puchde_Ne'
      ];
    } else {
      return ['No songs found for this genre'];
    }
  }

  Widget songcontainer(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlayerPage(title: title)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Marquee(
                text: title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                blankSpace: 60,
                velocity: 25,
              ),
            ),
            const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.play_arrow, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> songs = getSongsForGenre(genre);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 50,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "choose a song",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return songcontainer(context, songs[index]);
        },
      ),
    );
  }
}

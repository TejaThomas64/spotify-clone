import 'package:flutter/material.dart';
import 'package:spotifyapp/choose_page.dart';
import 'package:spotifyapp/player_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> allSongs = [
    'Mersal_Neethanae_Tamil_Lyric',
    'Njano_Ravo_Kammara_Sambhavam',
    'Jalebi BabyTesher_x_Jason_Derulo',
    'Whistleu_Bigilu_Lyrical',
    'Elamalakaadinullil',
    'June_Video_Song_Minni Minni',
    'Haalaake_Maarunne',
    'Cousins',
    'Main_Tera_Boyfriend_Song',
    'JIL_JIL_JIL _Song',
    'Pasoori _ Ali Sethi_Shae_Gill',
    'Perilla_Raajyathe',
    'Irulil_Oru_Kaithiri_SpanishMasala ',
    'AjayAtul_Abhi_Mujh_MeinKahin',
    'Ae_Dil_Hai_Mushkil',
    'Innalakale_Honey_Bee',
    'Mehabooba',
    'Jeevamshamayi_Theevandi',
    'Neela_Nilave_Song',
    'Dil_Wale_Puchde_Ne',
  ];

  List<String> filteredSongs = [];

  void _filterSongs(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      filteredSongs =
          allSongs
              .where((song) => song.toLowerCase().contains(lowerQuery))
              .toList();
    });
  }

  Widget buildBox(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlayerPage(title: title)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 85,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 30),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget GenreBox(BuildContext context, String text, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChoosePage(genre: text)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 130,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tune In',
              style: TextStyle(
                color: Colors.green,
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/music/new.png',
              height: 70,
              width: 60,
              fit: BoxFit.cover,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterSongs,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.black87),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                if (filteredSongs.isNotEmpty)
                  ...filteredSongs.map(
                    (song) => SingleChildScrollView(
                      child: ListTile(
                        minTileHeight: 100,

                        title: Text(
                          song,
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerPage(title: song),
                            ),
                          ).then((_) {
                            _searchController.clear();
                            setState(() {
                              filteredSongs.clear();
                            });
                          });
                        },
                      ),
                    ),
                  ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    'Recommended Songs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: buildBox(
                        context,
                        'Mersal_Neethanae_Tamil_Lyric',
                        Icons.music_note,
                        Colors.red,
                      ),
                    ),
                    Expanded(
                      child: buildBox(
                        context,
                        'Njano_Ravo_Kammara_Sambhavam',
                        Icons.music_note,
                        Colors.blue,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: buildBox(
                        context,
                        'Jalebi BabyTesher_x_Jason_Derulo',
                        Icons.music_note,
                        Colors.orange,
                      ),
                    ),
                    Expanded(
                      child: buildBox(
                        context,
                        'Whistleu_Bigilu_Lyrical',
                        Icons.music_note,
                        Colors.teal,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    'Browse Songs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      GenreBox(context, 'Chill/Lo-Fi', 'assets/music/pop.jpg'),
                      GenreBox(
                        context,
                        'Favourites',
                        'assets/music/favourite.jpg',
                      ),
                      GenreBox(
                        context,
                        'Feel Good\nSongs',
                        'assets/music/feelgood.jpg',
                      ),
                      GenreBox(
                        context,
                        'Romantic',
                        'assets/music/romantic.jpg',
                      ),
                      GenreBox(context, 'Melody', 'assets/music/melody.jpg'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

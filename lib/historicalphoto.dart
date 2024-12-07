import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_app/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';


class HistoricalPhotoPage extends StatefulWidget {
  const HistoricalPhotoPage({super.key});

  @override
  HistoricalPhotoPageState createState() => HistoricalPhotoPageState();
}

class HistoricalPhotoPageState extends State<HistoricalPhotoPage> {
  final List<Photo> _photos = [];

  void _addPhoto(Photo photo) {
    setState(() {
      _photos.add(photo);
    });
  }

  void _removePhoto(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Foto'),
          content: const Text('Apakah Anda ingin menghapus foto ini?'),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Hapus'),
              onPressed: () {
                setState(() {
                  _photos.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> _showAddPhotoDialog() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    String year = '';
    String description = '';

    if (!mounted) return; 

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambahkan Foto Sejarah'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Tahun Publikasi'),
                onChanged: (value) {
                  year = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Deskripsi Foto'),
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Tambahkan'),
              onPressed: () {
                if (year.isNotEmpty && description.isNotEmpty) {
                  _addPhoto(Photo(
                    image: File(image.path),
                    year: year,
                    description: description,
                  ));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 95, 91, 91),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 36, 47, 48),
        centerTitle: true,
        title: const Text(
          'Historical Photos',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                color: Colors.white,
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Admin Kelompok'),
              accountEmail: const Text(
                'sisteminformasiamq@gmail.com',
                style: TextStyle(color: Colors.lightBlue),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    fit: BoxFit.cover,
                    'assets/logoprofil.JPEG',
                    width: 90,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/6/60/Max_Br%C3%BCckner_-_Otto_Henning_-_Richard_Wagner_-_Final_scene_of_G%C3%B6tterd%C3%A4mmerung_-_crop.jpg'
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_3_rounded),
              title: const Text('Dev-Team Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_rounded),
              title: const Text('Historical Photos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoricalPhotoPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.reddit),
              title: const Text('r/History'),
              onTap: () async {
                final Uri url = Uri.parse('https://www.reddit.com/r/History/');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.twitter),
              title: const Text('Historic Video Page'),
              onTap: () async {
                final Uri url = Uri.parse('https://x.com/historyinmemes');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Apakah anda yakin ingin keluar?'),
                    actions: [
                      TextButton(
                        child: const Text('Batal'), 
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                        TextButton(
                        child: const Text(
                          'Keluar', 
                          style: TextStyle(color: Colors.red),
                        ), 
                        onPressed: () {
                          SystemNavigator.pop();
                        }),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _photos.isEmpty 
        ? const Center(
            child: Text(
              'Belum ada foto yang ditambahkan!',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemCount: _photos.length,
            itemBuilder: (context, index) {
              final photo = _photos[index];
              return Card(
                color: Colors.grey[850],
                margin: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Image.file(
                            photo.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            photo.year,
                            style: GoogleFonts.roboto(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            photo.description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _removePhoto(index);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPhotoDialog,
        backgroundColor: const Color.fromARGB(255, 36, 47, 48),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Photo {
  final File image;
  final String year;
  final String description;

  Photo({
    required this.image,
    required this.year,
    required this.description,
  });
}

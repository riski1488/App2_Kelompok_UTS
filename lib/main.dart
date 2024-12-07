import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/historicalphoto.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 95, 91, 91),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 36, 47, 48),
              centerTitle: true,
              title: const Text(
                'Dev-Team Page',
                style: 
                TextStyle(color: Colors.white),
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
                        )
                      ),
                    )
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_3_rounded),
                    title: const Text('Dev-Team Page'),
                    onTap: () {
                      Navigator.pop(context);
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
                      }
                      else {
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
                      }
                      else {
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
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(height: 40), 
                  Center(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/logoprofil.JPEG',
                        width: 200, 
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Developer Team', 
                       style: GoogleFonts.unifrakturCook (
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Center(
                    child: Text(
                      'Pictures History in Motion', 
                      style: TextStyle(
                        fontSize: 20, 
                        fontStyle: FontStyle.italic,
                        color: Colors.grey
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'Path one way forward to achieve triumph of the will for the people', 
                        style: TextStyle(
                          fontSize: 18, 
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const DevCard(
                    name: 'Alvin Enus',
                    id: '220102024',
                  ),
                  const DevCard(
                    name: 'Bryan Cristo Nicolaus Kwaar',
                    id: '220102004',
                  ),
                  const DevCard(
                    name: 'Fransiskus Leonard Somar',
                    id: '220102026',
                  ),
                  const DevCard(
                    name: 'Frendi Saplola',
                    id: '220102032',
                  ),
                  const DevCard(
                    name: 'Khalid Rizky Samuda',
                    id: '220102001',
                  ),
                  const DevCard(
                    name: 'Naufal Banu',
                    id: '220102011',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DevCard extends StatelessWidget {
  final String name;
  final String id;

  const DevCard({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(name),
        subtitle: Text('NIM: $id'),
      ),
    );
  }
}

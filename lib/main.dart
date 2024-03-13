import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(), //temayı eklediğimiz provider
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          // Tema değişikliğine göre uygun tema verilir
          return MaterialApp(
            title: 'Theme Example',

            // Light tema renkleri ve metin stilleri
            theme: themeProvider.isDarkMode
                ? ThemeData.dark().copyWith(
                    // Uygulama arka plan rengi
                    scaffoldBackgroundColor: Colors.black,
                    // Başlık çubuğu rengi
                    appBarTheme: const AppBarTheme(
                      color: Colors.black12,
                    ),
                    // Ana metin rengi
                    textTheme: const TextTheme(
                      headline6: TextStyle(color: Colors.white),
                      bodyText1: TextStyle(color: Colors.white),
                      bodyText2: TextStyle(color: Colors.white),
                    ),
                  )
                : ThemeData.light().copyWith(
                    // Uygulama arka plan rengi
                    scaffoldBackgroundColor: Colors.white,
                    // Başlık çubuğu rengi
                    appBarTheme: const AppBarTheme(
                      color: Color.fromARGB(255, 161, 106, 170),
                      // textTheme: TextTheme(
                      //   headline6: TextStyle(color: Colors.white),
                      // ),
                    ),
                    // Ana metin rengi
                    textTheme: const TextTheme(
                      bodyText1: TextStyle(color: Colors.black),
                      bodyText2: TextStyle(color: Colors.black),
                    ),
                  ),
            // Tema değiştirme sayfası
            home: const ThemePage(),
          );
        },
      ),
    );
  }
}

// Tema Değiştirme Sayfası
class ThemePage extends StatelessWidget {
  const ThemePage({super.key});
  @override
  Widget build(BuildContext context) {
    //provider'ı bu şekilde de kullanacağımız değişkeni çağırarak kullanabilriz.
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Theme Change'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 161, 106, 170),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(isDarkMode ? 'Dark Theme' : 'Light Theme'),
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    // Tema değiştirme anahtarı
                    return Switch(
                      thumbIcon: const MaterialStatePropertyAll(Icon(
                        Icons.sunny,
                        color: Colors.amber,
                      )),
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HelpPage(),
                ),
              );
            },
            child: Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 161, 106, 170),
                  borderRadius: BorderRadius.circular(20)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Help Page'), Icon(Icons.help)],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Help Page'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15),
        child: Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
      ),
    );
  }
}

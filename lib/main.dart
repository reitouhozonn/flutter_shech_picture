import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PixabayPage(),
    );
  }
}

class PixabayPage extends StatefulWidget {
  const PixabayPage({super.key});

  @override
  State<PixabayPage> createState() => _PixabayPageState();
}

class _PixabayPageState extends State<PixabayPage> {
  List imageList = [];

  Future<void> fetchImages(String text) async {
    Response response = await Dio().get(
        'https://pixabay.com/api/?key=39403222-fea081f96daf081db91214c01&q= $text&image_type=photo');

    imageList = response.data['hits'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchImages('桜');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: const InputDecoration(
            fillColor: Colors.white54,
            filled: true,
          ),
          onFieldSubmitted: (text) {
            print(text);
            fetchImages(text);
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> image = imageList[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                image['previewURL'],
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.thumb_up_off_alt_outlined,
                        size: 14,
                      ),
                      Text(
                        image['likes'].toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatelessWidget {
  String title;
  String pubDate;
  String thumbnail;
  String description;
  String link;

  ProductDetail(
      {Key? key,
      required this.title,
      required this.pubDate,
      required this.thumbnail,
      required this.description,
      required this.link})
      : super(key: key);

  final Uri _url = Uri.parse('https://flutter.dev');
  //

  Future<void> goToWebPage(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text("News Detail"),
        backgroundColor: Color.fromARGB(255, 6, 136, 99),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(18),
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(pubDate)),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: size.width * 100,
                height: size.height * 0.3,
                child: Image.network(
                  thumbnail.toString(),
                  width: 60,
                  height: 130,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        description.toString(),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          wordSpacing: 3,
                        ),
                        maxLines: 11,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () async {
                  await goToWebPage(link.toString());
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 6, 136, 99),
                  ),
                ),
                child: const Text(
                  "Baca Selengkapnya...",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

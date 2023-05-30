import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi_152/detail.dart';
class HalamanTerbaru extends StatefulWidget {
  const HalamanTerbaru({super.key});

  @override
  State<HalamanTerbaru> createState() => _HalamanTerbaruState();
}

class _HalamanTerbaruState extends State<HalamanTerbaru> {
  List<Map<String, dynamic>> home = [];
  bool load = false;

  @override
  void initState() {
    super.initState();
    fetchHome();
  }

  fetchHome() async {
    setState(() {
      load = true;
    });
    var url = "https://api-berita-indonesia.vercel.app/republika/terbaru";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> items = data['data']['posts'];

      setState(() {
        home = items
            .map((item) => {
                  'title': item['title'],
                  'pubDate': item['pubDate'],
                  'thumbnail': item['thumbnail'],
                  'description': item['description'],
                  'link': item['link'],
                })
            .toList();
        load = false;
      });
    } else {
      setState(() {
        home = [];
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REPUBLIKA TERBARU"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 6, 136, 99),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    // ignore: prefer_is_empty
    if (home.contains(null) || home.length < 0 || load) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
      ));
    }
    return ListView.builder(
        itemCount: home.length,
        itemBuilder: (context, index) {
          return getCard(home[index]);
        });
  }

  Widget getCard(item) {
    //nama=>nama di api
    var title = item['title'];
    var thumbnail = item['thumbnail'];
    var pubDate = item['pubDate'];
    var description = item['description'];
    var link = item['link'];

    
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetail(
            title: title,
            thumbnail: thumbnail,
            pubDate: pubDate,
            description: description,
            link: link,
          ),
        )),
        child: Container(
          height: MediaQuery.of(context).size.height / 7,
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 3,
                ),
              ),
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.network(
                  thumbnail.toString(),
                  width: 100,
                  height: 180,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.shop,
                      size: 90,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
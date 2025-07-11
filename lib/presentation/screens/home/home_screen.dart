import 'dart:core';

import 'package:flutter/material.dart';
import 'package:found_one/presentation/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _allPosts = [
    {
      "name": "Vivek Sharma",
      "title": "Selling earbuds",
      "type": "Sale",
      "image":
          'https://cdn.pixabay.com/photo/2021/06/01/07/03/sparrow-6300790_960_720.jpg',
      "description":
          "This is a description of the first post. And here we go again with one more things lost in this campus",
    },
    {
      "name": "Vivek Sharma",
      "title": "Selling earbuds",
      "type": "Lost",
      "image":
          'https://cdn.pixabay.com/photo/2021/06/01/07/03/sparrow-6300790_960_720.jpg',
      "description":
          "This is a description of the first post. And here we go again with one more things lost in this campus",
    },
    {
      "name": "Vivek Sharma",
      "title": "Selling earbuds",
      "type": "Sale",
      "image":
          'https://cdn.pixabay.com/photo/2021/06/01/07/03/sparrow-6300790_960_720.jpg',
      "description":
          "This is a description of the first post. And here we go again with one more things lost in this campus",
    },
    {
      "name": "Vivek Sharma",
      "title": "Selling socks",
      "type": "Lost",
      "image":
          'https://cdn.pixabay.com/photo/2021/06/01/07/03/sparrow-6300790_960_720.jpg',
      "description":
          "This is a description of the first post. And here we go again with one more things lost in this campus",
    },
  ];

  List<Map<String, String>> _foundItem = [];
  @override
  void initState() {
    _foundItem = _allPosts;
    super.initState();
  }

  void _runFilter(String keyword) {
    List<Map<String, String>> results = [];
    if (keyword.isEmpty) {
      results = _allPosts;
    } else {
      results = _allPosts
          .where(
            (post) =>
                post["title"]!.toLowerCase().contains(keyword.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      _foundItem = results;
    });
  }

  // List<String> name = ["Vivek Sharma", "Rahul Kumar", "Rohan Kumar"];

  // List<String> title = [
  //   "Selling earbuds",
  //   "Selling earbuds",
  //   "Selling earbuds",
  // ];

  // List<String> image = [
  //   'https://cdn.pixabay.com/photo/2021/06/01/07/03/sparrow-6300790_960_720.jpg',
  //   'https://cdn.pixabay.com/photo/2017/10/20/10/58/elephant-2870777_960_720.jpg',
  //   'https://cdn.pixabay.com/photo/2014/09/08/17/32/humming-bird-439364_960_720.jpg',
  // ];

  // List<String> description = [
  //   "This is a description of the first post. And here we go again with one more things lost in this campus",
  //   "This is a description of the second post",
  //   "This is a description of the third post",
  // ];

  // List<String> type = ["Lost", "Sale", "Sale"];

  // List<Map<String

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Hello",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                            ),
                            children: [
                              TextSpan(
                                text: "\nSreyash Singh",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.logout),
                          iconSize: 25,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    TextField(
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                        hintText: "Search through titles",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    // SizedBox(height: 0),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: _foundItem.isNotEmpty
                ? ListView.separated(
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                    padding: EdgeInsets.all(10.0),
                    scrollDirection: Axis.vertical,
                    itemCount: _foundItem.length,
                    itemBuilder: (context, index) {
                      return PostCard(
                        backgroundColor:
                            _foundItem[index]["type"].toString() == "Sale"
                            ? Color(0xffBFEAFD)
                            : Color(0xffFFD5C7),
                        typeColor:
                            _foundItem[index]["type"].toString() == "Sale"
                            ? Color(0xff29B6F6)
                            : Color(0xffFF7043),
                        name: _foundItem[index]["name"].toString(),
                        title: _foundItem[index]["title"].toString(),
                        description: _foundItem[index]["description"]
                            .toString(),
                        image: _foundItem[index]["image"].toString(),
                        type: _foundItem[index]["type"].toString(),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No result found",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

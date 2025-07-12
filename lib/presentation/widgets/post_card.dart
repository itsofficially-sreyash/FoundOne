import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PostCard extends StatelessWidget {
  final Color backgroundColor;
  final Color typeColor;
  final String name;
  final String title;
  final String description;
  final String image;
  final String type;
  final Color shadowColor;
  final String phoneNumber;

  const PostCard({
    super.key,
    required this.backgroundColor,
    required this.name,
    required this.title,
    required this.description,
    required this.image,
    required this.type,
    required this.typeColor,
    required this.shadowColor,
    required this.phoneNumber,
  });

  Future<void> launchDialer(String phoneNumber) async {
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri launchUri = Uri(scheme: "tel", path: cleanNumber);

    try {
      bool canLaunch = await canLaunchUrl(launchUri);
      if (canLaunch) {
        await launchUrl(launchUri);
      }
    } catch (e) {
      print("Error launching dialer: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 1,
      shadowColor: shadowColor,
      color: backgroundColor.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                //name
                Text(name, style: TextStyle(fontSize: 16, color: Colors.black)),
                SizedBox(width: 10),
                //type
                Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: typeColor,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: Colors.white),
                      SizedBox(width: 3),
                      Text(
                        type,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                //phone
                ElevatedButton(
                  onPressed: () {
                    launchDialer(phoneNumber);
                  },
                  child: Icon(Icons.phone, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(30, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            //title
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            //image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 100,
                height: 100,
                child: Image.network(image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 10),
            //description
            Text(
              "Description",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 0),
            Text(description, style: TextStyle(fontSize: 14)),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

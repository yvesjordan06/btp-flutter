import 'package:flutter/material.dart';

class ChatListCategorySelector extends StatefulWidget {
  @override
  _ChatListCategorySelectorState createState() => _ChatListCategorySelectorState();
}

class _ChatListCategorySelectorState extends State<ChatListCategorySelector> {
  int selectedIndex = 0;
  final List<String> categories = ['Tout', 'Récruté', 'Demandes', 'Informations'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: Text(categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? Colors.white : Colors.white60,
                fontSize: 20.0,
                letterSpacing: 1.2
              ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


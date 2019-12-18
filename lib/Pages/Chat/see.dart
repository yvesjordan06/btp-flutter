import 'package:btpp/Functions/Utility.dart';
import 'package:flutter/material.dart';

class SingleChatPage extends StatefulWidget {
  SingleChatPage({Key key}) : super(key: key);

  @override
  _SingleChatPageState createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  List<String> message = [];
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
          title: ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              //radius: 20,
              child: Image.asset('images/userfallback.png'),
            ),
            title: Text('Hiro Hamada'),
            subtitle: Text('Construction'),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: message.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(timeAgo(DateTime.now())),
                          Text(message.reversed.toList()[index]),
                        ],
                      ),
                      margin: EdgeInsets.only(
                          right: 80, bottom: 12, top: 12, left: 8),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Theme.of(context).primaryColor,
                      ));
                },
              ),
            ),
            TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: 'Votre message',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      String text = messageController.text;
                      if (text.isNotEmpty) {
                        setState(() {
                          message.add(text);
                          messageController.clear();
                        });
                      }
                    },
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () {},
                  )),
            )
          ],
        ),
      ),
    );
  }
}

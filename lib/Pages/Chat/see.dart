import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class SingleChatPage extends StatefulWidget {
  @override
  _SingleChatPageState createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  final List<String> message = [
    'Salut',
    'Bonjour, qui est-ce svp',
    'Je suis M. Hiro',
    'Daccord ravi de vous connaitre'
  ].reversed.toList();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  TextEditingController messageController = TextEditingController();

  void _send() {
    print('sending');
    String text = messageController.text;
    if (text.isNotEmpty) {
      message.insert(0, text.trim());
      _listKey.currentState.insertItem(0);
    }
    messageController.clear();
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
              child: Hero(
                child: Image.asset('images/userfallback.png'),
                tag: 'userinfo1',
              ),
            ),
            title: Hero(
              child: Text('Hiro Hamada'),
              tag: 'username1',
            ),
            subtitle: Text('Construction'),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/background1.jpg'),
          )),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: ListView(
                    reverse: true,
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      AnimatedList(
                        key: _listKey,
                        reverse: true,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        initialItemCount: message.length,
                        itemBuilder: (context, index, animation) {
                          return SlideTransition(
                            position: animation.drive(
                                Tween(begin: Offset(0, 1), end: Offset.zero)),
                            child: Bubble(
                              child: Column(
                                  crossAxisAlignment: index % 4 == 0
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    Text(message[index].trim()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            '12:10',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.grey[800]),
                                          ),
                                          Icon(
                                            Icons.done,
                                            color: Colors.grey[800],
                                            size: 8,
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                              stick: true,
                              margin: index % 4 == 0
                                  ? BubbleEdges.only(top: 10, right: 30)
                                  : BubbleEdges.only(top: 10, left: 30),
                              nip: index % 4 == 0
                                  ? BubbleNip.leftTop
                                  : BubbleNip.rightTop,
                              alignment: index % 4 == 0
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              color: index % 4 == 0
                                  ? ThemeData().primaryColor
                                  : ThemeData().accentColor,
                            ),
                          );
                        },
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Bubble(
                              color: Colors.indigo[300],
                              child: Text('Hiro a postuler aux taches'),
                              alignment: Alignment.center,
                              margin: BubbleEdges.all(8),
                            ),
                            Wrap(
                              children: List<Widget>.generate(
                                  4,
                                  (index) => Container(
                                        margin: EdgeInsets.all(4),
                                        child: Chip(
                                          avatar: Icon(
                                            Icons.done,
                                            size: 12,
                                            color: Colors.lime,
                                          ),
                                          backgroundColor: Colors.lightBlue,
                                          label: Text(
                                            'macon',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: messageController,
                          textCapitalization: TextCapitalization.sentences,
                          autocorrect: true,
                          minLines: 1,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Votre message',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _send,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

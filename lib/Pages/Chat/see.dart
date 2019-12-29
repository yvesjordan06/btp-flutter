import 'package:btpp/Functions/Images.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class SingleChatPage extends StatefulWidget {
  final ChatModel chat;

  const SingleChatPage({Key key, this.chat})
      : assert(chat != null && chat is ChatModel),
        super(key: key);
  @override
  _SingleChatPageState createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  List<MessageModel> messages;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    messages = List<MessageModel>.generate(
        widget.chat.messages.length, (index) => widget.chat.messages[index]);
    super.initState();
  }

  void _send() {
    print('sending');
    String text = messageController.text;
    if (text.isNotEmpty) {
      messages.insert(0, MessageModel(text: text, sentAt: DateTime.now()));
      _listKey.currentState.insertItem(0);
    }
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
          title: ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Hero(
              child: UserImage(
                user: widget.chat.contact,
                radius: 20,
              ),
              tag: 'image' + widget.chat.hashCode.toString(),
            ),
            title: Hero(
              child: Text(
                widget.chat.contact.nom,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white, fontSize: 16),
              ),
              tag: 'nom' + widget.chat.hashCode.toString(),
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
                        initialItemCount: messages.length,
                        itemBuilder: (context, index, animation) {
                          return SlideTransition(
                            position: animation.drive(
                                Tween(begin: Offset(0, 1), end: Offset.zero)),
                            child: Dismissible(
                              direction: DismissDirection.startToEnd,
                              child: Bubble(
                                child: Column(
                                    crossAxisAlignment: messages[index].sender
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.end,
                                    children: [
                                      Text(messages[index].text.trim()),
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
                                            if (!messages[index].sender)
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
                                margin: messages[index].sender
                                    ? BubbleEdges.only(top: 10, right: 30)
                                    : BubbleEdges.only(top: 10, left: 30),
                                nip: messages[index].sender
                                    ? BubbleNip.leftTop
                                    : BubbleNip.rightTop,
                                alignment: messages[index].sender
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                                color: messages[index].sender
                                    ? Colors.white
                                    : ThemeData().accentColor,
                              ),
                              key: GlobalKey(),
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
                      onPressed: () {
                        multiImagePicker().then((value) => {});
                      },
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

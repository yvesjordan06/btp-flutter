import 'package:btpp/Components/horizontalDivider.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/App/imageViewer.dart';
import 'package:btpp/Pages/User/profile.dart';
import 'package:btpp/State/index.dart';
import 'package:flutter/material.dart';

class ActuPage extends StatelessWidget {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualités'),
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) => ActuTile(),
      ),
    );
  }
}

class ActuTile extends StatefulWidget {
  const ActuTile({Key key}) : super(key: key);

  @override
  _ActuTileState createState() => _ActuTileState();
}

class _ActuTileState extends State<ActuTile> {
  bool showComment = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Parent Tapped');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Name Here'),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Location here'),
                  Text(
                    'just now',
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              leading: UserImage(
                user: AppState.userState.currentUser,
                radius: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 300),
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DismissableImage.network(
                                  'https://picsum.photos/200/300?random=1',
                                  tag: 'https://picsum.photos/500/300$index ' +
                                      DateTime.now().toString(),
                                )));
                  },
                  child: Hero(
                    tag: 'https://picsum.photos/200/300?random=1 $index ' +
                        DateTime.now().toString(),
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 4),
                      width: 600,
                      height: 900,
                      constraints: BoxConstraints(maxWidth: 250),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.red,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://picsum.photos/200/300?random=1'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Lorem Ipsum Lorem Ipsum testLorem Ipsum testLorem Ipsum testLorem Ipsum testLorem Ipsum testLorem Ipsum testLorem Ipsum testLorem Ipsum testLorem Ipsum testLorem Ipsum test test Lorem Ipsum testLorem Ipsum testLorem Ipsum test',
                style: TextStyle(),
                // maxLines: 2,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(Icons.star),
                      label: Text('18'),
                      onPressed: () {
                        print('liked Tapped');
                      },
                    ),
                    FlatButton.icon(
                      icon: Icon(Icons.comment),
                      label: Text('112'),
                      onPressed: () {
                        setState(() {
                          showComment = !showComment;
                        });
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {},
                )
              ],
            ),
            if (showComment) ...[
              HorizontalDivider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    icon: UserImage(
                      user: AppState.userState.currentUser,
                      radius: 15,
                    ),
                    hintText: 'Votre commentaire',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.send),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  CommentBox(),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}

class UserImage extends StatefulWidget {
  final UserModel user;
  final double radius;
  UserImage({Key key, @required this.user, this.radius = 30})
      : assert(user != null),
        super(key: key);

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  @override
  void didUpdateWidget(UserImage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        radius: widget.radius,
        backgroundImage: widget.user.localPicture == null
            ? NetworkImage(widget.user.pictureLink)
            : FileImage(widget.user.localPicture),
      ),
    );
  }
}

class CommentBox extends StatelessWidget {
  const CommentBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(user: AppState.userState.currentUser)));
        },
        child: Hero(
          tag: 'uniquetag1',
          child: UserImage(
            user: AppState.userState.currentUser,
            radius: 15,
          ),
        ),
      ),
      title: Text('Nom'),
      isThreeLine: true,
      subtitle: Text(
        'https://picsum.photos/200/300?random=1 https://picsum.photos/200/300?random=1 https://picsum.photos/200/300?random=1 https://picsum.photos/200/300?random=1',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

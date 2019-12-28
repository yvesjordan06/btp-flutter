import 'dart:io';

import 'package:btpp/Components/annonce.dart';
import 'package:btpp/Components/horizontalDivider.dart';
import 'package:btpp/Functions/Images.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/App/imageViewer.dart';
import 'package:btpp/Pages/User/profile.dart';
import 'package:btpp/State/index.dart';
import 'package:btpp/State/user.dart';
import 'package:btpp/bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ActuPage extends StatefulWidget {
  @override
  _ActuPageState createState() => _ActuPageState();
}

class _ActuPageState extends State<ActuPage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController controller = ScrollController();

  final ActuBloc bloc = actuBloc;

  @override
  void initState() {
    super.initState();
    bloc.add(ActuFetch());
  }

  List<ActuModel> list = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualités'),
      ),
      body: BlocListener<ActuBloc, ActuState>(
        bloc: bloc,
        listener: (context, state) {
          print(state);
          if (state is ActuFetchedState) {
            list = state.list;
          }
        },
        child: BlocBuilder<ActuBloc, ActuState>(
          bloc: bloc,
          builder: (context, state) {
            return ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CreateActu(),
                Container(
                  child: Stack(
                    // fit: StackFit.passthrough,
                    children: <Widget>[
                      if (list.length < 1)
                        Container(
                          //color: Colors.white54,
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                            child: FittedBox(
                              child: Text('Aucune Realisation'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) => ActuTile(list[index]),
                      ),
                      if (state is ActuFetchingState)
                        Container(
                          color: Colors.white54,
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                            child: FittedBox(
                              child: CircularProgressIndicator(),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class CreateActu extends StatefulWidget {
  const CreateActu({
    Key key,
  }) : super(key: key);

  @override
  _CreateActuState createState() => _CreateActuState();
}

class _CreateActuState extends State<CreateActu> {
  ActuModel actu = ActuModel();
  bool createMode = false;
  List<Asset> images = List<Asset>();
  final TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActuBloc, ActuState>(
      bloc: actuBloc,
      listener: (context, state) {
        if (state is ActuCreatedState) {
          formKey.currentState.reset();
          images.clear();
          createMode = false;
          Scaffold.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Creée'),
          ));
        }
      },
      child: BlocBuilder<ActuBloc, ActuState>(
        bloc: actuBloc,
        builder: (context, ActuState state) {
          return Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
                decoration: BoxDecoration(
                    border: createMode
                        ? Border.all(color: Colors.black, width: 2)
                        : null),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    if (!createMode)
                      CurrentUserImage(
                        radius: 15,
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (createMode)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Nouvelle Realisation'),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          createMode = false;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              if (createMode)
                                TextFormField(
                                  onSaved: (val) {
                                    actu.intitule = val;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Titre',
                                    // border: InputBorder.none,
                                  ),
                                ),
                              if (createMode)
                                TextFormField(
                                  onSaved: (val) {
                                    actu.lieu = val;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Lieu ex:Cameroun, Douala',

                                    // border: InputBorder.none,
                                  ),
                                ),
                              TextFormField(
                                onSaved: (val) {
                                  actu.description = val;
                                },
                                onTap: () {
                                  setState(() {
                                    createMode = true;
                                  });
                                },
                                showCursor: createMode,
                                decoration: InputDecoration(
                                  hintText: 'Nouvelle Réalisation',
                                  border: createMode
                                      ? UnderlineInputBorder()
                                      : InputBorder.none,
                                ),
                                maxLines: 3,
                                minLines: 1,
                              ),
                              if (createMode)
                                TextField(
                                  controller: dateController,
                                  showCursor: false,
                                  readOnly: true,
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1820),
                                            lastDate: DateTime.now())
                                        .then((v) {
                                      setState(() {
                                        actu.date = v;
                                        if (v != null) {
                                          dateController.text =
                                              DateFormat.yMMMMd().format(v);
                                        }
                                      });
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Date',
                                    suffixIcon: Icon(Icons.arrow_drop_down),
                                  ),
                                ),
                              if (createMode)
                                Wrap(
                                  children: List<Widget>.generate(
                                      images.length,
                                      (index) => Stack(
                                            children: <Widget>[
                                              Container(
                                                width: 60,
                                                height: 60,
                                                margin: EdgeInsets.all(8),
                                                child: InkWell(
                                                  onTap: () async {
                                                    var pic =
                                                        await images[index]
                                                            .getByteData();
                                                    var mem = pic.buffer
                                                        .asUint8List();
                                                    showDialog(
                                                        context: context,
                                                        child: DismissableImage
                                                            .memory(mem));
                                                  },
                                                  child: AssetThumb(
                                                    asset: images[index],
                                                    height: 80,
                                                    width: 80,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Icon(Icons.delete),
                                                  iconSize: 12,
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    setState(() {
                                                      images.removeAt(index);
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                          )),
                                ),
                              if (createMode)
                                FlatButton.icon(
                                  icon: Icon(Icons.add_a_photo),
                                  onPressed: () {
                                    multiImagePicker().then((assets) {
                                      if (assets.length > 0)
                                        setState(() {
                                          images = assets;
                                        });
                                    });
                                  },
                                  label: Text('Ajoutez des images'),
                                ),
                              if (createMode)
                                Align(
                                  alignment: Alignment.topRight,
                                  child: FlatButton.icon(
                                    icon: Icon(Icons.create),
                                    label: Text('Create'),
                                    onPressed: () {
                                      if (formKey.currentState.validate() &&
                                          images.length > 0) {
                                        setState(() {});
                                        actu.assetPictures = List.from(images);
                                        formKey.currentState.save();
                                        actuBloc.add(ActuAdd(actu));
                                      }
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (state is ActuCreatingState)
                Positioned.fill(
                  child: Container(
                    color: Colors.black12,
                    child: Center(
                      child: FittedBox(
                        child: CircularProgressIndicator(),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}

class ActuTile extends StatefulWidget {
  final ActuModel actu;
  const ActuTile(this.actu, {Key key}) : super(key: key);

  @override
  _ActuTileState createState() => _ActuTileState();
}

class _ActuTileState extends State<ActuTile> {
  bool showComment = false;
  ActuModel actu;

  @override
  Widget build(BuildContext context) {
    actu = widget.actu;
    return GestureDetector(
      onTap: () {
        print('Parent Tapped');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(actu.intitule),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(actu.lieu),
                  Text(
                    DateFormat.yMMM().format(actu.date),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              /*leading: CurrentUserImage(
                radius: 25,
              ), */
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
                itemCount: actu.assetPictures == null
                    ? actu.pictures.length
                    : actu.assetPictures.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DismissableImage.network(
                                  actu.pictures[index],
                                  tag: 'https://picsum.photos/500/300$index ' +
                                      DateTime.now().toString(),
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 4),
                    width: 600,
                    height: 900,
                    constraints: BoxConstraints(maxWidth: 250),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.transparent,
                      image: actu.assetPictures == null
                          ? DecorationImage(
                              image: NetworkImage(actu.pictures[index]),
                              fit: BoxFit.cover)
                          : null,
                    ),
                    child: actu.assetPictures != null
                        ? AssetImageViewer(asset: actu.assetPictures[index])
                        : null,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                actu.description,
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
                    icon: CurrentUserImage(
                      //user: AppState.userState.currentUser,
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

class UserImage extends StatelessWidget {
  final double radius;
  final UserModel user;

  const UserImage({Key key, this.radius = 30.0, @required this.user})
      : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String link = user.pictureLink;
    File local = user.localPicture;
    ImageProvider picture;
    if (local != null) {
      picture = FileImage(local);
    } else {
      if (link.isNotEmpty) {
        picture = NetworkImage(link);
      } else {
        return CircleAvatar(
          child: Icon(
            Icons.person,
            size: radius,
          ),
          radius: radius,
        );
      }
    }
    return Container(
      child: CircleAvatar(
        radius: radius,
        backgroundImage: picture,
      ),
    );
  }
}

class CurrentUserImage extends StatelessWidget {
  final double radius;
  final bool editable;

  const CurrentUserImage({Key key, this.radius = 30, this.editable = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocBuilder(
        bloc: bloc,
        builder: (context, AuthenticationState state) {
          if (state is AuthenticationAuthenticated) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Stack(
                children: <Widget>[
                  UserImage(
                    user: state.user,
                    radius: radius,
                  ),
                  if (state is ChangingPicture)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  if (editable)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: radius / 10 + 2,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: radius / 10,
                          child: Center(
                            child: IconButton(
                              padding: EdgeInsets.all(2),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return PictureSelect(
                                        onSelected: (img) {
                                          Navigator.pop(context);
                                          bloc.add(ChangePicture(image: img));
                                        },
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.edit,
                                size: radius / 10 + 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            );
          }

          return CircleAvatar(
            child: Text('No user'),
            radius: radius,
          );
        });
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
                  builder: (context) => ProfilePage(user: otherUser)));
        },
        child: CurrentUserImage(
          // user: AppState.userState.currentUser,
          radius: 15,
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

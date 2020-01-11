import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:btpp/Components/annonce.dart';
import 'package:btpp/Components/horizontalDivider.dart';
import 'package:btpp/Functions/Images.dart';
import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/App/imageViewer.dart';
import 'package:btpp/Pages/User/profile.dart';
import 'package:btpp/State/user.dart';
import 'package:btpp/api/chopper.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:photo_view/photo_view.dart';

class ActuPage extends StatefulWidget {
  @override
  _ActuPageState createState() => _ActuPageState();
}

class _ActuPageState extends State<ActuPage> {
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
    // super.build(context);
    return Scaffold(
      body: BlocListener<ActuBloc, ActuState>(
        bloc: actuBloc,
        listener: (context, state) {
          print(state);
          if (state is ActuFetchedState) {
            list = state.list;
          }
          if (state is ActuCreatedFailedState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content:
              Text("Impossible d'effectuer cette demande actuellement"),
              action: SnackBarAction(
                label: "fermer",
                onPressed: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                },
              ),
            ));
          }
        },
        child: BlocBuilder<ActuBloc, ActuState>(
            bloc: bloc,
            builder: (context, state) {
              return Stack(
                children: <Widget>[
                  CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        title: Text('Actualités'),
                        snap: true,
                        floating: true,
                      ),
                      SliverToBoxAdapter(
                        child: CreateActu(),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                                (context, index) =>
                                ActuTile(bloc.actus.isNotEmpty
                                    ? bloc.actus[index]
                                    : bloc.actus[index]),
                            childCount: bloc.actus.length,
                            addAutomaticKeepAlives: false),
                        // CreateActu(),
                      )
                    ],
                  ),
                  if (bloc.actus.length < 1)
                    Container(
                      //color: Colors.white54,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height - 200,
                      child: Center(
                        child: FittedBox(
                          child: Text('Aucune Realisation'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  if (state is ActuFetchingState &&
                      (list.isNotEmpty || bloc.actus != null))
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            margin: EdgeInsets.only(top: 100),
                            child: RefreshProgressIndicator()))
                ],
              );
            }),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Actualités'),
      ),
      body: BlocListener<ActuBloc, ActuState>(
        bloc: actuBloc,
        listener: (context, state) {
          print(state);
          if (state is ActuFetchedState) {
            list = state.list;
          }
          if (state is ActuCreatedFailedState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content:
              Text("Impossible d'effectuer cette demande actuellement"),
              action: SnackBarAction(
                label: "fermer",
                onPressed: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                },
              ),
            ));
          }
        },
        child: BlocBuilder<ActuBloc, ActuState>(
          bloc: bloc,
          builder: (context, state) {
            return CustomScrollView(
              slivers: <Widget>[
                // if (authBloc.currentUser.userType == UserType.travailleur)
                CreateActu(),
              ],
            );

            return Stack(
              children: <Widget>[
                ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (authBloc.currentUser.userType == UserType.travailleur)
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
                          if (state is ActuFetchedState ||
                              list.isNotEmpty ||
                              bloc.actus != null)
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: list.isNotEmpty
                                  ? (list?.length ?? 0)
                                  : (bloc.actus?.length ?? 0),
                              itemBuilder: (context, index) => ActuTile(
                                  list.isNotEmpty
                                      ? list[index]
                                      : bloc.actus[index]),
                            ),
                          if (state is ActuFetchingState &&
                              (list.isEmpty && bloc.actus == null))
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
                ),
                if (state is ActuFetchingState &&
                    (list.isNotEmpty || bloc.actus != null))
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          margin: EdgeInsets.only(top: 40),
                          child: RefreshProgressIndicator())),
              ],
            );
          },
        ),
      ),
    );
  }

//@override
// bool get wantKeepAlive => true;
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
              AnimatedContainer(
                height: createMode ? 364 : 65,
                decoration: BoxDecoration(
                  boxShadow: createMode
                      ? [
                          BoxShadow(
                              color: AppColor.basic,
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 0)),
                          //BoxShadow(color: AppColor.basic)
                        ]
                      : null,
                  color: Colors.white,
                ),
                duration: Duration(milliseconds: 600),
                margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    //if (!createMode)
                    !createMode
                        ? Material(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            createMode = true;
                          });
                        },
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 32,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              CurrentUserImage(
                                radius: 15,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Nouvelle Realisation')
                            ],
                          ),
                        ),
                      ),
                    )
                        : SizedBox.shrink(),
                    if (createMode)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Form(
                            key: formKey,
                            child: ListView(
                              shrinkWrap: true,
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
                                            (index) =>
                                            Stack(
                                              children: <Widget>[
                                                Container(
                                                  width: 60,
                                                  height: 80,
                                                  margin: EdgeInsets.all(8),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      var pic =
                                                      await images[index]
                                                          .getByteData();
                                                      var mem = pic.buffer
                                                          .asUint8List();
                                                      showFullMemoryImage(
                                                          context, mem,
                                                          key: images[index]
                                                              .hashCode);
                                                      //.memory(mem));
                                                    },
                                                    child: Hero(
                                                      tag: images[index]
                                                          .hashCode,
                                                      child: AssetThumb(
                                                        //key: GlobalKey(),
                                                        asset: images[index],
                                                        height: 80,
                                                        width: 80,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 5,
                                                  right: 5,
                                                  child: InkWell(
                                                    child: Icon(
                                                      Icons.delete_outline,
                                                      size: 12,
                                                      color: Colors.red,
                                                    ),
                                                    onTap: () {
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
                                          actu.assetPictures =
                                              List.from(images);
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
                addAutomaticKeepAlives: false,
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: actu.assetPictures == null
                    ? actu.pictures.length
                    : actu.assetPictures.length,
                itemBuilder: (context, index) => Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 4),
                      width: 600,
                      height: 900,
                      constraints: BoxConstraints(maxWidth: 250),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        //borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.black12,
                      ),
                      child: actu.assetPictures != null
                          ? ImageDisplay.asset2(actu.assetPictures[index])
                          : ImageDisplay.network(
                        mainUrl + '/' + actu.pictures[index],
                        useCache: false,
                      ),
                    ),
                  ],
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

class ImageDisplay extends StatelessWidget {
  const ImageDisplay.file(
    this.file, {
    Key key,
    this.asset,
    this.link,
    this.newAsset,
    this.memory,
    this.width,
    this.height,
    this.circularRadius,
    this.useCache,
    this.enableRefresh,
    this.fallback,
  })  : assert(file != null),
        super(key: key);

  const ImageDisplay.network(
    this.link, {
    Key key,
    this.asset,
    this.newAsset,
    this.memory,
    this.width,
    this.height,
    this.circularRadius,
    this.useCache = true,
    this.enableRefresh,
    this.fallback,
    this.file,
  })  : assert(link != null),
        super(key: key);

  const ImageDisplay.memory(
    this.memory, {
    Key key,
    this.asset,
    this.link,
    this.newAsset,
    this.width,
    this.height,
    this.circularRadius,
    this.useCache,
    this.enableRefresh,
    this.fallback,
    this.file,
  })  : assert(memory != null),
        super(key: key);

  const ImageDisplay.asset2(
    this.newAsset, {
    Key key,
    this.asset,
    this.link,
    this.memory,
    this.width,
    this.height,
    this.circularRadius,
    this.useCache,
    this.enableRefresh,
    this.fallback,
    this.file,
  })  : assert(newAsset != null),
        super(key: key);

  const ImageDisplay.asset(
    this.asset, {
    Key key,
    this.link,
    this.newAsset,
    this.memory,
    this.width,
    this.height,
    this.circularRadius,
    this.useCache,
    this.enableRefresh,
    this.fallback,
    this.file,
  })  : assert(asset != null),
        super(key: key);

  final String asset, link;
  final Asset newAsset;
  final Uint8List memory;
  final double width, height, circularRadius;
  final bool useCache;
  final bool enableRefresh;
  final Widget fallback;
  final File file;

  ImageProvider get imageProvider {
    if (file != null) {
      return FileImage(file);
    }
    if (memory != null) {
      return MemoryImage(memory);
    }
    if (asset != null) {
      return AssetImage(asset);
    }
    if (link != null) {
      return AdvancedNetworkImage(link, useDiskCache: useCache);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String key = (link ?? 'a') + Random().nextInt(5247785).toString();
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(circularRadius ?? 15.0),
      child: newAsset == null
          ? InkWell(
              onTap: () {
                if (link != null) showFullNetworkImage(context, link, key: key);
                if (file != null) showFullFileImage(context, file, key: key);
                if (memory != null)
                  showFullMemoryImage(context, memory, key: key);
              },
              child: Hero(
                tag: key,
                child: TransitionToImage(
                  image: imageProvider,
                  loadingWidgetBuilder: (_, double progress, __) {
                    return Center(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: (progress < 1) && (progress > 0)
                                ? progress
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  placeholder: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.refresh)),
                  ),
                  width: width,
                  height: height,
                  enableRefresh: enableRefresh ?? true,
                ),
              ),
            )
          : FittedBox(
              fit: BoxFit.cover,
              child: AssetImageViewer(
                asset: newAsset,
              ),
            ),
    );
  }
}

class ZoomableImage extends StatefulWidget {
  const ZoomableImage({@required this.url, this.tag, this.memory});

  const ZoomableImage.memory({this.url, this.tag, @required this.memory});

  final String url;
  final Object tag;
  final Uint8List memory;

  @override
  _ZoomableImageState createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  double top = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: top,
              //left: 155,
              child: GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PhotoView(
                    scaleStateChangedCallback: (scale) {
                      print(scale);
                    },
                    //tightMode: true,
                    backgroundDecoration:
                        BoxDecoration(color: Colors.transparent),
                    initialScale: widget.memory == null ? 1.0 : null,
                    heroAttributes: PhotoViewHeroAttributes(tag: widget.tag),
                    maxScale: PhotoViewComputedScale.covered,
                    //minScale: PhotoViewComputedScale.contained,
                    imageProvider: widget.memory == null
                        ? AdvancedNetworkImage(widget.url, useDiskCache: true)
                        : MemoryImage(widget.memory),
                  ),
                ),
                onVerticalDragUpdate: (val) {
                  //print(val);
                  setState(() {
                    top += val.delta.dy;
                  });
                },
                onVerticalDragEnd: (val) async {
                  print(top);
                  if ((top > -200) && (top < 0)) {
                    for (var i = top; i < 0; i += 5) {
                      await Future.delayed(Duration(microseconds: 1000));
                      if (!mounted) break;
                      setState(() {
                        top = i;
                      });
                    }
                  } else if ((top > 0) && (top < 200)) {
                    for (var i = top; i > 0; i -= 5) {
                      await Future.delayed(Duration(microseconds: 1000));
                      if (!mounted) break;
                      setState(() {
                        top = i;
                      });
                    }
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserImage extends StatefulWidget {
  final double radius;
  final UserModel user;
  final bool zoomable;

  const UserImage(
      {Key key, this.radius = 30.0, @required this.user, this.zoomable = false})
      : assert(user != null),
        super(key: key);

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  Widget child;
  UserModel user;
  ImageProvider picture;
  String link;
  File local;

  @override
  void didUpdateWidget(UserImage oldWidget) {
    if (oldWidget.user != widget.user) {
      user = widget.user;
      link = widget.user.pictureLink;
      local = widget.user.localPicture;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    user = widget.user;
    link = widget.user.pictureLink;
    local = widget.user.localPicture;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //super.build(context);
    child = null;
    if (local != null) {
      picture = FileImage(local);
    } else {
      if (link.isNotEmpty) {
        child = IconButton(
          onPressed: () {
            print('need to realoda');
            setState(() {
              authBloc.add(ReloadUser());
            });
          },
          iconSize: widget.radius,
          icon: Icon(
            Icons.person,
            //size: widget.radius,
          ),
        );
        picture = AdvancedNetworkImage(link, useDiskCache: false,
            loadingProgress: (p, u) {
              print('loading $p');
              setState(() {
                child = Stack(
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Center(
                      child: Text(
                        '${(p * 100).toInt()} %',
                        style: TextStyle(fontSize: 8),
                      ),
                    )
                  ],
                );
              });
            }, loadFailedCallback: () {
              setState(() {
                child = IconButton(
                  onPressed: () {
                    print('need to realoda');
                    setState(() {
                      authBloc.add(ReloadUser());
                    });
                  },
                  iconSize: widget.radius,
                  icon: Icon(
                    Icons.person,
                    //size: widget.radius,
                  ),
                );
              });
            }, loadedCallback: () {
              setState(() {
                child = null;
              });
            });
      } else {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.zoomable
                ? () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Aucune photo de profil'),
                      duration: Duration(seconds: 1),
                    ));
                  }
                : null,
            child: CircleAvatar(
              child: Icon(
                Icons.person,
                size: widget.radius,
              ),
              radius: widget.radius,
            ),
          ),
        );
      }
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (local != null && widget.zoomable)
            showFullMemoryImage(context, local.readAsBytesSync(), key: local);
          else if (widget.zoomable)
            showFullNetworkImage(context, link, key: link);
        },
        child: widget.zoomable
            ? Hero(
                tag: local == null ? link : local,
                child: CircleAvatar(
                  radius: widget.radius,
                  backgroundImage: picture,
                  child: child,
                ),
              )
            : CircleAvatar(
                radius: widget.radius,
                backgroundImage: picture,
                child: child,
              ),
      ),
    );
  }

/* @override
  bool get wantKeepAlive => true;*/
}

class CurrentUserImage extends StatefulWidget {
  final double radius;
  final bool editable;
  final bool zoomable;

  const CurrentUserImage(
      {Key key, this.radius = 30, this.editable = false, this.zoomable = false})
      : super(key: key);

  @override
  _CurrentUserImageState createState() => _CurrentUserImageState();
}

class _CurrentUserImageState extends State<CurrentUserImage> {
  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = authBloc;

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
                    key: GlobalKey(),
                    user: state.user,
                    radius: widget.radius,
                    zoomable: widget.zoomable,
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
                  if (widget.editable)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: widget.radius / 10 + 2,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: widget.radius / 10,
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
                                size: widget.radius / 10 + 2,
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
            radius: widget.radius,
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

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({this.builder}) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
        opacity: new CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String get barrierLabel => null;
}

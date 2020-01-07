import 'package:btpp/Components/recent-chats.dart';
import 'package:btpp/Components/recent-contacts.dart';
import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/State/index.dart';
import 'package:btpp/State/user.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  UserState userState = AppState.userState;
  AnimationController controller;

  UserModel currentUser = AppState.userState.currentUser;

  List<ChatModel> list = [];

  final ChatsBloc bloc = chatsBloc..add(ChatsFetch());

  bool hasInit = false;

  double top = 0;
  double left = 0;

  Animation<double> b;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    controller.forward();

    b = Tween<double>(begin: 0.3, end: 1).animate(CurvedAnimation(
        curve: Curves.bounceIn,
        reverseCurve: Curves.easeOut,
        parent: controller))
      ..addStatusListener((l) {
        if (l == AnimationStatus.completed) controller.reverse();
        if (l == AnimationStatus.dismissed) controller.forward();
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<ChatsBloc, ChatsState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is ChatsFetchingSuccess) {
          list = state.chats;
        }
        if (state is ChatsFetchingFailed) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Impossible de charger la list actuellement'),
          ));
        }
        if (!hasInit && bloc.initialState is ChatsFetchingSuccess) {
          list = bloc.list;
        }
        hasInit = true;
      },
      child: BlocBuilder<ChatsBloc, ChatsState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ChatsFetchingState)
            return AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget child) {
                return Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.all(Tween<double>(begin: 0, end: 34)
                      .animate(controller)
                      .value),
                  child: Center(
                    child: Transform.scale(
                      scale: b.value,
                      child: Transform.rotate(
                        angle: Tween<double>(begin: -0.5, end: 0.5)
                            .animate(controller)
                            .value,
                        child: Text(
                          'Chargement ...',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );

          return Container(
            color: AppColor.primaryColor,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      // iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () {
                        // Navigator.pushNamed(context, 'app');
                      },
                    )
                  ],
                  pinned: true,
                  expandedHeight: 220,
                  title: Text(
                    'Conversations',
                    style: TextStyle(
                      // fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              RecentContacts(list.take(5).toList())
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    RecentChats(
                      chats: list,
                    ),
                  ]),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

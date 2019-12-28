export 'authentication_bloc.dart';
export 'authentication_event.dart';
export 'authentication_state.dart';
export 'login_bloc.dart';
export 'login_event.dart';
export 'login_state.dart';
export 'annonces_bloc.dart';
export 'annonces_event.dart';
export 'annonces_state.dart';
export 'chats_bloc.dart';
export 'chats_event.dart';
export 'chats_state.dart';
export 'actu_bloc.dart';
export 'actu_event.dart';
export 'actu_state.dart';

import 'package:btpp/bloc/actu_bloc.dart';
import 'package:btpp/bloc/chats_bloc.dart';

import 'login_bloc.dart';

import 'annonces_bloc.dart';

import 'authentication_bloc.dart';

AnnoncesBloc annoncesBloc = AnnoncesBloc();
AuthenticationBloc authBloc = AuthenticationBloc();
LoginBloc loginBloc = LoginBloc(authenticationBloc: authBloc);
ActuBloc actuBloc = ActuBloc();
ChatsBloc chatsBloc = ChatsBloc();

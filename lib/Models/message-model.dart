import 'package:btpp/Models/user-model.dart';

class Message {
  final User1 sender;
  final String time;
  final String text;
  final bool unread;

  Message({this.sender, this.time, this.text, this.unread});
}

final User1 currentUser1 =
    User1(id: 0, name: 'Hiro Hamada', imageUrl: 'assets/profile/image-12.png');

final User1 richard = User1(
    id: 1, name: 'Richard Ricardo', imageUrl: 'assets/profile/image-1.png');

final User1 angela = User1(
    id: 2, name: 'Angela Micheal', imageUrl: 'assets/profile/image-6.png');

final User1 tom =
    User1(id: 3, name: 'Tom Cruise', imageUrl: 'assets/profile/image-10.png');
final User1 mike =
    User1(id: 4, name: 'Mike Jason', imageUrl: 'assets/profile/image-50.png');
final User1 luke =
    User1(id: 5, name: 'Luke Cruise', imageUrl: 'assets/profile/image-19.png');
final User1 steff =
    User1(id: 6, name: 'Steff Dolote', imageUrl: 'assets/profile/image-41.png');
final User1 ela =
    User1(id: 7, name: 'Ela Cruise', imageUrl: 'assets/profile/image-8.png');

List<User1> recents = [richard, angela, tom, mike, luke, steff, ela];
List<Message> recentsChat = [
  Message(sender: richard, time: '7 h 00', text: 'Salut Hiro', unread: true),
  Message(
      sender: angela,
      time: '12 h 33',
      text: 'What about our dinner tonight ?',
      unread: true),
  Message(
      sender: mike,
      time: '00 h 33',
      text: 'I Had an accident tonight',
      unread: false),
  Message(
      sender: currentUser1,
      time: '12 h 33',
      text: 'Ok no problem',
      unread: false),
  Message(
      sender: steff, time: '10 h 13', text: 'He\'s not around', unread: true)
];

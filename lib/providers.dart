import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> provider = [...independentProvider];
List<SingleChildWidget> independentProvider = [
  ListenableProvider<FirebaseService>(create: (_) => FirebaseService()),
  Provider<MessageService>(
    create: (_) => MessageService(),
    lazy: true,
  ),
  ListenableProvider<ConnectionService>(create: (_) => ConnectionService()),
  Provider<S>(
    create: (_) => S(),
    lazy: true,
  ),
];

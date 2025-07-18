import 'package:controller_emulator_client/handlers/connection_page_handler.dart';
import 'package:controller_emulator_client/handlers/udp_handler.dart';
import 'package:controller_emulator_client/types/connection_arguments.dart';
import 'package:flutter/material.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});
  static const routeName = "/connection";
  static var connection = ConnectionHandler();
  static var connectionState = Connection.disconnected;
  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(
          backgroundColor: Colors.black38,
          title:
              const Text("PhonePad", style: TextStyle(color: Colors.white70)),
          leading: null,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/config");
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white70,
                ))
          ],
        ),
        body: FutureBuilder(
            future: ConnectionHandler.udp,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }

              final connectionPageHandler =
                  ConnectionPageHandler(ConnectionPage.connection);

              final conn = connectionPageHandler
                  .tryConnection(ConnectionPage.connectionState);
              return FutureBuilder(
                  future: conn,
                  builder: (context, connSnapshot) {
                    void handleConnection() {
                      setState(() {
                        switch (ConnectionPage.connectionState) {
                          case Connection.disconnected:
                            ConnectionPage.connectionState = Connection.trying;
                            break;
                          case Connection.trying:
                            ConnectionPage.connectionState =
                                Connection.disconnected;
                            break;
                          case Connection.connected:
                            break;
                          default:
                            ConnectionPage.connectionState =
                                Connection.disconnected;
                            break;
                        }
                      });
                    }

                    if (connSnapshot.connectionState == ConnectionState.done) {
                      if (connSnapshot.data! == Connection.connected) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamed(context, "/controller",
                                  arguments: ConnectionArguments(
                                      connectionHandler:
                                          ConnectionPage.connection))
                              .then((value) async {
                            setState(() {
                              ConnectionPage.connectionState =
                                  Connection.disconnected;
                              ConnectionPage.connection.disconnect();
                            });
                          });
                        });
                      }
                    }

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: handleConnection,
                              child: connSnapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      ConnectionPage.connectionState ==
                                          Connection.trying
                                  ? const Text("Connecting...")
                                  : const Text("Start")),
                        ],
                      ),
                    );
                  });
            }));
  }
}

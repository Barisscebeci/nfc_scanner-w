import 'dart:async';
import 'dart:typed_data';
import 'package:nfc_manager/nfc_manager.dart';

enum NFCStatus { none, reading, read, stopped, error, writing }

class NfcData {
  final String id;
  final String content;
  final String error;
  final NFCStatus status;

  NfcData({
    required this.id,
    required this.content,
    required this.error,
    required this.status,
  });

  factory NfcData.fromTag(NfcTag tag) {
    print('NfcData.fromTag called with tag: $tag');
    print('Tag data: ${tag.data}');
    
    NFCStatus status = NFCStatus.reading;
    final ndef = Ndef.from(tag);
    print('Ndef from tag: $ndef');

    final id = tag.data['nfctag'] != null && tag.data['nfctag']['id'] != null
        ? tag.data['nfctag']['id'].toString()
        : 'Unknown ID';
    print('Tag ID: $id');

    Uint8List contentBytes = Uint8List(0);
    if (ndef != null) {
      print('Ndef is not null');
      if (ndef.cachedMessage != null) {
        print('CachedMessage is not null');
        if (ndef.cachedMessage!.records.isNotEmpty) {
          print('Records are not empty');
          contentBytes = ndef.cachedMessage!.records.first.payload;
        } else {
          print('Records are empty');
        }
      } else {
        print('CachedMessage is null');
      }
    } else {
      print('Ndef is null');
    }
    print('Content bytes: $contentBytes');

    final content = String.fromCharCodes(contentBytes);
    print('Content: $content');

    return NfcData(
      id: id,
      content: content,
      error: '',
      status: status,
    );
  }
}

class NfcService {
  static Future<NfcData> stop() async {
    await NfcManager.instance.stopSession();
    return NfcData(id: '', content: '', error: '', status: NFCStatus.stopped);
  }

  static Future<NfcData> read() async {
    final completer = Completer<NfcData>();
    try {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        try {
          print('NFC tag discovered: $tag');
          final result = NfcData.fromTag(tag);
          completer.complete(result);
        } catch (e) {
          print('Error processing NFC tag: $e');
          completer.completeError('NFC okuma hatası: $e');
        } finally {
          NfcManager.instance.stopSession();
        }
      });
    } catch (e) {
      print('Error starting NFC session: $e');
      completer.completeError('NFC oturumu başlatma hatası: $e');
    }
    return completer.future;
  }

  static Future<NfcData> write(String path, String label) async {
    final completer = Completer<NfcData>();
    try {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        try {
          var ndef = Ndef.from(tag);
          if (ndef == null || !ndef.isWritable) {
            completer.complete(NfcData(
                id: '', content: '', error: 'Tag is not ndef writable', status: NFCStatus.error));
            NfcManager.instance.stopSession(errorMessage: 'Tag is not ndef writable');
            return;
          }

          NdefMessage message = NdefMessage([
            NdefRecord.createText(label),
          ]);

          await ndef.write(message);
          final id = tag.data['nfctag'] != null && tag.data['nfctag']['id'] != null
              ? tag.data['nfctag']['id'].toString()
              : 'Unknown ID';
          completer.complete(NfcData(id: id, content: 'Success to "Ndef Write"', error: '', status: NFCStatus.writing));
        } catch (e) {
          completer.complete(NfcData(id: '', content: '', error: e.toString(), status: NFCStatus.error));
        } finally {
          NfcManager.instance.stopSession();
        }
      });
    } catch (e) {
      print('Error starting NFC session for write: $e');
      completer.completeError('NFC yazma oturumu başlatma hatası: $e');
    }
    return completer.future;
  }
}
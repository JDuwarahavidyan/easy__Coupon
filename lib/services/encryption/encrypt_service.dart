import 'package:encrypt/encrypt.dart';

class EncryptionService {
  final Key key;
  final IV iv;

  EncryptionService(String encryptionKey, String encryptionIV)
      : key = Key.fromUtf8(encryptionKey),
        iv = IV.fromUtf8(encryptionIV);

  String encrypt(String text) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  String decrypt(String text) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt64(text, iv: iv);
    return decrypted;
  }
}

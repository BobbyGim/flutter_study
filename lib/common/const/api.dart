import 'dart:io';

const ios = "http://127.0.0.1:3000";

const emulator = "http://10.0.0.2";

final baseUrl = Platform.isIOS ? ios : emulator;

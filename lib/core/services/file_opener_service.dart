import 'dart:io';

class FileOpenerService {
  const FileOpenerService();

  Future<void> open(String path) async {
    await Process.run(
      'xdg-open',
      <String>[path],
    );
  }
}

@override
Future<void> moveFiles({
  required List<String> sourcePaths,
  required String destinationPath,
}) async {
  for (final sourcePath in sourcePaths) {
    final source = File(sourcePath);

    if (!await source.exists()) continue;

    final destination =
        p.join(destinationPath, p.basename(sourcePath));

    await source.rename(destination);
  }
@override
Future<void> moveFiles({
  required List<String> sourcePaths,
  required String destinationPath,
}) async {
  for (final sourcePath in sourcePaths) {
    final source = File(sourcePath);

    if (!await source.exists()) {
      continue;
    }

    final destination = p.join(
      destinationPath,
      p.basename(sourcePath),
    );

    await source.rename(destination);
  }
}
}

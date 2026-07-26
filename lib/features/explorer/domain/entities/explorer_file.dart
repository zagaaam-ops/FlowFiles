class ExplorerFile {
  const ExplorerFile({
    required this.name,
    required this.path,
    required this.extension,
    required this.size,
    required this.modified,
    this.isHidden = false,
  });

  final String name;
  final String path;
  final String extension;
  final int size;
  final DateTime modified;
  final bool isHidden;
}

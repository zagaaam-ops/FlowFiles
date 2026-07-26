class ExplorerFolder {
  const ExplorerFolder({
    required this.name,
    required this.path,
    this.isFavorite = false,
    this.isPinned = false,
  });

  final String name;
  final String path;
  final bool isFavorite;
  final bool isPinned;
}

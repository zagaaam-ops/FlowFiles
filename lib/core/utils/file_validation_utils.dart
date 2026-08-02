class FileValidationUtils {
  const FileValidationUtils._();

  static bool nameExists(
    Iterable<String> existingNames,
    String candidate,
  ) {
    final normalized = candidate.trim().toLowerCase();

    return existingNames.any(
      (name) => name.trim().toLowerCase() == normalized,
    );
  }
}

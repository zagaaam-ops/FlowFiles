import 'package:flutter/material.dart';

class FileIconUtils {
  FileIconUtils._();

  static IconData getIcon({
    required bool isDirectory,
    required String extension,
  }) {
    if (isDirectory) {
      return Icons.folder;
    }

    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;

      case 'doc':
      case 'docx':
        return Icons.description;

      case 'xls':
      case 'xlsx':
      case 'csv':
        return Icons.table_chart;

      case 'ppt':
      case 'pptx':
        return Icons.slideshow;

      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'webp':
        return Icons.image;

      case 'mp4':
      case 'avi':
      case 'mov':
      case 'mkv':
        return Icons.movie;

      case 'mp3':
      case 'wav':
      case 'aac':
      case 'flac':
        return Icons.music_note;

      case 'zip':
      case 'rar':
      case '7z':
      case 'tar':
        return Icons.archive;

      case 'dart':
      case 'java':
      case 'kt':
      case 'cpp':
      case 'c':
      case 'h':
      case 'py':
      case 'js':
      case 'ts':
      case 'html':
      case 'css':
      case 'json':
      case 'xml':
      case 'yaml':
      case 'yml':
        return Icons.code;

      case 'apk':
        return Icons.android;

      case 'exe':
        return Icons.computer;

      case 'txt':
      case 'md':
        return Icons.article;

      default:
        return Icons.insert_drive_file;
    }
  }
}

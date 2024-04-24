library preview_file;

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:path/path.dart' show extension;

/// A Calculator.
class FilePreview {
  FilePreview({
    this.filePath,
    this.fileUrl,
    this.width,
  });

  final String? filePath;
  final String? fileUrl;
  final double? width;

  static Future<Widget> _generatePdfImage(
      String filePath, double? width) async {
    try {
      final document = await PdfDocument.openFile(filePath);
      final page = await document.getPage(1);
      final image = await page.render(
        width: width ?? 80,
        height: width ?? 80 * 1.5,
      );
      return image != null
          ? Image.memory(image.bytes)
          : SizedBox(
              width: width ?? 100,
              child: const Icon(
                Icons.file_open,
                color: Colors.black,
              ),
            );
    } catch (e) {
      return SizedBox(
        width: width ?? 100,
        child: const Icon(
          Icons.file_open,
          color: Colors.black,
        ),
      );
    }
  }

  static Future<Widget> _showImage(String filePath, double? width) async {
    switch (extension(filePath.toLowerCase())) {
      case '.pdf':
        return FutureBuilder<Widget>(
            future: _generatePdfImage(filePath, width ?? 100),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SizedBox(
                height: width ?? 100 * 1.5,
                width: width ?? 100,
                child: snapshot.data!,
              );
            });
      case '.png':
      case '.jpg':
      case '.jpeg':
      case '.gif':
        return SizedBox(width: width ?? 100, child: Image.file(File(filePath)));
      default:
        return SizedBox(
          width: width ?? 100,
          child: const Icon(
            Icons.file_open,
            color: Colors.black,
          ),
        );
    }
  }

  static Future<Widget> _downloadFile(String fileUrl, double? width) async {
    final dio = Dio();
    final dir = Directory.systemTemp;
    int random = Random().nextInt(1000000);
    await dio.download(
        fileUrl, '${dir.path}/fileTemp$random${extension(fileUrl)}');

    if (File('${dir.path}/fileTemp$random${extension(fileUrl)}').existsSync()) {
      return FutureBuilder<Widget>(
          future: _showImage(
              '${dir.path}/fileTemp$random${extension(fileUrl)}', width ?? 100),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data!;
          });
    } else {
      return SizedBox(
        width: width ?? 100,
        child: const Icon(
          Icons.file_download_off,
          color: Colors.black,
        ),
      );
    }
  }

  Widget preview() {
    if (filePath == null && fileUrl == null) {
      return SizedBox(
        width: width ?? 100,
        child: const Icon(Icons.image_not_supported),
      );
    } else if (fileUrl != null) {
      return FutureBuilder<Widget>(
          future: _downloadFile(fileUrl!, width ?? 100),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox(
              height: width ?? 100 * 1.5,
              width: width ?? 100,
              child: snapshot.data!,
            );
          });
    } else {
      if (File(filePath!).existsSync()) {
        return FutureBuilder<Widget>(
            future: _showImage(filePath!, width ?? 100),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return snapshot.data!;
            });
      }
    }
    return SizedBox(
      width: width ?? 100,
      child: const Icon(
        Icons.file_open,
        color: Colors.black,
      ),
    );
  }
}

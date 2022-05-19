import 'dart:io';

import 'package:album/infrastructure/services/precache/resolution.dart';
import 'package:codux/codux.dart';

import 'package:flutter/material.dart';

class PrecacheService {
  Future<String> fromNetwork(
    String uri, {
    Resolution resolution = Resolution.xxhdpi,
  }) async {
    final suffix = _getSuffix(resolution);

    final object = "$uri$suffix";

    await precacheImage(NetworkImage(object), requireContext());

    return object;
  }

  Future<File> fromFile(File file) async {
    await precacheImage(FileImage(file), requireContext());

    return file;
  }

  String _getSuffix(Resolution resolution) {
    switch (resolution) {
      case Resolution.mdpi:
        return "/mdpi";
      case Resolution.xhdpi:
        return "/xhdpi";
      case Resolution.xxhdpi:
        return "/xxhdpi";
    }
  }
}

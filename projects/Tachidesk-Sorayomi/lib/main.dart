// Copyright (c) 2022 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/features/about/presentation/about/controllers/about_controller.dart';
import 'src/global_providers/global_providers.dart';
import 'src/sorayomi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final packageInfo = await PackageInfo.fromPlatform();
  final sharedPreferences = await SharedPreferences.getInstance();

  final Directory? appDirectory;
  if (!kIsWeb) {
    final appDocDirectory = await getApplicationDocumentsDirectory();
    appDirectory = Directory(path.join(appDocDirectory.path, 'Sorayomi'));

    await appDirectory.create(recursive: true);

    final cacheFiles = ['dio_cache.hive', 'dio_cache.lock'];
    for (final cacheFile in cacheFiles) {
      final oldCacheFilePath = path.join(appDocDirectory.path, cacheFile);
      final newCacheFilePath = path.join(appDirectory.path, cacheFile);

      if (!(await File(newCacheFilePath).exists()) &&
          await File(oldCacheFilePath).exists()) {
        await File(oldCacheFilePath).rename(newCacheFilePath);
      }
    }
  } else {
    appDirectory = null;
  }

  SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(
    ProviderScope(
      overrides: [
        packageInfoProvider.overrideWithValue(packageInfo),
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        appDirectoryProvider.overrideWithValue(appDirectory),
      ],
      child: const Sorayomi(),
    ),
  );
}

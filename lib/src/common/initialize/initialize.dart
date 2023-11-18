import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:products_app/src/features/widget/controller/controller.dart';

import '../storage/storage.dart';
import 'dependencies.dart';

Future<Dependencies>? _initializeApp;

Future<Dependencies> $initializeApp({
  void Function(int percent, String message)? onProgress,
  FutureOr<void> Function(Dependencies dependencies)? onSuccess,
  void Function(Object error, StackTrace stackTrace)? onError,
}) =>
    _initializeApp ??= Future<Dependencies>(
      () async {
        try {
          final dependencies = MutableDependencies();

          int totalSteps = _initializationSteps.length;
          int currentStep = 0;

          for (final step in _initializationSteps) {
            currentStep++;

            final percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
            onProgress?.call(percent, step.$1);

            await step.$2(dependencies);
          }

          final immutableDependencies = dependencies.freeze();

          await onSuccess?.call(immutableDependencies);
          return immutableDependencies;
        } catch (error, stackTrace) {
          onError?.call(error, stackTrace);
          rethrow;
        } finally {
          _initializeApp = null;
        }
      },
    );

final List<(String, FutureOr<void> Function(MutableDependencies dependencies))>
    _initializationSteps = [
  (
    'Initializing databases',
    (dependencies) async {
      $secureStorage = const FlutterSecureStorage();
      $products=Product();
    },
  ),
  (
    'Initializing Notes',
    (dependencies) async {
      $products.getProducts();
    }
  ),
];

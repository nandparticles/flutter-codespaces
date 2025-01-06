// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updates_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updatesRepositoryHash() => r'7137ec4e542f1b7b9e5f9d74abcc570b100530d0';

/// See also [updatesRepository].
@ProviderFor(updatesRepository)
final updatesRepositoryProvider =
    AutoDisposeProvider<UpdatesRepository>.internal(
  updatesRepository,
  name: r'updatesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updatesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpdatesRepositoryRef = AutoDisposeProviderRef<UpdatesRepository>;
String _$updateSummaryHash() => r'cd04991640fe6971183b65daf9e45e9445205800';

/// See also [updateSummary].
@ProviderFor(updateSummary)
final updateSummaryProvider = AutoDisposeFutureProvider<UpdateStatus?>.internal(
  updateSummary,
  name: r'updateSummaryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateSummaryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpdateSummaryRef = AutoDisposeFutureProviderRef<UpdateStatus?>;
String _$updatesSocketHash() => r'714e545daee4dc279babf3b72e9c1c5a4f8934e5';

/// See also [UpdatesSocket].
@ProviderFor(UpdatesSocket)
final updatesSocketProvider =
    AutoDisposeStreamNotifierProvider<UpdatesSocket, UpdateStatus>.internal(
  UpdatesSocket.new,
  name: r'updatesSocketProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updatesSocketHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdatesSocket = AutoDisposeStreamNotifier<UpdateStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

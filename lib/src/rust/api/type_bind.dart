// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'mirrors.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// These functions are ignored because they are not marked as `pub`: `get_inner`, `get_inner`, `get_mut_ref`, `get_mut_ref`, `get_ref`, `get_ref`, `new`, `new`, `new`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `fmt`, `fmt`, `fmt`

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<MusicAggregatorW>>
abstract class MusicAggregatorW implements RustOpaqueInterface {
  Future<void> addMusic({required MusicW music});

  bool belongTo({required MusicW music});

  MusicAggregatorW clone();

  Future<(MusicListW, List<MusicAggregatorW>)> fetchAlbum(
      {required int page, required int limit});

  Future<String> fetchLyric();

  Future<List<MusicW>> fetchMusics({required List<String> sources});

  List<MusicW> getAllMusics();

  List<MusicW> getAllMusicsOwned();

  List<String> getAvailableSources();

  MusicW getDefaultMusic();

  String getDefaultSource();

  Future<MusicW?> getMusic({required String source});

  PlatformInt64 getMusicId();

  bool matchFilter({required MusicFuzzFilter filter});

  Future<void> setDefaultSource({required String source});

  @override
  String toString();
}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<MusicListW>>
abstract class MusicListW implements RustOpaqueInterface {
  Future<List<MusicAggregatorW>> fetchAllMusicAggregators(
      {required int pagesPerBatch, required int limit});

  Future<List<MusicAggregatorW>> getMusicAggregators(
      {required int page, required int limit});

  MusicListInfo getMusiclistInfo();

  String source();

  @override
  String toString();
}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<MusicW>>
abstract class MusicW implements RustOpaqueInterface {
  Future<(MusicListW, List<MusicAggregatorW>)> fetchAlbum(
      {required int page, required int limit});

  Future<String> fetchLyric();

  String getExtraInfo({required Quality quality});

  MusicInfo getMusicInfo();

  (String, String) getPrimaryKv();

  String source();

  @override
  String toString();
}

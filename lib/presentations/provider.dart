import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.freezed.dart';
part 'provider.g.dart';

@freezed
class BackgroundColorState with _$BackgroundColorState {
  const factory BackgroundColorState({
    @Default(Colors.white) Color color,
  }) = _BackgroundColorState;
}

@riverpod
class BackgroundColor extends _$BackgroundColor {
  @override
  BackgroundColorState build() {
    return const BackgroundColorState();
  }

  Future<void> changeColor() async {
    final color = switch (state.color) {
      Colors.white => Colors.blue,
      Colors.blue => Colors.green,
      Colors.green => Colors.red,
      Colors.red => Colors.white,
      _ => Colors.white,
    };

    // 10秒待つ
    await Future<void>.delayed(const Duration(seconds: 10));

    state = state.copyWith(color: color);
  }
}

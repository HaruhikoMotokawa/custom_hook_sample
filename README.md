# custom_hook_sample

Flutter + Riverpod + flutter_hooks を使ったカスタムフックとViewModelのサンプルです。

## 🎯 概要

- このプロジェクトでは、以下の3つのモーダル画面を例に、状態管理の方法を比較・学習できます：
 
 - 🔵 `BlueModal`: ViewModel（StateNotifier）とRiverpodを使用した実装
 - 🟠 `OrangeModal`: flutter_hooks によるカスタムフックと状態管理の組み合わせ
 - 🔴 `RedModal`: flutter_hooks による簡易的なカスタムフックのサンプル

## 🧱 技術スタック

- Flutter
- [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)
- [flutter_hooks](https://pub.dev/packages/flutter_hooks)

## 📂 構成

```
lib
├── presentations
│   ├── screen
│   │   └── home
│   │       ├── components
│   │       │   ├── blue
│   │       │   │   ├── modal.dart
│   │       │   │   ├── view_model.dart
│   │       │   │   ├── view_model.freezed.dart
│   │       │   │   └── view_model.g.dart
│   │       │   ├── orange
│   │       │   │   ├── _use_modal_controller.dart
│   │       │   │   └── modal.dart
│   │       │   └── red
│   │       │       └── modal.dart
│   │       └── screen.dart
│   ├── provider.dart
│   ├── provider.freezed.dart
│   └── provider.g.dart
└── main.dart
```

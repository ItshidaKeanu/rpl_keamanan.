import 'package:flutter/material.dart';
import 'dependency_injector.dart';

class DependencyScope extends InheritedWidget {
  final DependencyInjector dependencies;

  const DependencyScope({
    super.key,
    required this.dependencies,
    required super.child,
  });

  static DependencyInjector of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<DependencyScope>();

    assert(scope != null, 'DependencyScope tidak ditemukan');

    return scope!.dependencies;
  }

  @override
  bool updateShouldNotify(DependencyScope oldWidget) {
    return dependencies != oldWidget.dependencies;
  }
}
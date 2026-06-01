import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:kinetic_ui/commands/init.dart';
import 'package:kinetic_ui/commands/add.dart';
import 'package:kinetic_ui/commands/list.dart';
import 'package:kinetic_ui/commands/diff.dart';

void main(List<String> arguments) async {
  final runner =
      CommandRunner<void>(
          'kinetic',
          'kinetic_ui — Flutter UI component CLI (shadcn/ui style)',
        )
        ..addCommand(_InitCmd())
        ..addCommand(_AddCmd())
        ..addCommand(_ListCmd())
        ..addCommand(_DiffCmd());

  try {
    await runner.run(arguments);
  } on UsageException catch (e) {
    stderr.writeln(e);
    exit(64);
  }
}

class _InitCmd extends Command<void> {
  @override
  String get name => 'init';
  @override
  String get description =>
      'Initialize kinetic_ui in the current Flutter project';

  @override
  Future<void> run() => InitCommand().run();
}

class _AddCmd extends Command<void> {
  @override
  String get name => 'add';
  @override
  String get description => 'Add one or more components to the project';

  _AddCmd() {
    argParser.addFlag(
      'force',
      abbr: 'f',
      defaultsTo: false,
      help: 'Overwrite file if it already exists',
    );
  }

  @override
  Future<void> run() async {
    final names = argResults!.rest;
    if (names.isEmpty) {
      stderr.writeln('Usage: kinetic add <component> [component...]');
      exit(64);
    }
    await AddCommand().run(names, force: argResults!['force'] as bool);
  }
}

class _ListCmd extends Command<void> {
  @override
  String get name => 'list';
  @override
  String get description => 'View all components in the registry';

  _ListCmd() {
    argParser.addOption(
      'tag',
      abbr: 't',
      help: 'Filter by tag (e.g., form, overlay)',
    );
  }

  @override
  Future<void> run() => ListCommand().run(tag: argResults!['tag'] as String?);
}

class _DiffCmd extends Command<void> {
  @override
  String get name => 'diff';
  @override
  String get description => 'Compare local file vs registry (checksum)';

  @override
  Future<void> run() async {
    final args = argResults!.rest;
    if (args.length != 1) {
      stderr.writeln('Usage: kinetic diff <component>');
      exit(64);
    }
    await DiffCommand().run(args.first);
  }
}

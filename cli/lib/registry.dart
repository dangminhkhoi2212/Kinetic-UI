import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class RegistryClient {
  final http.Client _http;

  RegistryClient({http.Client? client}) : _http = client ?? http.Client();

  Future<Map<String, dynamic>> fetchIndex() async {
    final uri = Uri.parse('$registryBaseUrl/registry.json');
    final res = await _http
        .get(uri)
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () =>
              throw RegistryException('Registry timeout. Check your network.'),
        );

    if (res.statusCode != 200) {
      throw RegistryException(
        'Failed to fetch registry (HTTP ${res.statusCode})',
      );
    }

    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<ComponentMeta> fetchMeta(String name) async {
    final uri = Uri.parse('$registryBaseUrl/components/$name/meta.json');
    final res = await _http.get(uri).timeout(const Duration(seconds: 10));

    if (res.statusCode == 404) {
      throw RegistryException(
        'Component "$name" does not exist in the registry.',
      );
    }
    if (res.statusCode != 200) {
      throw RegistryException(
        'Failed to fetch meta "$name" (HTTP ${res.statusCode})',
      );
    }

    return ComponentMeta.fromJson(jsonDecode(res.body));
  }

  Future<String> fetchFileContent(String relativePath) async {
    final uri = Uri.parse('$registryBaseUrl/$relativePath');
    final res = await _http.get(uri).timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw RegistryException('Failed to fetch file: $relativePath');
    }

    return res.body;
  }

  void dispose() => _http.close();
}

class ComponentMeta {
  final String name;
  final String description;
  final String version;
  final List<String> files;
  final List<String> pubDeps;
  final List<String> componentDeps;

  const ComponentMeta({
    required this.name,
    required this.description,
    required this.version,
    required this.files,
    required this.pubDeps,
    required this.componentDeps,
  });

  factory ComponentMeta.fromJson(Map<String, dynamic> json) => ComponentMeta(
    name: json['name'] as String,
    description: json['description'] as String,
    version: json['version'] as String,
    files: List<String>.from(json['files'] as List),
    pubDeps: List<String>.from((json['dependencies']?['pub'] as List?) ?? []),
    componentDeps: List<String>.from(
      (json['dependencies']?['components'] as List?) ?? [],
    ),
  );
}

class RegistryException implements Exception {
  final String message;
  const RegistryException(this.message);

  @override
  String toString() => message;
}

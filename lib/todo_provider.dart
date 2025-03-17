import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoProvider = StateProvider<List<String>>((ref) => []);
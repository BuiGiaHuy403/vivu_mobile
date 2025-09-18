
import 'package:flutter_dotenv/flutter_dotenv.dart';

sealed class Env{
  static String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
}
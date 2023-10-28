import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final supabaseUrl = dotenv.env['supabaseUrl']!;
final supabaseKey = dotenv.env['supabaseKey']!;


const String supabaseTableName = 'paths';
// Initialize Supabase client
final SupabaseClient supabaseClient = SupabaseClient(supabaseUrl, supabaseKey);

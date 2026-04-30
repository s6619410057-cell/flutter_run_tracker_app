import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  Future<List<Run>> getAllRun() async {
    final data = await _supabase
        .from('run_tb')
        .select('*');
    return data.map<Run>((e) => Run.fromJson(e)).toList();
  }

  Future insertRun(Run run) async {
    await _supabase.from('run_tb').insert(run.toJson());
  }
  Future updateRun(String id, Run run) async {
    await _supabase.from('run_tb').update(run.toJson()).eq('id', id);
  }
  Future deleteRun(String id) async {
    await _supabase.from('run_tb').delete().eq('id', id);
  }

  Future<void> delRun(String id) async {
    await _supabase.from('run_tb').delete().eq('id', id);
  }
}
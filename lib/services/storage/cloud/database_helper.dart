import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartnote/services/helper_function.dart';
import 'package:smartnote/services/storage/cloud/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class SupabaseDatabaseHelper {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // SupabaseDatabaseHelper(this.client);
  User? user = FirebaseAuth.instance.currentUser;

  Future<int> insertPath(Map<String, dynamic> path) async {
    await supabaseClient.from(supabaseTableName).insert(path).then((value) {
      print("Value: $value");
    }).onError((error, stackTrace) {
      print("Error in inserting path: $error");
    });

    return 1;
  }

  // Future<int> deletePath(String uid, int id) async {
  //   dynamic user = _auth.currentUser;
  //   final response = await supabaseClient
  //       .from(user!.uid)
  //       .delete()
  //       .eq('id', id)
  //       .then(((value) {
  //     print("Value: $value");
  //   }));

  //   if (response.error != null) {
  //     print("Error in deleting path: ${response.error}");
  //     return -1;
  //   }
  //   return 1;
  // }

  // Future<int> deleteAll(String uid) async {
  //   final response = await client.from(uid).delete().execute();
  //   if (response.error != null) {
  //     print("Error in deleting all paths: ${response.error}");
  //     return -1;
  //   }
  //   return 1;
  // }

  Future<List> getPaths() async {
    final response = await supabaseClient
        .from(supabaseTableName)
        .select()
        .eq('user_uid', retainAlphabetsOnly(user!.uid));

    // if (response == null) {
    //   print("Error fetching paths: ${response.error}");
    //   return [];
    // }

    // remove user_uid key from the list
    response.forEach((element) {
      element.remove('user_uid');
    });
    print("response: ${response}");
    return response;
  }
}

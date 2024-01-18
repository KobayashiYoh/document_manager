import 'package:document_manager/models/school.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signedInSchoolProvider =
    StateNotifierProvider<SignedInSchoolNotifier, School?>(
  (ref) => SignedInSchoolNotifier(),
);

class SignedInSchoolNotifier extends StateNotifier<School?> {
  SignedInSchoolNotifier() : super(null);

  bool get isSignedIn => state != null;

  void setSignedInSchool(School school) {
    state = school;
  }

  void reset() {
    state = null;
  }
}

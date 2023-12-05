import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smartnote/backend/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartnote/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import '../views/auth/mock.dart';

class MockAuthService extends Mock implements AuthService {
  final FirebaseAuth auth;

  MockAuthService(this.auth);

  @override
  Future<UserModel?> signUp(String name, String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final mockFirebaseUser = MockFirebaseUser();
      mockFirebaseUser.displayName = name;
      mockFirebaseUser.email = email;
      return UserModel(uid: 'mock-uid', displayName: name, email: email);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  @override
  Stream<UserModel?> get user => Stream.fromIterable(
      [UserModel(uid: 'mock-uid', email: 'mock@example.com')]);

  @override
  UserModel? get currentUser =>
      UserModel(uid: 'mock-uid', email: 'mock@example.com');
}

class MockUserModel extends Mock implements UserModel {}

class MockFirebaseUser extends Mock implements User {
  @override
  String get uid => 'mock-uid';
  String? _displayName;
  String? _email;

  @override
  String? get displayName => _displayName;

  set displayName(String? name) {
    _displayName = name;
  }

  @override
  String? get email => _email;

  // @override
  set email(String? value) {
    _email = value;
  }

  @override
  Future<void> updateDisplayName([String? name]) => Future.value();
}

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      super.noSuchMethod(
          Invocation.method(#createUserWithEmailAndPassword, [email, password]),
          returnValue: Future.value(MockUserCredential()));
}

void main() async {
  late MockFirebaseAuth mockAuth;
  late MockUserCredential mockCredential;
  late MockFirebaseUser mockFirebaseUser;
  late MockAuthService mockAuthService;
  late MockUserModel mockUserModel;

  late StreamController<UserModel?> authStateController;

  setupFirebaseAuthMocks();
  // Setup Firebase
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  group('Tests', () {
    setUp(() {
      mockAuth = MockFirebaseAuth();
      mockCredential = MockUserCredential();
      mockAuthService = MockAuthService(mockAuth);
      mockUserModel = MockUserModel();
      mockFirebaseUser = MockFirebaseUser();

      reset(mockAuth);
    });

    test('create account works', () async {
      // UserModel userModel = UserModel(email: "", uid: "");

      when(
        mockAuth.createUserWithEmailAndPassword(
          email: 'samuel@gmail.com',
          password: 'password123',
        ),
      ).thenAnswer((realInvocation) async => MockUserCredential());

      final result = await mockAuthService.signUp(
        'Samuel',
        'samuel@gmail.com',
        'password123',
      );

      verify(mockAuth.createUserWithEmailAndPassword(
              email: 'samuel@gmail.com', password: 'password123'))
          .called(1);

      // Expect that the result is not null and is a UserModel
      expect(result, isNotNull);
      expect(result, isA<UserModel>());

      print('Account creation works');
    });
  });
}

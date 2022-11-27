import 'dart:async';

import 'package:delivery_app/repositories/auth/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../models/user_model.dart';
import '../../repositories/user/user_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  final UserRepo _userRepo;
  StreamSubscription<auth.User?>? _authUserSubcription;
  StreamSubscription<User?>? _userSubcription;
  AuthBloc({required AuthRepo authRepo, required UserRepo userRepo})
      : _authRepo = authRepo,
        _userRepo = userRepo,
        super(const AuthState.unknown()) {
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthUserCreate>(_onAuthUserCreate);
    on<AuthSignUp>(_onAuthSignUp);
    _authUserSubcription = _authRepo.user.listen((authUser) {
      print("Auth user: $authUser");
      if (authUser != null) {
        _userRepo.getUser(authUser.uid).listen((user) {
          add(AuthUserChanged(authUser: authUser));
        });
      } else {
        add(AuthUserChanged(authUser: authUser));
      }
    });
  }

  Future<void> _onAuthUserChanged(
      AuthUserChanged event, Emitter<AuthState> emit) async {
    print("Loading");
    event.authUser != null
        ? emit(AuthState.authenticated(
            authUser: event.authUser!, user: event.user!))
        : emit(const AuthState.unauthenticated());
  }

  Future<void> _onAuthUserCreate(
      AuthUserCreate event, Emitter<AuthState> emit) async {
    if (state.authstatus == AuthStatus.unauthenticated) {
      final state = (this.state.authstatus == AuthStatus.unauthenticated)
          ? this.state
          : null;
      emit(
        AuthState.unauthenticated(
          name: event.name ?? state!.name,
          email: event.email ?? state!.email,
          password: event.password ?? state!.password,
        ),
      );
    }
  }

  Future<void> _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    if (state.authstatus == AuthStatus.unauthenticated) {
      try {
        await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        print("Created User");
      } catch (_) {}
    }
  }

  @override
  Future<void> close() async {
    _authUserSubcription?.cancel();
    _userSubcription?.cancel();
    return super.close();
  }
}

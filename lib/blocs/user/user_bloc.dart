import 'dart:async';
import 'package:delivery_app/models/user_model.dart';
import 'package:delivery_app/repositories/user/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo _userRepo;
  StreamSubscription? _userSubscription;
  UserBloc({required UserRepo userRepo})
      : _userRepo = userRepo,
        super(UserLoading()) {
    on<CreateUser>(_onCreateUser);
    on<GetUser>(_onGetUser);
    on<UpdateUser>(_onUpdateUser);
  }

  Future<void> _onCreateUser(CreateUser event, Emitter<UserState> emit) async {
    _userSubscription?.cancel();
  }

  Future<void> _onGetUser(GetUser event, Emitter<UserState> emit) async {}

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {}
}

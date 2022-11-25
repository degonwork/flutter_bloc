import 'dart:async';
import 'package:delivery_app/blocs/cart/cart_bloc.dart';
import 'package:delivery_app/blocs/payment/payment_bloc.dart';
import 'package:delivery_app/models/models.dart';
import 'package:delivery_app/models/payment_method_model.dart';
import 'package:delivery_app/repositories/checkout/checkout_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final CheckoutRepo _checkoutRepo;
  final PaymentBloc _paymentBloc;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _checkoutSubscription;
  StreamSubscription? _paymentSubscription;
  CheckoutBloc({
    required CartBloc cartBloc,
    required CheckoutRepo checkoutRepo,
    required PaymentBloc paymentBloc,
  })  : _cartBloc = cartBloc,
        _checkoutRepo = checkoutRepo,
        _paymentBloc = paymentBloc,
        super(cartBloc.state is CartLoaded
            ? CheckoutLoaded(
                products: (cartBloc.state as CartLoaded).cart.products,
                subTotal: (cartBloc.state as CartLoaded).cart.subTotalString,
                deliveryFee:
                    (cartBloc.state as CartLoaded).cart.deliveryFreeString,
                total: (cartBloc.state as CartLoaded).cart.totalString,
              )
            : CheckoutLoading()) {
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);

    _paymentSubscription = paymentBloc.stream.listen((state) {
      if (state is PaymentLoaded) {
        add(UpdateCheckout(paymentMethod: state.paymentMethod));
      }
    });
  }
  void _onUpdateCheckout(
      UpdateCheckout event, Emitter<CheckoutState> emit) async {
    if (state is CheckoutLoaded) {
      final state = this.state as CheckoutLoaded;
      emit(
        CheckoutLoaded(
            email: event.email ?? state.email,
            fullName: event.fullName ?? state.fullName,
            products: state.products,
            deliveryFee: state.deliveryFee,
            subTotal: state.subTotal,
            total: state.total,
            address: event.address ?? state.address,
            city: event.city ?? state.city,
            country: event.country ?? state.country,
            zipCode: event.zipCode ?? state.zipCode,
            paymentMethod: event.paymentMethod ?? state.paymentMethod),
      );
    }
  }

  void _onConfirmCheckout(
    ConfirmCheckout event,
    Emitter<CheckoutState> emit,
  ) async {
    _checkoutSubscription?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepo.addCheckout(event.checkout);
        print('Done');
        emit(CheckoutLoading());
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _paymentSubscription?.cancel();
    return super.close();
  }
}

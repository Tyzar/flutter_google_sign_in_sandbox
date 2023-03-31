import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_service_app/blocs/start_app/start_app_bloc.dart';
import 'package:login_service_app/containers/service_container.dart';
import 'package:login_service_app/services/auth_service.dart';
import 'package:login_service_app/views/widgets/overlays/snackbar.dart';
import 'package:provider/provider.dart';

class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StartAppBloc>(
        create: (context) =>
            StartAppBloc(ServiceContainer.instance.get<AuthService>())
              ..add(StartAppEvent.initialize()),
        child: BlocListener<StartAppBloc, StartAppState>(
            listener: _handleListener,
            child: const Scaffold(
              body: Center(
                child: Text(
                  'Sandbox App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 30),
                ),
              ),
            )));
  }

  void _handleListener(BuildContext context, StartAppState state) {
    if (state.allFinish) {
      state.checkSignInResult.fold(
          () => null,
          (result) => result.fold((error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(createSnackBar(message: error.errMsg));
              }, (isSigned) {
                if (isSigned) {
                  _goToHome(context);
                } else {
                  _goToSignIn(context);
                }
              }));
    }
  }

  void _goToHome(BuildContext context) {
    Navigator.of(context).popAndPushNamed('/home');
  }

  void _goToSignIn(BuildContext context) {
    Navigator.of(context).popAndPushNamed('/signIn');
  }
}

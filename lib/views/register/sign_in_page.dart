import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_service_app/blocs/sign_in/sign_in_bloc.dart';
import 'package:login_service_app/constants/assets_path.dart';
import 'package:login_service_app/containers/service_container.dart';
import 'package:login_service_app/services/auth_service.dart';
import 'package:login_service_app/views/widgets/overlays/snackbar.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInPageBloc>(
        create: (context) =>
            SignInPageBloc(ServiceContainer.instance.get<AuthService>()),
        child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                  child: BlocConsumer<SignInPageBloc, SignInPageState>(
                      listener: _handleSignInState,
                      builder: (context, state) => OutlinedButton(
                            onPressed: state.isLoading
                                ? null
                                : () => _doSignIn(context),
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.blue)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: Image.asset(icGoogle)),
                                const SizedBox(width: 8),
                                const Text('Sign in',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          )))),
        ));
  }

  void _doSignIn(BuildContext context) {
    context.read<SignInPageBloc>().add(SignInPageEvent.doSignIn());
  }

  void _handleSignInState(BuildContext context, SignInPageState state) {
    state.signInResult.fold(
        () => null,
        (result) => result.fold(
            (error) => ScaffoldMessenger.of(context)
                .showSnackBar(createSnackBar(message: error.errorMsg)),
            (r) => Navigator.of(context).popAndPushNamed('/home')));
  }
}

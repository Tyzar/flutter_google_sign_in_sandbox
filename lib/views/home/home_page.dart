import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_service_app/blocs/home/home_bloc.dart';
import 'package:login_service_app/containers/service_container.dart';
import 'package:login_service_app/services/auth_service.dart';
import 'package:login_service_app/views/widgets/overlays/snackbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (context) =>
            HomeBloc(ServiceContainer.instance.get<AuthService>())
              ..add(HomeEvent.initialize()),
        child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(30),
              child:
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                return state.getLoggedUserResult.fold(
                    () => const SizedBox(),
                    (result) => result.fold(
                        (error) => Center(
                              child: Text(error.errMsg),
                            ),
                        (userProfile) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: CircleAvatar(
                                      foregroundImage: userProfile.urlPhoto ==
                                              null
                                          ? null
                                          : NetworkImage(userProfile.urlPhoto!),
                                    )),
                                const SizedBox(height: 16),
                                Text(userProfile.name,
                                    style: const TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center),
                                const SizedBox(height: 8),
                                Text(
                                  userProfile.email,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 30),
                                BlocListener<HomeBloc, HomeState>(
                                    listenWhen: (pState, cState) =>
                                        pState.signOutResult !=
                                        cState.signOutResult,
                                    listener: _handleSignOutState,
                                    child: ElevatedButton(
                                        onPressed: () => _doSignOut(context),
                                        child: const Text('Sign Out')))
                              ],
                            )));
              })),
        ));
  }

  void _doSignOut(BuildContext context) {
    context.read<HomeBloc>().add(HomeEvent.signOut());
  }

  void _handleSignOutState(BuildContext context, HomeState state) {
    state.signOutResult.fold(
        () => null,
        (result) => result.fold(
            (error) => ScaffoldMessenger.of(context)
                .showSnackBar(createSnackBar(message: error.errMsg)),
            (r) => _goToSignPage(context)));
  }

  void _goToSignPage(BuildContext context) {
    Navigator.of(context).popAndPushNamed('/signIn');
  }
}

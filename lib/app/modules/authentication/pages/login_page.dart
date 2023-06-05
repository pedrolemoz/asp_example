import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/base_states.dart';
import '../reactivity/common/auth_common_states.dart';
import '../reactivity/login/login_actions.dart';
import '../reactivity/login/login_atoms.dart';
import '../reactivity/login/login_states.dart';
import '../widgets/input_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  OverlayEntry? entry;

  @override
  void initState() {
    super.initState();

    loginState.addListener(() {
      final isLoading = loginState.value is IProcessingState;

      if (isLoading) {
        entry = OverlayEntry(
          builder: (context) {
            return Container(
              color: Colors.black38,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );

        Overlay.of(context).insert(entry!);
      } else {
        if (entry != null) {
          entry!.remove();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    context.callback(
      () => loginState.value,
      (value) {
        if (value is SuccesfullyAuthenticatedUserState) {
          final userModel = value.userModel;
          final snackBar = SnackBar(
            content: Text(
              'Welcome, ${userModel.name}',
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (value is IErrorState) {
          const snackBar = SnackBar(content: Text('An error occurred'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );

    return RxBuilder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Login')),
          body: Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Enter your credentials',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 32),
                    InputText(
                      hintText: 'Email',
                      initialValue: loginEmailText.value,
                      onChanged: loginEmailText.setValue,
                      hasError: loginState.value is InvalidEmailState,
                      errorText: loginState.value is InvalidEmailState
                          ? (loginState.value as InvalidEmailState).description
                          : null,
                    ),
                    const SizedBox(height: 8),
                    InputText(
                      hideText: loginPasswordTextVisibility.value,
                      hintText: 'Password',
                      showVisibilityToggle: true,
                      onVisibilityToggle: toggleLoginPasswordVisibilityAction,
                      initialValue: loginPasswordText.value,
                      onChanged: loginPasswordText.setValue,
                      hasError: loginState.value is InvalidPasswordState,
                      errorText: loginState.value is InvalidPasswordState
                          ? (loginState.value as InvalidPasswordState)
                              .description
                          : null,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: loginWithCredentialsAction,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

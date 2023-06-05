import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/base_states.dart';
import '../reactivity/common/auth_common_states.dart';
import '../reactivity/registration/registration_actions.dart';
import '../reactivity/registration/registration_atoms.dart';
import '../reactivity/registration/registration_states.dart';
import '../widgets/input_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  OverlayEntry? entry;

  @override
  void initState() {
    super.initState();

    registrationState.addListener(() {
      final isLoading = registrationState.value is IProcessingState;

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
      () => registrationState.value,
      (value) {
        if (value is SuccesfullyRegisteredUserState) {
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
          appBar: AppBar(title: const Text('Registration')),
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
                        'Create your account',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 32),
                    InputText(
                      hintText: 'Name',
                      initialValue: registrationUserNameText.value,
                      onChanged: registrationUserNameText.setValue,
                      hasError: registrationState.value is InvalidUserNameState,
                      errorText: registrationState.value is InvalidUserNameState
                          ? (registrationState.value as InvalidUserNameState)
                              .description
                          : null,
                    ),
                    const SizedBox(height: 8),
                    InputText(
                      hintText: 'Email',
                      initialValue: registrationEmailText.value,
                      onChanged: registrationEmailText.setValue,
                      hasError: registrationState.value is InvalidEmailState,
                      errorText: registrationState.value is InvalidEmailState
                          ? (registrationState.value as InvalidEmailState)
                              .description
                          : null,
                    ),
                    const SizedBox(height: 8),
                    InputText(
                      hideText: registrationPasswordTextVisibility.value,
                      hintText: 'Password',
                      showVisibilityToggle: true,
                      onVisibilityToggle:
                          toggleRegistrationPasswordVisibilityAction,
                      initialValue: registrationPasswordText.value,
                      onChanged: registrationPasswordText.setValue,
                      hasError: registrationState.value is InvalidPasswordState,
                      errorText: registrationState.value is InvalidPasswordState
                          ? (registrationState.value as InvalidPasswordState)
                              .description
                          : null,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: registerNewUserAction,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Register',
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

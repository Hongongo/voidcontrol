import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import 'package:admin_dashboard/router/router.dart';
import '../../providers/providers.dart';
import '../buttons/buttons.dart';
import '../inputs/inputs.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(builder: (context) {
        final registerFormProvider =
            Provider.of<RegisterFormProvider>(context, listen: false);

        return Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 370),
              child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: registerFormProvider.formKey,
                  child: Column(
                    children: [
                      // Email
                      TextFormField(
                        onChanged: (value) => registerFormProvider.name = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'El nombre es obligatario';
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese su nombre',
                            label: 'Nombre',
                            icon: Icons.supervised_user_circle_sharp),
                      ),

                      SizedBox(height: 20),

                      // Email
                      TextFormField(
                        onChanged: (value) =>
                            registerFormProvider.email = value,
                        validator: (value) {
                          if (!EmailValidator.validate(value ?? ''))
                            return 'Email no válido';
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese su correo',
                            label: 'Email',
                            icon: Icons.email_outlined),
                      ),

                      SizedBox(height: 20),

                      // Password
                      TextFormField(
                        onChanged: (value) =>
                            registerFormProvider.password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Ingrese su contraseña';
                          if (value.length < 6)
                            return 'La contraseña debe de ser de 6 caracteres';

                          return null; // Válido
                        },
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: '*********',
                            label: 'Contraseña',
                            icon: Icons.lock_outline_rounded),
                      ),

                      SizedBox(height: 20),
                      CustomOutlinedButton(
                        onPressed: () {
                          final validForm = registerFormProvider.validateForm();
                          if (!validForm) return;

                          final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                          authProvider.register(
                              registerFormProvider.email,
                              registerFormProvider.password,
                              registerFormProvider.name);
                        },
                        text: 'Crear cuenta',
                      ),

                      SizedBox(height: 20),
                      LinkText(
                        text: 'Ir al login',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Flurorouter.loginRoute);
                        },
                      )
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}

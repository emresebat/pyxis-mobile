import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';
import '/resources/widgets/buttons/buttons.dart';

/* Signup Form
|--------------------------------------------------------------------------
| Usage: https://nylo.dev/docs/6.x/forms#how-it-works
| Casts: https://nylo.dev/docs/6.x/forms#form-casts
| Validation Rules: https://nylo.dev/docs/6.x/validation#validation-rules
|-------------------------------------------------------------------------- */

class SignupForm extends NyFormData {
  SignupForm({String? name}) : super(name ?? "signup");

  // @override
  // get init => () {
  //   /// Initial data for the form
  //   return {
  //     "name": "Anthony",
  //     "price": "100",
  //     "favourite_color": "Blue",
  //     "bio": "I am a Flutter Developer"
  //   };
  // };

  @override
  fields() => [
        Field.text("Name",
            autofocus: true,
            validate: FormValidator.notEmpty(),
            style: "compact"),
        Field.email("Email", validate: FormValidator.email(), style: "compact"),
        Field.password("Password",
            validate: FormValidator.password(strength: 1), style: "compact"),
      ];

  // @override
  // Widget? get submitButton => Button.primary(text: "Submit", submitForm: (this, (data) {
  //   print(['data', data]);
  // }));
}

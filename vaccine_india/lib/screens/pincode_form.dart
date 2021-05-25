import 'package:flutter/material.dart';

class PincodeForm extends StatefulWidget {
  @override
  _PincodeFormState createState() => _PincodeFormState();
}

class _PincodeFormState extends State<PincodeForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Pincode?',
              labelText: 'Pincode *',
            ),
            onSaved: (value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
              }
            },
            child: Text('Search'),
          ),
        ],
      ),
    );
  }
}

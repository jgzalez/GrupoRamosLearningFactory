import 'package:flutter/material.dart';

class EstablishmentRegistrationForm extends StatefulWidget {
  @override
  _EstablishmentRegistrationFormState createState() =>
      _EstablishmentRegistrationFormState();
}

class _EstablishmentRegistrationFormState
    extends State<EstablishmentRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  // Controladores de texto
  final TextEditingController _employeeCountController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  // ... otros controladores para cada campo

  @override
  void dispose() {
    _employeeCountController.dispose();
    _locationController.dispose();
    // ... dispose otros controladores
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Establecimiento')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _employeeCountController,
                decoration: InputDecoration(labelText: 'Cantidad de Empleados'),
                keyboardType: TextInputType.number,
                // Valida el campo
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la cantidad de empleados';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Ubicación'),
                // Valida el campo
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la ubicación';
                  }
                  return null;
                },
              ),
              // ... otros TextFormField para cada dato ...
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Procesa los datos del formulario
                    }
                  },
                  child: Text('Registrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

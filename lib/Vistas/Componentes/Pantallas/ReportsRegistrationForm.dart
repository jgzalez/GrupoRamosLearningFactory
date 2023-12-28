import 'package:flutter/material.dart';
import 'package:frontend/Modelos/Reports.dart';

class ReportsRegistrationForm extends StatefulWidget {
  final Report? reportToEdit;

  const ReportsRegistrationForm({Key? key, this.reportToEdit})
      : super(key: key);

  @override
  _ReportsRegistrationFormState createState() =>
      _ReportsRegistrationFormState();
}

class _ReportsRegistrationFormState extends State<ReportsRegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Reportes'),
      ),
      body: Center(
        child: Text(
          "Próximamente Solo en Cines",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

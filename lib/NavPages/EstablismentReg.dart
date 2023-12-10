import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class EstablishmentRegistrationForm extends StatefulWidget {
  @override
  _EstablishmentRegistrationFormState createState() =>
      _EstablishmentRegistrationFormState();
}

class _EstablishmentRegistrationFormState
    extends State<EstablishmentRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _employeeCountController =
      TextEditingController();
  final TextEditingController _operatingHoursController =
      TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _customerFlowController = TextEditingController();
  final TextEditingController _establishmentTypeController =
      TextEditingController();
  final TextEditingController _maxCapacityController = TextEditingController();
  final TextEditingController _foundationYearController =
      TextEditingController();
  // Considera usar controladores adicionales para archivos y otros campos

  // Variables para guardar los archivos seleccionados
  Map<String, PlatformFile> _selectedFiles = {};

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _employeeCountController.dispose();
    _operatingHoursController.dispose();
    _sizeController.dispose();
    _customerFlowController.dispose();
    _establishmentTypeController.dispose();
    _maxCapacityController.dispose();
    _foundationYearController.dispose();
    // Dispose otros controladores
    super.dispose();
  }

  Future<void> _pickFile(String key) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFiles[key] = result.files.first;
      });
    }
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
              buildTextFormField(_nameController, 'Nombre del Establecimiento'),
              buildTextFormField(_locationController, 'Ubicación Geográfica'),
              buildTextFormField(
                  _employeeCountController, 'Número de Empleados',
                  isNumeric: true),
              buildTextFormField(
                  _operatingHoursController, 'Horarios de Atención'),
              buildTextFormField(_sizeController, 'Tamaño del Establecimiento',
                  isNumeric: true),
              buildTextFormField(_customerFlowController, 'Flujo de Clientes',
                  isNumeric: true),
              buildTextFormField(
                  _establishmentTypeController, 'Tipo de Establecimiento'),
              buildTextFormField(_maxCapacityController, 'Aforo Máximo',
                  isNumeric: true),
              buildTextFormField(_foundationYearController, 'Año de Fundación',
                  isNumeric: true),

              // Campos para la selección de archivos
              filePickerField('Valoraciones de Clientes', 'customerRatings'),
              filePickerField('Número de Reseñas', 'reviewCount'),
              //... otros campos para archivos aquí

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Procesa los datos del formulario junto con los archivos seleccionados
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

  Widget buildTextFormField(TextEditingController controller, String label,
      {bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese $label';
        }
        return null;
      },
    );
  }

  Widget filePickerField(String label, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => _pickFile(key),
          child: Text('Seleccionar Archivo'),
        ),
        SizedBox(height: 8),
        Text(_selectedFiles[key]?.name ?? 'Ningún archivo seleccionado'),
      ],
    );
  }
}

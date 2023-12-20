import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend/Modelos/Establishment.dart'; // Asegúrate de que este import es correcto

class EstablishmentRegistrationForm extends StatefulWidget {
  final Establishment? establishmentToEdit;

  const EstablishmentRegistrationForm({Key? key, this.establishmentToEdit})
      : super(key: key);

  @override
  _EstablishmentRegistrationFormState createState() =>
      _EstablishmentRegistrationFormState();
}

class _EstablishmentRegistrationFormState
    extends State<EstablishmentRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _creationDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
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
  // ... otros controladores de texto para cada atributo

  // Variables para guardar los archivos seleccionados
  Map<String, PlatformFile> _selectedFiles = {};

  @override
  void initState() {
    super.initState();
    if (widget.establishmentToEdit != null) {
      // Llenar los controladores con los datos existentes para la edición
      _titleController.text = widget.establishmentToEdit!.title;
      _nameController.text = widget.establishmentToEdit!.name;
      _locationController.text = widget.establishmentToEdit!.geographicLocation;
      _imageController.text = widget.establishmentToEdit!.imageUrl;
      _authorController.text = widget.establishmentToEdit!.author;
      _creationDateController.text = widget.establishmentToEdit!.creationDate;
      _descriptionController.text = widget.establishmentToEdit!.description;
      // ... llenar otros controladores...
      _employeeCountController.text =
          widget.establishmentToEdit!.numberOfEmployees.toString();
      _operatingHoursController.text =
          widget.establishmentToEdit!.businessHours;
      _sizeController.text = widget.establishmentToEdit!.establishmentSize;
      _customerFlowController.text = widget.establishmentToEdit!.customerFlow;
      _establishmentTypeController.text =
          widget.establishmentToEdit!.typeOfEstablishment;
      _maxCapacityController.text =
          widget.establishmentToEdit!.maximumCapacity.toString();
      _foundationYearController.text =
          widget.establishmentToEdit!.foundationYear;

      // Si tienes controladores para archivos, puedes configurarlos aquí también
      // Por ejemplo, si guardas los nombres de los archivos en el objeto Establishment,
      // puedes asignar estos nombres a una variable de estado y mostrarlos en la interfaz de usuario.
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _nameController.dispose();
    _locationController.dispose();
    _employeeCountController.dispose();
    _operatingHoursController.dispose();
    _sizeController.dispose();
    _customerFlowController.dispose();
    _establishmentTypeController.dispose();
    _maxCapacityController.dispose();
    _foundationYearController.dispose();
    _authorController.dispose();
    _creationDateController.dispose();
    _descriptionController.dispose();
    // Dispose otros controladores de texto
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
              buildTextFormField(_titleController, 'Título'),
              buildTextFormField(_nameController, 'Nombre del Establecimiento'),
              buildTextFormField(
                  _descriptionController, 'Descripcion del Establecimiento'),
              buildTextFormField(_nameController, 'Nombre del Establecimiento'),
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
              filePickerField('Número de Reseñas', 'numberOfReviews'),
              filePickerField('Historial de Ventas', 'salesHistory'),
              filePickerField(
                  'Datos Demográficos de Clientes', 'customerDemographics'),
              filePickerField('Ingresos Anuales', 'annualRevenue'),
              filePickerField('Gastos Operativos', 'operationalExpenses'),
              filePickerField('Eventos Especiales', 'specialEvents'),
              filePickerField('Inventario de Productos/Servicios',
                  'inventoryOfProductsServices'),
              filePickerField(
                  'Impacto de Factores Estacionales', 'seasonalFactorsImpact'),
              filePickerField('Competencia Local', 'localCompetition'),
              filePickerField('Tendencias de Mercado', 'marketTrends'),
              // ... otros campos para archivos aquí ...

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _registerEstablishment();
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

  Future<void> _registerEstablishment() async {
    if (_formKey.currentState!.validate()) {
      // Aquí se recopilan los datos de los controladores de texto
      final establishmentData = Establishment(
          id: '',
          title: _titleController.text,
          name: _nameController.text,
          imageUrl: _imageController.text,
          geographicLocation: _locationController.text,
          author: _authorController.text,
          creationDate: _creationDateController.text,
          description: _descriptionController.text,
          numberOfEmployees: int.tryParse(_employeeCountController.text) ?? 0,
          businessHours: _operatingHoursController.text,
          establishmentSize: _sizeController.text,
          customerFlow: _customerFlowController.text,
          typeOfEstablishment: _establishmentTypeController.text,
          maximumCapacity: int.tryParse(_maxCapacityController.text) ?? 0,
          foundationYear: _foundationYearController.text

          // ... otros campos ...
          );

      // Lógica para manejar los archivos, si es necesario
      // Por ejemplo, subir archivos a un servidor y obtener URLs

      // Lógica para guardar 'establishmentData' en la base de datos
      // Por ejemplo, usando Firestore
      try {
        if (widget.establishmentToEdit == null) {
          // Crear un nuevo establecimiento
          await FirebaseFirestore.instance
              .collection('establecimientos')
              .add(establishmentData.toMap());
          // Mostrar mensaje de éxito o realizar acciones después de la creación
          Navigator.pop(context, true);
        } else {
          final updatedEstablishment = Establishment(
              id: widget.establishmentToEdit!.id, // Usa el 'id' existente
              title: _titleController.text,
              name: _nameController.text,
              imageUrl: _imageController.text,
              geographicLocation: _locationController.text,
              author: _authorController.text,
              creationDate: _creationDateController.text,
              description: _descriptionController.text,
              numberOfEmployees:
                  int.tryParse(_employeeCountController.text) ?? 0,
              businessHours: _operatingHoursController.text,
              establishmentSize: _sizeController.text,
              customerFlow: _customerFlowController.text,
              typeOfEstablishment: _establishmentTypeController.text,
              maximumCapacity: int.tryParse(_maxCapacityController.text) ?? 0,
              foundationYear: _foundationYearController.text);
          // Actualizar un establecimiento existente
          await FirebaseFirestore.instance
              .collection('establecimientos')
              .doc(updatedEstablishment
                  .id) // Asegúrate de tener un 'id' en Establishment
              .update(establishmentData.toMap());
          // Mostrar mensaje de éxito o realizar acciones después de la edición
          Navigator.pop(context, true);
        }
      } catch (e) {
        // Manejar errores
        print('Ocurrió un error: $e');
      }
    }
  }
}

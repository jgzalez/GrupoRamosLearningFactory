import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend/Modelos/Establishment.dart';

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
  final List<String> _categories = [
    'Tienda',
    'Híper'
  ]; // Opciones para el dropdown
  // Controladores de texto
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _creationDateController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  String _selectedCategory = 'Tienda'; // Valor inicial

  // Variables para guardar los archivos seleccionados
  Map<String, PlatformFile> _selectedFiles = {};

  @override
  void initState() {
    super.initState();
    if (widget.establishmentToEdit != null) {
      _titleController.text = widget.establishmentToEdit!.title;
      _locationController.text = widget.establishmentToEdit!.location;
      _descriptionController.text = widget.establishmentToEdit!.description;
      _imageUrlController.text = widget.establishmentToEdit!.imageUrl;
      _creationDateController.text = widget.establishmentToEdit!.creationDate;
      _authorController.text = widget.establishmentToEdit!.author;
      _selectedCategory = widget.establishmentToEdit!.categoria;

      // Inicializar _selectedFiles si es necesario
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
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
      appBar: AppBar(
        centerTitle: true, // Centrar el título
        title: Text(
          'Registro de Establecimiento',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTextFormField(_titleController, 'Título'),
              buildTextFormField(_locationController, 'Ubicación'),
              buildTextFormField(_descriptionController, 'Descripción'),
              buildTextFormField(_authorController, 'Autor'),
              buildTextFormField(_creationDateController, 'Fecha de Creación'),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(labelText: 'Categoría'),
                items:
                    _categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                    // Actualiza la URL de la imagen según la categoría seleccionada
                    _imageUrlController.text = _selectedCategory == 'Tienda'
                        ? "https://images.unsplash.com/photo-1605371924599-2d0365da1ae0?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                        : "https://images.unsplash.com/photo-1606824722920-4c652a70f348?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
                  });
                  print(_imageUrlController);
                },
              ),
              // Campos para la selección de archivos
              filePickerField('Área Deli', 'deliArea'),
              filePickerField('Área Carnes', 'carnesArea'),
              filePickerField('Área Cajas', 'cajasArea'),
              filePickerField('Área Frutas y Verduras', 'fyvArea'),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _registerEstablishment,
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
        if (_selectedFiles[key] == null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Es necesario seleccionar un archivo para $label',
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  Future<void> _registerEstablishment() async {
    if (_formKey.currentState!.validate()) {
      // Validar si todos los archivos han sido seleccionados
      bool areFilesSelected =
          _selectedFiles.values.every((file) => file != null);
      if (!areFilesSelected) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Por favor, seleccione todos los archivos requeridos'),
        ));
        return;
      }

      // Crear o actualizar la instancia de Establishment
      Establishment establishmentData = Establishment(
        id: widget.establishmentToEdit?.id ?? '',
        categoria: _selectedCategory,
        title: _titleController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
        creationDate: _creationDateController.text,
        location: _locationController.text,
        author: _authorController.text,
        deliArea: widget.establishmentToEdit?.deliArea ?? '',
        carnesArea: widget.establishmentToEdit?.carnesArea ?? '',
        cajasArea: widget.establishmentToEdit?.cajasArea ?? '',
        fyvArea: widget.establishmentToEdit?.fyvArea ?? '',
      );

      try {
        // Subir archivos y actualizar las URLs en establishmentData
        await _uploadFilesToFirebaseStorage(establishmentData);

        // Acceder a la colección de Firestore
        CollectionReference establishmentsCollection =
            FirebaseFirestore.instance.collection('establecimientos');

        if (widget.establishmentToEdit == null) {
          // Crear un nuevo establecimiento en Firestore
          await establishmentsCollection.add(establishmentData.toMap());
        } else {
          // Actualizar un establecimiento existente en Firestore
          await establishmentsCollection
              .doc(establishmentData.id)
              .update(establishmentData.toMap());
        }
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ocurrió un error: $e'),
        ));
      }
    }
  }

  Future<void> _uploadFilesToFirebaseStorage(
      Establishment establishmentData) async {
    for (var entry in _selectedFiles.entries) {
      final file = entry.value;
      final ref = FirebaseStorage.instance
          .ref()
          .child('uploads/${entry.key}/${file.name}');

      try {
        String fileUrl;
        if (kIsWeb) {
          Uint8List? fileBytes = file.bytes;
          if (fileBytes != null) {
            await ref.putData(fileBytes);
          }
        } else {
          if (file.path != null) {
            await ref.putFile(File(file.path!));
          }
        }
        fileUrl = await ref.getDownloadURL();

        // Asignar la URL al campo correspondiente en establishmentData
        switch (entry.key) {
          case 'deliArea':
            establishmentData.deliArea = fileUrl;
            break;
          case 'carnesArea':
            establishmentData.carnesArea = fileUrl;
            break;
          case 'cajasArea':
            establishmentData.cajasArea = fileUrl;
            break;
          case 'fyvArea':
            establishmentData.fyvArea = fileUrl;
            break;
        }
      } catch (e) {
        print('Error al subir archivo: $e');
      }
    }
  }
}

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

  // Controladores de texto
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Variables para guardar los archivos seleccionados
  Map<String, PlatformFile> _selectedFiles = {};

  @override
  void initState() {
    super.initState();
    if (widget.establishmentToEdit != null) {
      _titleController.text = widget.establishmentToEdit!.title;
      _locationController.text = widget.establishmentToEdit!.location;
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
      appBar: AppBar(title: Text('Registro de Establecimiento')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTextFormField(_titleController, 'Título'),
              buildTextFormField(_locationController, 'Ubicación'),

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
      ],
    );
  }

  Future<void> _registerEstablishment() async {
    if (_formKey.currentState!.validate()) {
      // Crear instancia de Establishment con los datos del formulario
      Establishment establishmentData = Establishment(
        id: widget.establishmentToEdit?.id ?? '',
        title: _titleController.text,
        description: widget.establishmentToEdit?.description ?? '',
        imageUrl: widget.establishmentToEdit?.imageUrl ?? '',
        creationDate: widget.establishmentToEdit?.creationDate ?? '',
        location: _locationController.text,
        author: widget.establishmentToEdit?.author ?? '',
        deliArea: widget.establishmentToEdit?.deliArea ?? '',
        carnesArea: widget.establishmentToEdit?.carnesArea ?? '',
        cajasArea: widget.establishmentToEdit?.cajasArea ?? '',
        fyvArea: widget.establishmentToEdit?.fyvArea ?? '',
      );

      try {
        // Subir archivos y actualizar las URLs en establishmentData
        await _uploadFilesToFirebaseStorage(establishmentData);

        if (widget.establishmentToEdit == null) {
          // Crear un nuevo establecimiento en Firestore
          await FirebaseFirestore.instance
              .collection('establecimientos')
              .add(establishmentData.toMap());
        } else {
          // Actualizar un establecimiento existente en Firestore
          await FirebaseFirestore.instance
              .collection('establecimientos')
              .doc(establishmentData.id)
              .update(establishmentData.toMap());
        }
        Navigator.pop(context, true);
      } catch (e) {
        print('Ocurrió un error: $e');
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

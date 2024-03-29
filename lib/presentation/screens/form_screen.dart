import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wayra_ayacucho/presentation/providers/providers.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final formKey = GlobalKey<FormState>();
    final formularioProvider = Provider.of<FormularioProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title:
              Text(formularioProvider.id == null ? "Crear " : "Cambiar Datos"),
          centerTitle: true,
        ),
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                // Imagen
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Stack(
                    children: [
                      Image.network(
                        formularioProvider.imagen,
                        height: 280,
                        width: 280,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: const Color.fromARGB(92, 0, 0, 0),
                        width: 280,
                        height: 280,
                        child: Center(
                          child: OutlinedButton(
                            child: const Text(
                              "Cambiar imagen",
                              style: TextStyle(
                                  color: Color.fromARGB(210, 255, 255, 255)),
                            ),
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? photo = await picker.pickImage(
                                  source: ImageSource.camera);
                              if (photo == null) return;
                              formularioProvider.setImagen(photo.path);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Título
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: formularioProvider.tituloController,
                  decoration: customTextField(colors, "Titulo", Icons.title),
                  validator: (value) =>
                      value!.isEmpty ? 'Requiere título' : null,
                ),
                const SizedBox(
                  height: 16,
                ),
                // Descripción
                TextFormField(
                  maxLines: 5,
                  controller: formularioProvider.descripcionController,
                  decoration:
                      customTextField(colors, "Descripcion", Icons.description),
                  validator: (value) =>
                      value!.isEmpty ? 'Requiere descripción' : null,
                ),
                const SizedBox(
                  height: 12,
                ),
                // Festividad o lugar
                Row(
                  children: [
                    const Text(
                      "Tipo :",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Radio(
                      value: true,
                      groupValue: formularioProvider.esFestividad,
                      onChanged: (value) =>
                          formularioProvider.setEsFestividad(true),
                    ),
                    const Text(
                      'Festividad',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Radio(
                      value: false,
                      groupValue: formularioProvider.esFestividad,
                      onChanged: (value) =>
                          formularioProvider.setEsFestividad(false),
                    ),
                    const Text(
                      'Lugar',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                // Fecha (if festividad)
                if (formularioProvider.esFestividad)
                  TextFormField(
                    controller: formularioProvider.fechaController,
                    decoration:
                        customTextField(colors, "Fecha", Icons.calendar_month),
                    onTap: () async {
                      final DateTime? pickelDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2025));

                      formularioProvider.setFecha(pickelDate);
                    },
                    onChanged: (value) {
                      //formularioProvider.setFecha(value);
                    },
                  ),
                // Permisos ubicación (if lugar)
                if (!formularioProvider.esFestividad)
                  Column(
                    children: [
                      SwitchListTile(
                        title: const Text(
                          'Cambiar ubicacion actual',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        value: formularioProvider.pedirPermisosUbicacion,
                        onChanged: (value) =>
                            formularioProvider.setPedirPermisosUbicacion(value),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            "Categoria:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          DropdownButton(
                              borderRadius: BorderRadius.circular(12),
                              dropdownColor:
                                  const Color.fromARGB(230, 213, 209, 209),
                              underline: Container(),
                              value: formularioProvider.categoryId,
                              items: const [
                                DropdownMenuItem(
                                    value: 1, child: Text("Parque")),
                                DropdownMenuItem(
                                    value: 2, child: Text("Mirador")),
                                DropdownMenuItem(
                                    value: 3, child: Text("Museo")),
                                DropdownMenuItem(
                                    value: 4, child: Text("Iglesia")),
                              ],
                              onChanged: (value) {
                                formularioProvider.setCategoryId(value);
                              }),
                        ],
                      )
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                // Botón de guardar
                FilledButton.tonal(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        formularioProvider.submitForm();
                        if (formularioProvider.esFestividad) {
                          context.read<FestivitiesProvider>().getFestivities();
                        } else {
                          context.read<PlacesProvider>().getPlaces();
                        }

                        context.push("/");
                      }
                    },
                    child: Text(
                        formularioProvider.id == null ? "Crear" : "Actualizar"))
              ]),
            ))));
  }

  InputDecoration customTextField(
      ColorScheme colors, String label, IconData icon) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(20));
    return InputDecoration(
      fillColor: const Color.fromARGB(68, 158, 158, 158),
      filled: true,
      suffixIcon: Icon(icon),
      floatingLabelStyle: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border.copyWith(borderSide: BorderSide(color: colors.error)),
      focusedErrorBorder:
          border.copyWith(borderSide: BorderSide(color: colors.error)),
      isDense: true,
      label: Text(label),
      hintText: label,
      focusColor: colors.primary,
    );
  }
}

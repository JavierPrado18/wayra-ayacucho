import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wayra_ayacucho/presentation/providers/fetivities_provider.dart';

class FestivitiesView extends StatelessWidget {
  const FestivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final festivitiesProvider =
        Provider.of<FestivitiesProvider>(context, listen: false);
    final colors = Theme.of(context).colorScheme;
    return FutureBuilder(
      future: festivitiesProvider.getFestivities(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final festivities = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: festivities?.length,
              itemBuilder: (context, index) {
                final festivity = festivities![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    onTap: () {
                      context.push("/festivities/${festivity.id}");
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    tileColor: colors.primaryContainer,
                    leading: SizedBox(
                      width: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          festivity.imgUrl,
                        ),
                      ),
                    ),
                    title: Text(festivity.nombre),
                    subtitle: Text(
                      "${festivity.dia} ${obtenerMes(festivity.mes!)} ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

String obtenerMes(int numeroMes) {
  String mes;

  switch (numeroMes) {
    case 1:
      mes = "Enero";
      break;
    case 2:
      mes = "Febrero";
      break;
    case 3:
      mes = "Marzo";
      break;
    case 4:
      mes = "Abril";
      break;
    case 5:
      mes = "Mayo";
      break;
    case 6:
      mes = "Junio";
      break;
    case 7:
      mes = "Julio";
      break;
    case 8:
      mes = "Agosto";
      break;
    case 9:
      mes = "Setiembre";
      break;
    case 10:
      mes = "Octubte";
      break;
    case 11:
      mes = "Noviembre";
      break;
    case 12:
      mes = "Diciembre";
      break;
    default:
      mes = "Mes no válido";
  }
  return mes;
}

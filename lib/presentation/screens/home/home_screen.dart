import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wayra_ayacucho/presentation/providers/providers.dart';
import 'package:wayra_ayacucho/presentation/screens/home/view/view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final indexPage = context.watch<IndexPageProvider>().currentIndex;
    final screens = [const PlacesView(), const FestivitiesView()];
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text('Wayra Ayacucho'),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: indexPage,
        children: screens,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<FormularioProvider>().changeValuesForm();
          context.push("/form");
        },
        child: Icon(
          Icons.add_circle_outline,
          color: colors.secondary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: indexPage,
          onTap: (value) {
            context.read<IndexPageProvider>().changeIndex(value);
          },
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.location_on),
                backgroundColor: colors.primary,
                label: 'Lugares'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.calendar_month),
                backgroundColor: colors.primary,
                label: 'Festividades'),
          ]),
    );
  }
}

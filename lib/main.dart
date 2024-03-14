import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wayra_ayacucho/config/routes/app_router.dart';
import 'package:wayra_ayacucho/config/theme/app_theme.dart';
import 'package:wayra_ayacucho/presentation/providers/providers.dart';

void main() => runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => IndexPageProvider(),),
    ChangeNotifierProvider(create: (context) => PlacesProvider(),),
    ChangeNotifierProvider(create: (context) => FormularioProvider(),),
    ChangeNotifierProvider(create: (context) => FestivitiesProvider(),),

  ],
  child:const MyApp() ,)
  );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoute,
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      
    );
  }
}
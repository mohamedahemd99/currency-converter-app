import 'package:currency_converter_app/presentation/bloc/currency_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/application/di/injection.dart';
import 'core/helper/common.dart';
import 'core/preference/pref_manager.dart';
import 'presentation/bloc/currency/currency_event.dart';
import 'presentation/screens/currency_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefManager.setupSharedPreferences();

  initializeDI();

  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CurrencyBloc>()..add(FetchCurrencies()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: CurrencyScreen(),
      ),
    );
  }
}

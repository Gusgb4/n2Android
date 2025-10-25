import 'package:flutter/material.dart';

import 'services/sim_clock.dart';
import 'services/mock_location_service.dart';
import 'services/csv_service.dart';
import 'controllers/app_state.dart';
import 'pages/splash_page.dart';
import 'pages/home_aluno_page.dart';
import 'pages/historico_page.dart';
import 'pages/relatorio_page.dart';
import 'pages/configuracoes_page.dart';

void main() {
  runApp(const ChamadaV2());
}

class ChamadaV2 extends StatefulWidget {
  const ChamadaV2({super.key});
  @override
  State<ChamadaV2> createState() => _ChamadaV2State();
}

class _ChamadaV2State extends State<ChamadaV2> {
  late final AppState app;

  @override
  void initState() {
    super.initState();
    app = AppState(
      clock: SimClock(
        durationRoundActive: const Duration(seconds: 5),  // conforme pedido
        durationBetweenRounds: const Duration(seconds: 10),
        roundsPerNight: 4,
      ),
      location: MockLocationService(
        roomCenterLat: -23.559, roomCenterLon: -46.658, allowedRadiusMeters: 30,
      ),
      csv: CsvService(),
    );
  }

  @override
  void dispose() {
    app.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chamada Automática — V2 (Aluno)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        final routes = {
          '/': (context) => SplashPage(app: app),
          '/home': (context) => HomeAlunoPage(app: app),
          '/historico': (context) => HistoricoPage(app: app),
          '/relatorio': (context) => RelatorioPage(app: app),
          '/configuracoes': (context) => ConfiguracoesPage(app: app),
        };
        final builder = routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(builder: builder, settings: settings);
        }
        return null;
      },
      initialRoute: '/',
    );
  }
}

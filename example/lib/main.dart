import 'package:flutter/material.dart';
import 'services/dhis2_service.dart';
import 'services/comprehensive_sync_service.dart';
import 'services/isar_service.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'models/app_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize D2Touch singleton (add config params if needed)
  await D2TouchSingleton().initialize();

  // Initialize Isar database
  await IsarService.initialize();

  runApp(const D2TouchIsarSampleApp());
}

class D2TouchIsarSampleApp extends StatelessWidget {
  const D2TouchIsarSampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D2Touch Isar Sample',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const AppWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  AppState _appState = AppState.loading;
  String? _error;

  @override
  void initState() {
    super.initState();
    _checkAuthenticationStatus();
  }

  Future<void> _checkAuthenticationStatus() async {
    try {
      final isAuthenticated = await DHIS2Service.isAuthenticated();
      setState(() {
        _appState = isAuthenticated ? AppState.authenticated : AppState.unauthenticated;
      });
    } catch (e) {
      setState(() {
        _appState = AppState.error;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_appState) {
      case AppState.loading:
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Initializing D2Touch Isar Sample App...'),
              ],
            ),
          ),
        );
      
      case AppState.unauthenticated:
        return LoginScreen(
          onLoginSuccess: () {
            setState(() {
              _appState = AppState.authenticated;
            });
          },
        );
      
      case AppState.authenticated:
        return DashboardScreen(
          onLogout: () {
            setState(() {
              _appState = AppState.unauthenticated;
            });
          },
        );
      
      case AppState.error:
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: $_error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _appState = AppState.loading;
                      _error = null;
                    });
                    _checkAuthenticationStatus();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
    }
  }
}

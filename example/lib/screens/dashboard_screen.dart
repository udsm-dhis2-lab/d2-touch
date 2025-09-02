import 'package:flutter/material.dart';
import '../services/dhis2_service.dart';
import '../services/isar_service.dart';
import 'sync_screen.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const DashboardScreen({super.key, required this.onLogout});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _userName;
  String? _serverUrl;
  Map<String, int>? _stats;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      final user = await DHIS2Service.getCurrentUser();
      final stats = await IsarService.getDatabaseStats();
      
      setState(() {
        _userName = user?.displayName ?? 'Unknown User';
        _serverUrl = user?.baseUrl ?? 'Unknown Server';
        _stats = stats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    try {
      await DHIS2Service.logout();
      widget.onLogout();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: $e')),
        );
      }
    }
  }

  Future<void> _clearData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text('Are you sure you want to clear all local data? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await IsarService.clearAllData();
        await _loadDashboardData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('All data cleared successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to clear data: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('D2Touch Isar Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Clear Data'),
                onTap: () => Future.delayed(
                  const Duration(milliseconds: 100),
                  _clearData,
                ),
              ),
              PopupMenuItem(
                child: const Text('Logout'),
                onTap: () => Future.delayed(
                  const Duration(milliseconds: 100),
                  _logout,
                ),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadDashboardData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User info card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                    _userName?.substring(0, 1).toUpperCase() ?? 'U',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _userName ?? 'Unknown User',
                                        style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                      Text(
                                        _serverUrl ?? 'Unknown Server',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.verified_user, color: Colors.green[600]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Database statistics
                    Text(
                      'Database Statistics',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.blue[50],
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Icon(Icons.people, size: 32, color: Colors.blue[600]),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${_stats?['users'] ?? 0}',
                                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                  Text(
                                    'Users',
                                    style: TextStyle(color: Colors.blue[700]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Card(
                            color: Colors.green[50],
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Icon(Icons.account_tree, size: 32, color: Colors.green[600]),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${_stats?['organisationUnits'] ?? 0}',
                                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                    ),
                                  ),
                                  Text(
                                    'Org Units',
                                    style: TextStyle(color: Colors.green[700]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Actions section
                    Text(
                      'Actions',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Sync metadata button
                    Card(
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.sync, color: Colors.orange[800]),
                        ),
                        title: const Text('Sync Metadata'),
                        subtitle: const Text('Download latest organisation units from DHIS2'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SyncScreen(
                                onSyncComplete: _loadDashboardData,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // View data button
                    Card(
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.visibility, color: Colors.purple[800]),
                        ),
                        title: const Text('View Organisation Units'),
                        subtitle: const Text('Browse synced organisation unit hierarchy'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OrganisationUnitListScreen(),
                            ),
                          );
                        },
                      ),
                    ),

                    // Database info button  
                    Card(
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.info, color: Colors.teal[800]),
                        ),
                        title: const Text('Database Info'),
                        subtitle: const Text('View Isar database details and performance'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const DatabaseInfoScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class OrganisationUnitListScreen extends StatefulWidget {
  const OrganisationUnitListScreen({super.key});

  @override
  State<OrganisationUnitListScreen> createState() => _OrganisationUnitListScreenState();
}

class _OrganisationUnitListScreenState extends State<OrganisationUnitListScreen> {
  List<Map<String, dynamic>> _hierarchy = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrganisationUnits();
  }

  Future<void> _loadOrganisationUnits() async {
    try {
      final hierarchy = await DHIS2Service.getOrganisationUnitHierarchy();
      setState(() {
        _hierarchy = hierarchy;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisation Units'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hierarchy.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_tree, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No organisation units found'),
                      SizedBox(height: 8),
                      Text('Try syncing metadata first'),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _hierarchy.length,
                  itemBuilder: (context, index) {
                    final level = _hierarchy[index];
                    final units = level['units'] as List<Map<String, dynamic>>;
                    
                    return ExpansionTile(
                      title: Text(level['level']),
                      subtitle: Text('${level['count']} units'),
                      children: units.map((unit) => ListTile(
                        leading: Icon(
                          unit['hasCoordinates'] ? Icons.location_on : Icons.location_off,
                          color: unit['hasCoordinates'] ? Colors.green : Colors.grey,
                        ),
                        title: Text(unit['name']),
                        subtitle: Text(unit['id']),
                      )).toList(),
                    );
                  },
                ),
    );
  }
}

class DatabaseInfoScreen extends StatefulWidget {
  const DatabaseInfoScreen({super.key});

  @override
  State<DatabaseInfoScreen> createState() => _DatabaseInfoScreenState();
}

class _DatabaseInfoScreenState extends State<DatabaseInfoScreen> {
  Map<String, dynamic>? _systemInfo;
  Map<String, int>? _stats;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    try {
      final systemInfo = await DHIS2Service.getSystemInfo();
      final stats = await IsarService.getDatabaseStats();
      
      setState(() {
        _systemInfo = systemInfo;
        _stats = stats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Info'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DHIS2 Server Info',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('Version', _systemInfo?['version']),
                          _buildInfoRow('Build', _systemInfo?['buildRevision']),
                          _buildInfoRow('Instance', _systemInfo?['systemName']),
                          _buildInfoRow('Database', _systemInfo?['databaseInfo']?['name']),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Text(
                    'Local Isar Database',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('Users', '${_stats?['users'] ?? 0}'),
                          _buildInfoRow('Organisation Units', '${_stats?['organisationUnits'] ?? 0}'),
                          _buildInfoRow('Database Engine', 'Isar 3.x'),
                          _buildInfoRow('Storage Type', 'Local file system'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value ?? 'Unknown'),
          ),
        ],
      ),
    );
  }
}

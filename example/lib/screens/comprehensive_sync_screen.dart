import 'package:flutter/material.dart';
import '../services/comprehensive_sync_service.dart';
import '../models/app_state.dart';

class ComprehensiveSyncScreen extends StatefulWidget {
  final VoidCallback onSyncComplete;

  const ComprehensiveSyncScreen({super.key, required this.onSyncComplete});

  @override
  State<ComprehensiveSyncScreen> createState() => _ComprehensiveSyncScreenState();
}

class _ComprehensiveSyncScreenState extends State<ComprehensiveSyncScreen> 
    with TickerProviderStateMixin {
  
  late AnimationController _rotationController;
  late AnimationController _progressController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _progressAnimation;

  bool _isSyncing = false;
  bool _isCompleted = false;
  bool _hasError = false;
  String _currentMessage = 'Ready to sync metadata from DHIS2 server';
  double _overallProgress = 0.0;
  String? _errorMessage;
  
  // Detailed progress tracking
  List<MetadataTypeProgress> _metadataProgress = [];
  Map<String, int> _finalCounts = {};

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_rotationController);
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut)
    );

    // Initialize D2Touch singleton before sync
    Future(() async {
      await D2TouchSingleton().initialize();
      // Auto-start sync after a brief delay
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          _startComprehensiveSync();
        }
      });
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  Future<void> _startComprehensiveSync() async {
    if (_isSyncing) return;

    setState(() {
      _isSyncing = true;
      _isCompleted = false;
      _hasError = false;
      _errorMessage = null;
      _overallProgress = 0.0;
      _metadataProgress.clear();
      _finalCounts.clear();
    });

    _rotationController.repeat();

    try {
      await ComprehensiveSyncService.syncAllMetadata(
        onProgressUpdate: (progress) {
          setState(() {
            _currentMessage = progress.message;
            _overallProgress = progress.overallProgress;
            
            // Update specific metadata type progress
            final existingIndex = _metadataProgress.indexWhere(
              (p) => p.type == progress.currentType
            );
            
            if (existingIndex >= 0) {
              _metadataProgress[existingIndex] = MetadataTypeProgress(
                type: progress.currentType,
                message: progress.message,
                progress: progress.typeProgress,
                isCompleted: progress.isTypeCompleted,
                count: progress.itemCount,
              );
            } else if (progress.currentType != null) {
              _metadataProgress.add(MetadataTypeProgress(
                type: progress.currentType!,
                message: progress.message,
                progress: progress.typeProgress,
                isCompleted: progress.isTypeCompleted,
                count: progress.itemCount,
              ));
            }
          });
          
          // Animate progress
          _progressController.animateTo(_overallProgress);
        },
        onComplete: (finalStats) {
          setState(() {
            _finalCounts = finalStats;
            _isCompleted = true;
            _isSyncing = false;
            _currentMessage = 'All metadata synced successfully!';
          });
          
          _rotationController.stop();
          _rotationController.reset();
          
          // Auto-navigate after showing success
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              widget.onSyncComplete();
            }
          });
        },
      );
      
    } catch (e) {
      _rotationController.stop();
      setState(() {
        _isSyncing = false;
        _hasError = true;
        _errorMessage = e.toString();
        _currentMessage = 'Sync failed - please try again';
      });
    }
  }

  Widget _buildProgressIndicator() {
    if (_isCompleted) {
      return Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.green[50],
          shape: BoxShape.circle,
          border: Border.all(color: Colors.green[300]!, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Icon(
          Icons.check_circle,
          size: 80,
          color: Colors.green[600],
        ),
      );
    } else if (_hasError) {
      return Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.red[50],
          shape: BoxShape.circle,
          border: Border.all(color: Colors.red[300]!, width: 3),
        ),
        child: Icon(
          Icons.error_outline,
          size: 80,
          color: Colors.red[600],
        ),
      );
    } else if (_isSyncing) {
      return Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue[300]!, width: 3),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return CircularProgressIndicator(
                    value: _progressAnimation.value,
                    strokeWidth: 6,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                    backgroundColor: Colors.blue[200],
                  );
                },
              ),
            ),
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 2.0 * 3.141592653589793,
                  child: Icon(
                    Icons.sync,
                    size: 40,
                    color: Colors.blue[600],
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[300]!, width: 3),
      ),
      child: Icon(
        Icons.cloud_download,
        size: 80,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildMetadataTypeProgress() {
    if (_metadataProgress.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.list_alt, color: Colors.blue[600]),
                const SizedBox(width: 8),
                Text(
                  'Metadata Types Progress',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...(_metadataProgress.map((progress) => _buildTypeProgressItem(progress))),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeProgressItem(MetadataTypeProgress progress) {
    final icon = _getMetadataTypeIcon(progress.type);
    final color = progress.isCompleted 
        ? Colors.green 
        : progress.progress > 0 
            ? Colors.blue 
            : Colors.grey;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color[600]),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              _formatMetadataTypeName(progress.type),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: color[800],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (progress.count > 0)
                      Text(
                        '${progress.count} items',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    const SizedBox(width: 8),
                    if (progress.isCompleted)
                      Icon(Icons.check, size: 16, color: Colors.green[600])
                    else
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          value: progress.progress,
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(color[600]!),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: progress.progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(color[600]!),
                  minHeight: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalStats() {
    if (!_isCompleted || _finalCounts.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.analytics, color: Colors.green[600]),
                const SizedBox(width: 8),
                Text(
                  'Sync Summary',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...(_finalCounts.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatMetadataTypeName(entry.key)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: Text(
                      '${entry.value}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                ],
              ),
            ))),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'All metadata has been successfully stored in your local database and is ready for offline use.',
                      style: TextStyle(color: Colors.green[700]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getMetadataTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'organisationunits':
        return Icons.account_tree;
      case 'programs':
        return Icons.medical_services;
      case 'dataelements':
        return Icons.data_object;
      case 'indicators':
        return Icons.trending_up;
      case 'datasets':
        return Icons.table_chart;
      case 'categories':
        return Icons.category;
      case 'users':
        return Icons.people;
      default:
        return Icons.storage;
    }
  }

  String _formatMetadataTypeName(String type) {
    switch (type.toLowerCase()) {
      case 'organisationunits':
        return 'Organisation Units';
      case 'programs':
        return 'Programs';
      case 'dataelements':
        return 'Data Elements';
      case 'indicators':
        return 'Indicators';
      case 'datasets':
        return 'Data Sets';
      case 'categories':
        return 'Categories';
      case 'users':
        return 'Users';
      default:
        return type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isSyncing,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Syncing Metadata'),
          leading: _isSyncing ? null : const BackButton(),
          backgroundColor: _isCompleted 
              ? Colors.green 
              : _hasError 
                  ? Colors.red 
                  : Colors.blue,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Main progress section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _isCompleted 
                    ? Colors.green[50] 
                    : _hasError 
                        ? Colors.red[50] 
                        : Colors.blue[50],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  _buildProgressIndicator(),
                  const SizedBox(height: 24),
                  Text(
                    _currentMessage,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _isCompleted 
                          ? Colors.green[800] 
                          : _hasError 
                              ? Colors.red[800] 
                              : Colors.blue[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  if (_isSyncing)
                    Column(
                      children: [
                        Text(
                          '${(_overallProgress * 100).toInt()}%',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: _overallProgress,
                          backgroundColor: Colors.blue[200],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (_hasError && _errorMessage != null)
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.error, color: Colors.red[600]),
                                const SizedBox(width: 8),
                                Text(
                                  'Error Details',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[800],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.red[700]),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _startComprehensiveSync,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[600],
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Retry Sync'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                    _buildMetadataTypeProgress(),
                    _buildFinalStats(),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MetadataTypeProgress {
  final String type;
  final String message;
  final double progress;
  final bool isCompleted;
  final int count;

  MetadataTypeProgress({
    required this.type,
    required this.message,
    required this.progress,
    required this.isCompleted,
    required this.count,
  });
}

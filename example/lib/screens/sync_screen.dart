import 'package:flutter/material.dart';
import '../services/dhis2_service.dart';
import '../models/app_state.dart';

class SyncScreen extends StatefulWidget {
  final VoidCallback onSyncComplete;

  const SyncScreen({super.key, required this.onSyncComplete});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> with SingleTickerProviderStateMixin {
  SyncStatus _syncStatus = SyncStatus.initial();
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _startSync() async {
    if (_isSyncing) return;

    setState(() {
      _isSyncing = true;
      _syncStatus = SyncStatus.initial();
    });

    _animationController.repeat();

    try {
      await DHIS2Service.syncMetadata(
        onStatusUpdate: (status) {
          setState(() {
            _syncStatus = status;
          });
        },
      );
      
      // Sync completed successfully
      _animationController.stop();
      widget.onSyncComplete();
      
      // Show success and navigate back
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
      
    } catch (e) {
      _animationController.stop();
      setState(() {
        _syncStatus = SyncStatus.error('Sync failed', e.toString());
      });
    } finally {
      setState(() {
        _isSyncing = false;
      });
    }
  }

  Widget _buildProgressIndicator() {
    if (_syncStatus.isCompleted && !_syncStatus.hasError) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.green[50],
          shape: BoxShape.circle,
          border: Border.all(color: Colors.green[200]!, width: 2),
        ),
        child: Icon(
          Icons.check,
          size: 60,
          color: Colors.green[600],
        ),
      );
    } else if (_syncStatus.hasError) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.red[50],
          shape: BoxShape.circle,
          border: Border.all(color: Colors.red[200]!, width: 2),
        ),
        child: Icon(
          Icons.error,
          size: 60,
          color: Colors.red[600],
        ),
      );
    } else if (_isSyncing) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue[200]!, width: 2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: _syncStatus.progress > 0 ? _syncStatus.progress : null,
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                backgroundColor: Colors.blue[200],
              ),
            ),
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 2.0 * 3.141592653589793,
                  child: Icon(
                    Icons.sync,
                    size: 32,
                    color: Colors.blue[600],
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!, width: 2),
        ),
        child: Icon(
          Icons.sync,
          size: 60,
          color: Colors.grey[600],
        ),
      );
    }
  }

  Color _getProgressColor() {
    if (_syncStatus.hasError) return Colors.red[600]!;
    if (_syncStatus.isCompleted) return Colors.green[600]!;
    return Colors.blue[600]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync Metadata'),
        leading: _isSyncing ? null : const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress indicator
            _buildProgressIndicator(),
            const SizedBox(height: 32),

            // Status message
            Text(
              _syncStatus.message,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: _getProgressColor(),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Progress percentage
            if (_syncStatus.progress > 0 && !_syncStatus.isCompleted && !_syncStatus.hasError)
              Text(
                '${(_syncStatus.progress * 100).toInt()}%',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 24),

            // Progress bar
            if (_syncStatus.progress > 0 && !_syncStatus.hasError)
              Column(
                children: [
                  LinearProgressIndicator(
                    value: _syncStatus.progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(_getProgressColor()),
                  ),
                  const SizedBox(height: 24),
                ],
              ),

            // Error details
            if (_syncStatus.hasError && _syncStatus.errorMessage != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  border: Border.all(color: Colors.red[200]!),
                  borderRadius: BorderRadius.circular(8),
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
                      _syncStatus.errorMessage!,
                      style: TextStyle(color: Colors.red[700]),
                    ),
                  ],
                ),
              ),

            // Action buttons
            if (!_isSyncing)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _syncStatus.isCompleted && !_syncStatus.hasError
                      ? () => Navigator.of(context).pop()
                      : _startSync,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _syncStatus.isCompleted && !_syncStatus.hasError
                        ? Colors.green
                        : _syncStatus.hasError
                            ? Colors.red
                            : Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    _syncStatus.isCompleted && !_syncStatus.hasError
                        ? 'Done'
                        : _syncStatus.hasError
                            ? 'Retry'
                            : 'Start Sync',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),

            if (!_isSyncing && !_syncStatus.isCompleted)
              const SizedBox(height: 32),

            // Info section
            if (!_isSyncing && !_syncStatus.isCompleted)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  border: Border.all(color: Colors.blue[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue[600]),
                        const SizedBox(width: 8),
                        Text(
                          'About Metadata Sync',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This will download the latest metadata from your DHIS2 server and store it in the local Isar database. This includes organisation units and user information.',
                      style: TextStyle(color: Colors.blue[700]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Organisation units with hierarchy\n'
                      '• Geographic coordinates\n'
                      '• User authentication data\n'
                      '• System configuration',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 12,
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
}

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Screenshot App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AutoScreenshotPage(title: 'Auto Screenshot App'),
    );
  }
}

class AutoScreenshotPage extends StatefulWidget {
  const AutoScreenshotPage({super.key, required this.title});

  final String title;

  @override
  State<AutoScreenshotPage> createState() => _AutoScreenshotPageState();
}

class _AutoScreenshotPageState extends State<AutoScreenshotPage> {
  final ScreenshotController _screenshotController = ScreenshotController();
  Timer? _timer;
  int _screenshotCount = 0;
  bool _isAutoScreenshotEnabled = false;
  final List<String> _screenshotPaths = [];
  String _statusMessage = 'Ready to start auto screenshots';

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    // Request storage permissions
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      
      // For Android 11+ (API 30+), we might need MANAGE_EXTERNAL_STORAGE
      if (await Permission.manageExternalStorage.isDenied) {
        await Permission.manageExternalStorage.request();
      }
    }
  }

  Future<void> _takeScreenshot() async {
    try {
      final Uint8List? image = await _screenshotController.capture();
      if (image != null) {
        await _saveScreenshot(image);
        setState(() {
          _screenshotCount++;
          _statusMessage = 'Screenshot $_screenshotCount taken at ${DateTime.now().toString().substring(0, 19)}';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error taking screenshot: $e';
      });
    }
  }

  Future<void> _saveScreenshot(Uint8List image) async {
    try {
      Directory? directory;
      
      if (Platform.isAndroid) {
        // Try to save to external storage first, fallback to app directory
        directory = await getExternalStorageDirectory();
        directory ??= await getApplicationDocumentsDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String fileName = 'screenshot_$timestamp.png';
      final String filePath = '${directory.path}/$fileName';
      
      final File file = File(filePath);
      await file.writeAsBytes(image);
      
      setState(() {
        _screenshotPaths.add(filePath);
      });
      
             debugPrint('Screenshot saved to: $filePath');
     } catch (e) {
       debugPrint('Error saving screenshot: $e');
      setState(() {
        _statusMessage = 'Error saving screenshot: $e';
      });
    }
  }

  void _startAutoScreenshots() {
    if (_isAutoScreenshotEnabled) return;
    
    setState(() {
      _isAutoScreenshotEnabled = true;
      _statusMessage = 'Auto screenshots started - taking every 2 minutes';
    });
    
    // Take first screenshot immediately
    _takeScreenshot();
    
    // Set up timer for every 2 minutes (120 seconds)
    _timer = Timer.periodic(const Duration(minutes: 2), (timer) {
      _takeScreenshot();
    });
  }

  void _stopAutoScreenshots() {
    _timer?.cancel();
    setState(() {
      _isAutoScreenshotEnabled = false;
      _statusMessage = 'Auto screenshots stopped';
    });
  }

  void _clearScreenshots() {
    setState(() {
      _screenshotPaths.clear();
      _screenshotCount = 0;
      _statusMessage = 'Screenshots cleared';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                                         children: const [
                       Icon(
                         Icons.camera_alt,
                         size: 64,
                         color: Colors.deepPurple,
                       ),
                                             SizedBox(height: 16),
                       Text(
                         'Auto Screenshot App',
                         style: TextStyle(
                           fontSize: 24,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       SizedBox(height: 8),
                       Text(
                         'This app automatically takes screenshots every 2 minutes',
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 16),
                       ),
                     ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Status Card
              Card(
                color: _isAutoScreenshotEnabled ? Colors.green.shade50 : Colors.grey.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            _isAutoScreenshotEnabled ? Icons.play_circle : Icons.pause_circle,
                            color: _isAutoScreenshotEnabled ? Colors.green : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isAutoScreenshotEnabled ? 'ACTIVE' : 'INACTIVE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _isAutoScreenshotEnabled ? Colors.green : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _statusMessage,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Screenshots taken: $_screenshotCount',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Control Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isAutoScreenshotEnabled ? null : _startAutoScreenshots,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start Auto Screenshots'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isAutoScreenshotEnabled ? _stopAutoScreenshots : null,
                      icon: const Icon(Icons.stop),
                      label: const Text('Stop Auto Screenshots'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Manual screenshot and clear buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _takeScreenshot,
                      icon: const Icon(Icons.camera),
                      label: const Text('Take Manual Screenshot'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _screenshotPaths.isNotEmpty ? _clearScreenshots : null,
                      icon: const Icon(Icons.clear),
                      label: const Text('Clear Screenshots'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Screenshot paths list
              if (_screenshotPaths.isNotEmpty) ...[
                const Text(
                  'Screenshot Files:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _screenshotPaths.length,
                    itemBuilder: (context, index) {
                      final path = _screenshotPaths[index];
                      final fileName = path.split('/').last;
                      return ListTile(
                        leading: const Icon(Icons.image),
                        title: Text(fileName),
                        subtitle: Text(path),
                        dense: true,
                      );
                    },
                  ),
                ),
              ],
              
              const SizedBox(height: 20),
              
              // Sample content to make screenshots more interesting
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sample Content',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This is some sample content that will appear in your screenshots. '
                        'The current time is displayed below and updates to make each screenshot unique.',
                      ),
                      const SizedBox(height: 8),
                      StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          return Text(
                            'Current time: ${DateTime.now().toString().substring(0, 19)}',
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

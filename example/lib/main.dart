import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _themeController = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _themeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Switch Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
      ),
      themeMode: _themeController.value ? ThemeMode.dark : ThemeMode.light,
      home: ExampleHomePage(themeController: _themeController),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({
    Key? key,
    required this.themeController,
  }) : super(key: key);

  final ValueNotifier<bool> themeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Switch Examples'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.light_mode, size: 20),
                const SizedBox(width: 8),
                AdvancedSwitch(
                  controller: themeController,
                  width: 50,
                  height: 28,
                  thumb: ValueListenableBuilder<bool>(
                    valueListenable: themeController,
                    builder: (_, value, __) {
                      return Icon(
                        value ? Icons.dark_mode : Icons.light_mode,
                        size: 16,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.dark_mode, size: 20),
              ],
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BasicExamplesSection(),
            SizedBox(height: 24),
            CustomizationSection(),
            SizedBox(height: 24),
            SizesSection(),
            SizedBox(height: 24),
            InteractiveSection(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

class ExampleCard extends StatelessWidget {
  const ExampleCard({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
              ),
              const SizedBox(height: 8),
              Center(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class BasicExamplesSection extends StatefulWidget {
  const BasicExamplesSection({Key? key}) : super(key: key);

  @override
  State<BasicExamplesSection> createState() => _BasicExamplesSectionState();
}

class _BasicExamplesSectionState extends State<BasicExamplesSection> {
  final _defaultController = ValueNotifier<bool>(false);
  final _customThumbController = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _defaultController.dispose();
    _customThumbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Basic Examples',
          subtitle: 'Simple switches with default styling',
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ExampleCard(
              title: 'Default',
              child: AdvancedSwitch(controller: _defaultController),
            ),
            ExampleCard(
              title: 'Custom Thumb',
              child: AdvancedSwitch(
                controller: _customThumbController,
                thumb: ValueListenableBuilder<bool>(
                  valueListenable: _customThumbController,
                  builder: (_, value, __) {
                    return Icon(
                      value ? Icons.check : Icons.close,
                      size: 16,
                    );
                  },
                ),
              ),
            ),
            const ExampleCard(
              title: 'Disabled',
              child: AdvancedSwitch(
                initialValue: true,
                enabled: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomizationSection extends StatefulWidget {
  const CustomizationSection({Key? key}) : super(key: key);

  @override
  State<CustomizationSection> createState() => _CustomizationSectionState();
}

class _CustomizationSectionState extends State<CustomizationSection> {
  final _colorController = ValueNotifier<bool>(false);
  final _textController = ValueNotifier<bool>(false);
  final _iconController = ValueNotifier<bool>(false);
  final _imageController = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _colorController.dispose();
    _textController.dispose();
    _iconController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Customization',
          subtitle: 'Custom colors, text, icons, and images',
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ExampleCard(
              title: 'Colors',
              child: AdvancedSwitch(
                controller: _colorController,
                activeColor: Colors.green,
                inactiveColor: Colors.red,
                width: 60,
              ),
            ),
            ExampleCard(
              title: 'Text',
              child: AdvancedSwitch(
                controller: _textController,
                activeChild: const Text('ON'),
                inactiveChild: const Text('OFF'),
                width: 70,
              ),
            ),
            ExampleCard(
              title: 'Icons',
              child: AdvancedSwitch(
                controller: _iconController,
                activeChild: const Icon(Icons.wb_sunny, size: 16),
                inactiveChild: const Icon(Icons.nightlight_round, size: 16),
                activeColor: Colors.orange,
                inactiveColor: Colors.indigo,
                width: 60,
              ),
            ),
            ExampleCard(
              title: 'Images',
              child: AdvancedSwitch(
                controller: _imageController,
                width: 80,
                activeChild: const Text('DAY'),
                inactiveChild: const Text('NIGHT'),
                activeImage: const AssetImage('assets/images/day_sky.png'),
                inactiveImage: const AssetImage('assets/images/night_sky.jpg'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SizesSection extends StatefulWidget {
  const SizesSection({Key? key}) : super(key: key);

  @override
  State<SizesSection> createState() => _SizesSectionState();
}

class _SizesSectionState extends State<SizesSection> {
  final _smallController = ValueNotifier<bool>(false);
  final _mediumController = ValueNotifier<bool>(false);
  final _largeController = ValueNotifier<bool>(false);
  final _extraLargeController = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _smallController.dispose();
    _mediumController.dispose();
    _largeController.dispose();
    _extraLargeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Different Sizes',
          subtitle: 'Switches in various dimensions',
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ExampleCard(
              title: 'S (32x16)',
              child: AdvancedSwitch(
                controller: _smallController,
                width: 32,
                height: 16,
              ),
            ),
            ExampleCard(
              title: 'M (50x30)',
              child: AdvancedSwitch(
                controller: _mediumController,
                width: 50,
                height: 30,
              ),
            ),
            ExampleCard(
              title: 'L (72x36)',
              child: AdvancedSwitch(
                controller: _largeController,
                width: 72,
                height: 36,
              ),
            ),
            ExampleCard(
              title: 'XL (96x48)',
              child: AdvancedSwitch(
                controller: _extraLargeController,
                width: 96,
                height: 48,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class InteractiveSection extends StatefulWidget {
  const InteractiveSection({Key? key}) : super(key: key);

  @override
  State<InteractiveSection> createState() => _InteractiveSectionState();
}

class _InteractiveSectionState extends State<InteractiveSection> {
  final _switchController = ValueNotifier<bool>(false);
  bool _isEnabled = true;

  @override
  void dispose() {
    _switchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Interactive Example',
          subtitle: 'Control switch state programmatically',
        ),
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AdvancedSwitch(
                  controller: _switchController,
                  enabled: _isEnabled,
                  width: 60,
                  height: 32,
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<bool>(
                  valueListenable: _switchController,
                  builder: (_, value, __) {
                    return Text(
                      'Switch is ${value ? "ON" : "OFF"}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  },
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _switchController.value = true,
                      child: const Text('ON'),
                    ),
                    ElevatedButton(
                      onPressed: () => _switchController.value = false,
                      child: const Text('OFF'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _isEnabled = !_isEnabled;
                        });
                      },
                      child: Text(_isEnabled ? 'Disable' : 'Enable'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

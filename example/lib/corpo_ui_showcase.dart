import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';

/// Comprehensive component showcase for Corpo UI design system.
///
/// This application demonstrates all available components with interactive
/// examples, code samples, and usage guidelines. It serves as both
/// documentation and a testing platform for the design system.
class CorpoUIShowcase extends StatelessWidget {
  const CorpoUIShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corpo UI Showcase',
      theme: CorpoTheme.light(),
      darkTheme: CorpoTheme.dark(),
      themeMode: ThemeMode.system,
      home: const ShowcaseHome(),
    );
  }
}

/// Main showcase navigation screen.
class ShowcaseHome extends StatefulWidget {
  const ShowcaseHome({super.key});

  @override
  State<ShowcaseHome> createState() => _ShowcaseHomeState();
}

class _ShowcaseHomeState extends State<ShowcaseHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corpo UI Showcase'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Typography'),
            Tab(text: 'Buttons'),
            Tab(text: 'Layout'),
            Tab(text: 'Forms'),
            Tab(text: 'Navigation'),
            Tab(text: 'Feedback'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildTypographyTab(),
          _buildButtonsTab(),
          _buildLayoutTab(),
          _buildFormsTab(),
          _buildNavigationTab(),
          _buildFeedbackTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Corpo UI Design System'),
          const SizedBox(height: 16),
          _buildInfoCard(
            'A comprehensive Flutter design system for corporate applications',
            'Built with accessibility, theming, and responsive design in mind.',
          ),
          const SizedBox(height: 24),
          _buildComponentOverview(),
        ],
      ),
    );
  }

  Widget _buildTypographyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Typography System'),
          const SizedBox(height: 16),
          _buildTypographyExamples(),
        ],
      ),
    );
  }

  Widget _buildButtonsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Button Components'),
          const SizedBox(height: 16),
          _buildButtonExamples(),
        ],
      ),
    );
  }

  Widget _buildLayoutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Layout Components'),
          const SizedBox(height: 16),
          _buildLayoutExamples(),
        ],
      ),
    );
  }

  Widget _buildFormsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Form Components'),
          const SizedBox(height: 16),
          _buildFormExamples(),
        ],
      ),
    );
  }

  Widget _buildNavigationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Navigation Components'),
          const SizedBox(height: 16),
          _buildNavigationExamples(),
        ],
      ),
    );
  }

  Widget _buildFeedbackTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Feedback Components'),
          const SizedBox(height: 16),
          _buildFeedbackExamples(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInfoCard(String title, String description) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentOverview() {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        _buildFeatureChip('50+ Components'),
        _buildFeatureChip('Responsive Design'),
        _buildFeatureChip('Accessibility'),
        _buildFeatureChip('Dark/Light Theme'),
        _buildFeatureChip('Material 3'),
        _buildFeatureChip('Corporate Design'),
      ],
    );
  }

  Widget _buildFeatureChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }

  Widget _buildTypographyExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Heading 1', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 8),
        Text('Heading 2', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text('Heading 3', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Text(
          'Body Large - Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Body Medium - Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Body Small - Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildButtonExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Primary Button'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
            TextButton(onPressed: () {}, child: const Text('Text Button')),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Button States:'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16.0,
          runSpacing: 8.0,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Enabled')),
            const ElevatedButton(onPressed: null, child: Text('Disabled')),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('With Icon'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLayoutExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cards:'),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sample Card',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text('This is a sample card with some content.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Dividers:'),
        const SizedBox(height: 8),
        const Text('Content above'),
        const Divider(),
        const Text('Content below'),
      ],
    );
  }

  Widget _buildFormExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: 'Text Field',
            helperText: 'Enter some text',
          ),
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
          title: const Text('Checkbox'),
          value: true,
          onChanged: (value) {},
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Switch'),
          value: false,
          onChanged: (value) {},
        ),
        const SizedBox(height: 16),
        Slider(value: 0.5, onChanged: (value) {}),
      ],
    );
  }

  Widget _buildNavigationExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('This showcase uses TabBar navigation above.'),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => _showDialog(context),
          child: const Text('Show Dialog'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showSnackBar(context),
          child: const Text('Show SnackBar'),
        ),
        const SizedBox(height: 16),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(child: Text('This is an informational alert.')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const LinearProgressIndicator(value: 0.7),
        const SizedBox(height: 16),
        const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sample Dialog'),
        content: const Text('This is a sample dialog with some content.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('This is a sample snackbar'),
        action: SnackBarAction(label: 'Undo', onPressed: () {}),
      ),
    );
  }
}

/// Entry point for the showcase application.
void main() {
  runApp(const CorpoUIShowcase());
}

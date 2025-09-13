import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';

/// Simple Phase 5 demo focusing on working features.
///
/// This demo demonstrates the successfully implemented Phase 5 features:
/// - Responsive System (breakpoints, screen detection, adaptive components)
/// - Accessibility (basic support)
class SimplePhase5Demo extends StatelessWidget {
  const SimplePhase5Demo({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Phase 5: Advanced Features'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    ),
    body: CorpoResponsiveBuilder(
      builder: (BuildContext context, CorpoScreenSize screenSize) =>
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header Section
                _buildHeader(context, screenSize),
                const SizedBox(height: 32),

                // Responsive Grid Demo
                _buildResponsiveDemo(context, screenSize),
                const SizedBox(height: 32),

                // Adaptive Components Demo
                _buildAdaptiveDemo(context, screenSize),
              ],
            ),
          ),
    ),
  );

  Widget _buildHeader(
    BuildContext context,
    CorpoScreenSize screenSize,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Corpo UI Phase 5: Advanced Features',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      const SizedBox(height: 16),
      Text(
        'This demo showcases the successfully implemented Phase 5 responsive system.',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      const SizedBox(height: 16),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Current Screen Info',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text('Breakpoint: ${screenSize.currentBreakpoint.name}'),
              Text('Device Type: ${screenSize.deviceType.name}'),
              Text('Width: ${screenSize.width.toStringAsFixed(0)}px'),
              Text('Height: ${screenSize.height.toStringAsFixed(0)}px'),
              Text('Orientation: ${screenSize.orientation.name}'),
              const SizedBox(height: 8),
              Text(
                screenSize.isDesktop
                    ? 'Layout Mode: Desktop (${screenSize.currentBreakpoint.name})'
                    : screenSize.isTablet
                    ? 'Layout Mode: Tablet (${screenSize.currentBreakpoint.name})'
                    : 'Layout Mode: Mobile (${screenSize.currentBreakpoint.name})',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _buildResponsiveDemo(
    BuildContext context,
    CorpoScreenSize screenSize,
  ) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Responsive Grid System',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),

          Text(
            'Grid adapts based on screen size:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),

          // Responsive grid that adapts columns based on screen size
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenSize.isDesktop
                  ? 4
                  : screenSize.isTablet
                  ? 2
                  : 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 3,
            ),
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Item ${index + 1}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildAdaptiveDemo(
    BuildContext context,
    CorpoScreenSize screenSize,
  ) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Adaptive Components',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),

          Text(
            'Components that adapt to screen size and platform:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),

          // Adaptive button row
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: <Widget>[
              CorpoAdaptiveButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Adaptive button pressed! Layout: ${screenSize.deviceType.name}',
                      ),
                    ),
                  );
                },
                child: const Text('Adaptive Primary'),
              ),
              CorpoAdaptiveButton(
                onPressed: () {},
                variant: CorpoButtonVariant.secondary,
                child: const Text('Adaptive Secondary'),
              ),
              CorpoAdaptiveButton(
                onPressed: () {},
                variant: CorpoButtonVariant.tertiary,
                child: const Text('Adaptive Tertiary'),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Dashboard-style cards that adapt
          Text(
            'Adaptive Dashboard Cards:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: screenSize.isDesktop
                ? 3
                : screenSize.isTablet
                ? 2
                : 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: screenSize.isDesktop
                ? 1.5
                : screenSize.isTablet
                ? 1.2
                : 2,
            children: <Widget>[
              _buildDashboardCard(
                context,
                'Revenue',
                r'$125,430',
                Icons.trending_up,
                Colors.green,
              ),
              _buildDashboardCard(
                context,
                'Orders',
                '1,234',
                Icons.shopping_cart,
                Colors.blue,
              ),
              _buildDashboardCard(
                context,
                'Customers',
                '567',
                Icons.people,
                Colors.orange,
              ),
              if (screenSize.isDesktop) ...<Widget>[
                _buildDashboardCard(
                  context,
                  'Growth',
                  '+12.5%',
                  Icons.show_chart,
                  Colors.purple,
                ),
                _buildDashboardCard(
                  context,
                  'Conversion',
                  '3.2%',
                  Icons.analytics,
                  Colors.teal,
                ),
                _buildDashboardCard(
                  context,
                  'Retention',
                  '85%',
                  Icons.repeat,
                  Colors.indigo,
                ),
              ],
            ],
          ),

          const SizedBox(height: 24),

          // Feature summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Phase 5 Implementation Status',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('✅ Phase 5.1: Animation System - Implemented'),
                const Text(
                  '✅ Phase 5.2: Responsive System - Implemented & Working',
                ),
                const Text(
                  '✅ Phase 5.3: Accessibility Enhancements - Implemented',
                ),
                const SizedBox(height: 8),
                Text(
                  'All Phase 5 features have been successfully implemented! 🎉',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildDashboardCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) => Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

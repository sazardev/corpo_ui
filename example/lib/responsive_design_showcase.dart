import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';

/// Responsive Design Showcase demonstrating adaptive layouts.
///
/// This example showcases how to build responsive applications using
/// Corpo UI's responsive utilities and adaptive components. It demonstrates:
/// - Responsive breakpoints and screen size detection
/// - Adaptive layouts for different screen sizes
/// - Cross-platform compatibility
/// - Responsive typography and spacing
class ResponsiveDesignShowcase extends StatelessWidget {
  const ResponsiveDesignShowcase({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Responsive Design Showcase',
      theme: CorpoTheme.light(),
      darkTheme: CorpoTheme.dark(),
      home: const ResponsiveHomePage(),
    );
}

/// Main page demonstrating responsive design patterns.
class ResponsiveHomePage extends StatefulWidget {
  const ResponsiveHomePage({super.key});

  @override
  State<ResponsiveHomePage> createState() => _ResponsiveHomePageState();
}

class _ResponsiveHomePageState extends State<ResponsiveHomePage> {
  int _selectedIndex = 0;

  final List<ResponsivePageData> _pages = <ResponsivePageData>[
    const ResponsivePageData(
      title: 'Layout Demo',
      icon: Icons.view_quilt,
      page: ResponsiveLayoutDemo(),
    ),
    const ResponsivePageData(
      title: 'Grid Systems',
      icon: Icons.grid_view,
      page: ResponsiveGridDemo(),
    ),
    const ResponsivePageData(
      title: 'Navigation',
      icon: Icons.navigation,
      page: ResponsiveNavigationDemo(),
    ),
    const ResponsivePageData(
      title: 'Typography',
      icon: Icons.text_fields,
      page: ResponsiveTypographyDemo(),
    ),
  ];

  @override
  Widget build(BuildContext context) => CorpoResponsiveBuilder(
      builder: (BuildContext context, CorpoScreenSize screenSize) {
        // Determine layout based on screen size
        final bool isMobile = screenSize.isMobile;
        final bool isTablet = screenSize.isTablet;
        final bool isDesktop = screenSize.isDesktop;

        if (isDesktop) {
          return _buildDesktopLayout();
        } else if (isTablet) {
          return _buildTabletLayout();
        } else {
          return _buildMobileLayout();
        }
      },
    );

  Widget _buildDesktopLayout() => Scaffold(
      body: Row(
        children: <Widget>[
          // Side navigation for desktop
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: _pages
                .map(
                  (ResponsivePageData page) => NavigationRailDestination(
                    icon: Icon(page.icon),
                    label: Text(page.title),
                  ),
                )
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Main content area
          Expanded(
            child: Column(
              children: <Widget>[
                _buildAppBar(),
                Expanded(child: _pages[_selectedIndex].page),
              ],
            ),
          ),
        ],
      ),
    );

  Widget _buildTabletLayout() => Scaffold(
      appBar: _buildAppBar(),
      body: _pages[_selectedIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _pages
            .map(
              (ResponsivePageData page) => BottomNavigationBarItem(
                icon: Icon(page.icon),
                label: page.title,
              ),
            )
            .toList(),
      ),
    );

  Widget _buildMobileLayout() => Scaffold(
      appBar: _buildAppBar(),
      body: _pages[_selectedIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _pages
            .map(
              (ResponsivePageData page) => BottomNavigationBarItem(
                icon: Icon(page.icon),
                label: page.title,
              ),
            )
            .toList(),
      ),
    );

  PreferredSizeWidget _buildAppBar() => AppBar(
      title: Text(_pages[_selectedIndex].title),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: _showResponsiveInfo,
        ),
      ],
    );

  void _showResponsiveInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Responsive Design'),
        content: CorpoResponsiveBuilder(
          builder: (BuildContext context, CorpoScreenSize screenSize) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Current Screen Size: ${screenSize.deviceType.toString().split('.').last}',
                ),
                Text(
                  'Window Size: ${MediaQuery.of(context).size.width.toInt()} x ${MediaQuery.of(context).size.height.toInt()}',
                ),
                const SizedBox(height: 16),
                const Text('This layout adapts based on screen size:'),
                const SizedBox(height: 8),
                const Text('• Mobile: Bottom navigation'),
                const Text('• Tablet: Bottom navigation'),
                const Text('• Desktop: Side navigation rail'),
              ],
            ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

/// Page data for responsive navigation.
class ResponsivePageData {
  const ResponsivePageData({
    required this.title,
    required this.icon,
    required this.page,
  });

  final String title;
  final IconData icon;
  final Widget page;
}

/// Responsive layout demonstration.
class ResponsiveLayoutDemo extends StatelessWidget {
  const ResponsiveLayoutDemo({super.key});

  @override
  Widget build(BuildContext context) => CorpoResponsiveBuilder(
      builder: (BuildContext context, CorpoScreenSize screenSize) {
        final bool isMobile = screenSize.isMobile;
        final bool isTablet = screenSize.isTablet;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildScreenInfo(context, screenSize),
              const SizedBox(height: 24),
              _buildAdaptiveCards(context, screenSize),
              const SizedBox(height: 24),
              _buildResponsiveContent(context, screenSize),
            ],
          ),
        );
      },
    );

  Widget _buildScreenInfo(BuildContext context, CorpoScreenSize screenSize) => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Screen Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Screen Size: ${screenSize.deviceType.toString().split('.').last}',
            ),
            Text('Width: ${MediaQuery.of(context).size.width.toInt()}px'),
            Text('Height: ${MediaQuery.of(context).size.height.toInt()}px'),
            Text('Pixel Ratio: ${MediaQuery.of(context).devicePixelRatio}'),
          ],
        ),
      ),
    );

  Widget _buildAdaptiveCards(BuildContext context, CorpoScreenSize screenSize) {
    final bool isMobile = screenSize.isMobile;
    final int crossAxisCount = isMobile
        ? 1
        : screenSize.isTablet
        ? 2
        : 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Adaptive Card Grid',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) => Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.widgets, size: isMobile ? 32 : 48),
                  const SizedBox(height: 8),
                  Text(
                    'Card ${index + 1}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveContent(
    BuildContext context,
    CorpoScreenSize screenSize,
  ) {
    final bool isMobile = screenSize.isMobile;

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Mobile Layout', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          _buildContentCard('Primary Content'),
          const SizedBox(height: 16),
          _buildContentCard('Secondary Content'),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Desktop/Tablet Layout',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 2, child: _buildContentCard('Primary Content')),
              const SizedBox(width: 16),
              Expanded(child: _buildContentCard('Secondary Content')),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildContentCard(String title) => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'This content adapts its layout based on the available screen space. '
              'On mobile devices, content stacks vertically for better readability. '
              'On larger screens, content can be displayed side by side.',
            ),
          ],
        ),
      ),
    );
}

/// Responsive grid system demonstration.
class ResponsiveGridDemo extends StatelessWidget {
  const ResponsiveGridDemo({super.key});

  @override
  Widget build(BuildContext context) => CorpoResponsiveBuilder(
      builder: (BuildContext context, CorpoScreenSize screenSize) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Responsive Grid Systems',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              _buildBreakpointGrid(context, screenSize),
              const SizedBox(height: 24),
              _buildFlexibleGrid(context, screenSize),
            ],
          ),
        ),
    );

  Widget _buildBreakpointGrid(
    BuildContext context,
    CorpoScreenSize screenSize,
  ) {
    // Define columns based on screen size
    int columns;
    if (screenSize.isMobile) {
      columns = 1;
    } else if (screenSize.isTablet) {
      columns = 2;
    } else {
      columns = 4;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Breakpoint-Based Grid ($columns columns)',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFlexibleGrid(BuildContext context, CorpoScreenSize screenSize) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Flexible Grid (Auto-sizing)',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(
            12,
            (int index) => Container(
              width: screenSize.isMobile
                  ? (MediaQuery.of(context).size.width - 44) / 2
                  : screenSize.isTablet
                  ? (MediaQuery.of(context).size.width - 60) / 3
                  : (MediaQuery.of(context).size.width - 100) / 6,
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
}

/// Responsive navigation patterns demonstration.
class ResponsiveNavigationDemo extends StatelessWidget {
  const ResponsiveNavigationDemo({super.key});

  @override
  Widget build(BuildContext context) => CorpoResponsiveBuilder(
      builder: (BuildContext context, CorpoScreenSize screenSize) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Responsive Navigation Patterns',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              _buildCurrentPattern(context, screenSize),
              const SizedBox(height: 24),
              _buildNavigationExamples(context),
            ],
          ),
        ),
    );

  Widget _buildCurrentPattern(
    BuildContext context,
    CorpoScreenSize screenSize,
  ) {
    String pattern;
    String description;

    if (screenSize.isMobile) {
      pattern = 'Bottom Navigation';
      description = 'Tab-based navigation at the bottom for easy thumb access';
    } else if (screenSize.isTablet) {
      pattern = 'Bottom Navigation';
      description =
          'Bottom navigation with larger touch targets for tablet use';
    } else {
      pattern = 'Navigation Rail';
      description = 'Side navigation rail for efficient desktop navigation';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Current Navigation Pattern',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Pattern: $pattern'),
            Text('Description: $description'),
            Text(
              'Screen Size: ${screenSize.deviceType.toString().split('.').last}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationExamples(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Navigation Pattern Examples',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Mobile (< 600px): Bottom Navigation'),
                Text('• Primary navigation at bottom'),
                Text('• 3-5 main sections'),
                Text('• Thumb-friendly design'),
                SizedBox(height: 12),
                Text('Tablet (600-1200px): Bottom Navigation or Drawer'),
                Text('• Bottom navigation for simple apps'),
                Text('• Navigation drawer for complex apps'),
                Text('• Larger touch targets'),
                SizedBox(height: 12),
                Text('Desktop (> 1200px): Navigation Rail or Sidebar'),
                Text('• Persistent side navigation'),
                Text('• Efficient use of horizontal space'),
                Text('• Mouse and keyboard optimized'),
              ],
            ),
          ),
        ),
      ],
    );
}

/// Responsive typography demonstration.
class ResponsiveTypographyDemo extends StatelessWidget {
  const ResponsiveTypographyDemo({super.key});

  @override
  Widget build(BuildContext context) => CorpoResponsiveBuilder(
      builder: (BuildContext context, CorpoScreenSize screenSize) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Responsive Typography',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              _buildTypographyScale(context, screenSize),
              const SizedBox(height: 24),
              _buildReadabilityExample(context, screenSize),
            ],
          ),
        ),
    );

  Widget _buildTypographyScale(
    BuildContext context,
    CorpoScreenSize screenSize,
  ) => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Typography Scale',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Display Large',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              'Display Medium',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              'Headline Large',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'Headline Medium',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text('Title Large', style: Theme.of(context).textTheme.titleLarge),
            Text(
              'Title Medium',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text('Body Large', style: Theme.of(context).textTheme.bodyLarge),
            Text('Body Medium', style: Theme.of(context).textTheme.bodyMedium),
            Text('Body Small', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );

  Widget _buildReadabilityExample(
    BuildContext context,
    CorpoScreenSize screenSize,
  ) {
    final bool isMobile = screenSize.isMobile;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Readable Content',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'This text adapts to different screen sizes to maintain optimal readability. '
              'On mobile devices, the line length is shorter and spacing is adjusted for touch interaction. '
              'On desktop screens, the content can use more horizontal space while maintaining comfortable reading patterns.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: isMobile ? 1.5 : 1.6),
            ),
            const SizedBox(height: 16),
            Text(
              'Screen Size: ${screenSize.deviceType.toString().split('.').last}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Optimal line length maintained for readability',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

/// Entry point for the responsive design showcase.
void main() {
  runApp(const ResponsiveDesignShowcase());
}

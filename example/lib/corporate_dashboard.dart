import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';

/// Corporate Dashboard Example showcasing real-world usage patterns.
///
/// This example demonstrates how to build a comprehensive corporate
/// dashboard using Corpo UI components. It includes:
/// - Navigation patterns
/// - Data visualization layouts
/// - Form integration
/// - Responsive design
/// - Professional styling
class CorporateDashboard extends StatefulWidget {
  const CorporateDashboard({super.key});

  @override
  State<CorporateDashboard> createState() => _CorporateDashboardState();
}

class _CorporateDashboardState extends State<CorporateDashboard> {
  int _currentPageIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      label: 'Dashboard',
      icon: Icons.dashboard,
      page: const DashboardPage(),
    ),
    NavigationItem(
      label: 'Analytics',
      icon: Icons.analytics,
      page: const AnalyticsPage(),
    ),
    NavigationItem(label: 'Users', icon: Icons.people, page: const UsersPage()),
    NavigationItem(
      label: 'Settings',
      icon: Icons.settings,
      page: const SettingsPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corporate Dashboard',
      theme: CorpoTheme.light(),
      darkTheme: CorpoTheme.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: _buildAppBar(),
        drawer: _buildDrawer(),
        body: _navigationItems[_currentPageIndex].page,
        bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(_navigationItems[_currentPageIndex].label),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: _showNotifications,
          tooltip: 'Notifications',
        ),
        const SizedBox(width: 8),
        PopupMenuButton<String>(
          icon: const CircleAvatar(
            radius: 16,
            child: Icon(Icons.person, size: 20),
          ),
          onSelected: _handleUserMenuSelection,
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'profile', child: Text('Profile')),
            const PopupMenuItem(value: 'logout', child: Text('Logout')),
          ],
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Company Portal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Welcome, John Doe',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
          ..._navigationItems.asMap().entries.map((entry) {
            final int index = entry.key;
            final NavigationItem item = entry.value;
            return ListTile(
              leading: Icon(item.icon),
              title: Text(item.label),
              selected: _currentPageIndex == index,
              onTap: () {
                setState(() {
                  _currentPageIndex = index;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: _showHelp,
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: _showFeedback,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentPageIndex,
      onTap: (index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      items: _navigationItems
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            ),
          )
          .toList(),
    );
  }

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: const SizedBox(
          width: 300,
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.info, color: Colors.blue),
                title: Text('System Update'),
                subtitle: Text('New features available'),
              ),
              ListTile(
                leading: Icon(Icons.warning, color: Colors.orange),
                title: Text('Maintenance'),
                subtitle: Text('Scheduled for tonight'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _handleUserMenuSelection(String value) {
    switch (value) {
      case 'profile':
        _showProfile();
        break;
      case 'logout':
        _showLogoutConfirmation();
        break;
    }
  }

  void _showProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('User Profile'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            SizedBox(height: 16),
            Text('John Doe'),
            Text('john.doe@company.com'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Perform logout
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showHelp() {
    Navigator.pop(context);
    // Navigate to help page
  }

  void _showFeedback() {
    Navigator.pop(context);
    // Navigate to feedback page
  }
}

/// Navigation item data class.
class NavigationItem {
  const NavigationItem({
    required this.label,
    required this.icon,
    required this.page,
  });

  final String label;
  final IconData icon;
  final Widget page;
}

/// Dashboard page with KPIs and quick actions.
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Overview',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          _buildKPICards(),
          const SizedBox(height: 24),
          _buildQuickActions(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildKPICards() {
    return const Row(
      children: [
        Expanded(
          child: KPICard(title: 'Total Users', value: '12,345', trend: 5.2),
        ),
        SizedBox(width: 16),
        Expanded(
          child: KPICard(title: 'Revenue', value: '\$45,678', trend: -2.1),
        ),
        SizedBox(width: 16),
        Expanded(
          child: KPICard(title: 'Orders', value: '1,234', trend: 12.5),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle),
                  label: const Text('New User'),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.upload),
                  label: const Text('Import Data'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: const Text('Export Report'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) => ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text('User ${index + 1} performed an action'),
                subtitle: Text('${5 - index} minutes ago'),
                trailing: const Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// KPI card widget for displaying key metrics.
class KPICard extends StatelessWidget {
  const KPICard({
    super.key,
    required this.title,
    required this.value,
    required this.trend,
  });

  final String title;
  final String value;
  final double trend;

  @override
  Widget build(BuildContext context) {
    final bool isPositive = trend >= 0;
    final Color trendColor = isPositive ? Colors.green : Colors.red;
    final IconData trendIcon = isPositive
        ? Icons.trending_up
        : Icons.trending_down;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(trendIcon, size: 16, color: trendColor),
                const SizedBox(width: 4),
                Text(
                  '${trend.abs().toStringAsFixed(1)}%',
                  style: TextStyle(color: trendColor, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Analytics page with charts and detailed metrics.
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analytics',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Chart placeholder - User Engagement'),
                  SizedBox(height: 100),
                  LinearProgressIndicator(value: 0.75),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Users management page.
class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Users Management',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'User table would go here with search, filters, and actions.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Settings page with configuration options.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Settings and configuration options would go here.'),
            ),
          ),
        ],
      ),
    );
  }
}

/// Entry point for the dashboard example.
void main() {
  runApp(const CorporateDashboard());
}

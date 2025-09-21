/// Corpo UI - Complete ShadCN Demo
///
/// This example demonstrates the revolutionary ShadCN philosophy in Flutter:
/// "Change one file, transform your entire app"
///
/// Every component you see here is styled by lib/src/design_tokens.dart
/// Switch themes instantly and watch the ENTIRE app transform!

import 'package:flutter/material.dart';
import 'package:corpo_ui/corpo_ui.dart';
import 'corpo_theme.dart';

void main() {
  runApp(const CorpoUIDemo());
}

class CorpoUIDemo extends StatelessWidget {
  const CorpoUIDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corpo UI - ShadCN for Flutter',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: CorpoDesignTokens().fontFamily,
      ),
      home: const DemoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;
  String _selectedUser = 'all';
  bool _notificationsEnabled = true;
  bool _marketingEmails = false;
  double _volume = 75;

  final List<String> _pages = [
    'Dashboard',
    'Components',
    'Forms',
    'Data Tables',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Scaffold(
      backgroundColor: tokens.surfaceColor,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildFAB(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return AppBar(
      backgroundColor: tokens.primaryColor,
      foregroundColor: tokens.getTextColorFor(tokens.primaryColor),
      title: Row(
        children: [
          CorpoIcon(
            Icons.business_center,
            size: CorpoIconSize.medium,
            color: tokens.getTextColorFor(tokens.primaryColor),
          ),
          CorpoSpacer.small(),
          CorpoHeading(
            'Corpo UI Demo',
            level: CorpoHeadingLevel.h2,
            color: tokens.getTextColorFor(tokens.primaryColor),
          ),
        ],
      ),
      actions: [
        // Theme Switcher - The MAGIC happens here!
        CorpoThemeSwitcher(),
        CorpoSpacer.small(),
        CorpoIconButton(
          icon: Icons.notifications,
          onPressed: () => _showNotificationsDialog(),
          variant: CorpoIconButtonVariant.secondary,
        ),
        CorpoSpacer.small(),
      ],
      elevation: 0,
    );
  }

  Widget _buildDrawer() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Drawer(
      backgroundColor: tokens.surfaceColor,
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(color: tokens.primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CorpoAvatar.withStatus(
                  name: 'Sarah Wilson',
                  status: CorpoAvatarStatus.online,
                  size: CorpoAvatarSize.large,
                ),
                CorpoSpacer.medium(),
                CorpoHeading(
                  'Sarah Wilson',
                  level: CorpoHeadingLevel.h3,
                  color: tokens.getTextColorFor(tokens.primaryColor),
                ),
                CorpoText(
                  'Product Manager',
                  variant: CorpoTextVariant.bodyMedium,
                  color: tokens
                      .getTextColorFor(tokens.primaryColor)
                      .withOpacity(0.8),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(tokens.spacing2x),
              children: [
                _buildDrawerItem(Icons.dashboard, 'Dashboard', 0),
                _buildDrawerItem(Icons.widgets, 'Components', 1),
                _buildDrawerItem(Icons.edit_note, 'Forms', 2),
                _buildDrawerItem(Icons.table_chart, 'Data Tables', 3),
                _buildDrawerItem(Icons.settings, 'Settings', 4),
                CorpoDivider(),
                _buildDrawerItem(Icons.help, 'Help & Support', -1),
                _buildDrawerItem(Icons.info, 'About', -1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final bool isSelected = _selectedIndex == index;

    return CorpoListTile(
      leading: CorpoIcon(
        icon,
        color: isSelected ? tokens.primaryColor : tokens.textSecondary,
        size: CorpoIconSize.small,
      ),
      title: Text(title),
      onTap: index >= 0
          ? () {
              setState(() => _selectedIndex = index);
              Navigator.pop(context);
            }
          : null,
      variant: isSelected
          ? CorpoListTileVariant.emphasized
          : CorpoListTileVariant.standard,
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildComponentsDemo();
      case 2:
        return _buildFormsDemo();
      case 3:
        return _buildDataTablesDemo();
      case 4:
        return _buildSettingsDemo();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return SingleChildScrollView(
      padding: EdgeInsets.all(tokens.spacing4x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          CorpoCard(
            padding: CorpoCardPadding.large,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CorpoHeading(
                        'Welcome back, Sarah! 👋',
                        level: CorpoHeadingLevel.h1,
                      ),
                      CorpoSpacer.small(),
                      CorpoText(
                        'Here\'s what\'s happening with your projects today.',
                        variant: CorpoTextVariant.bodyLarge,
                        color: tokens.textSecondary,
                      ),
                    ],
                  ),
                ),
                CorpoButton(
                  onPressed: () => _showNewProjectDialog(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CorpoIcon(Icons.add, size: CorpoIconSize.small),
                      CorpoSpacer.extraSmall(),
                      const Text('New Project'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CorpoSpacer.large(),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Active Projects',
                  '12',
                  Icons.folder,
                  tokens.primaryColor,
                ),
              ),
              CorpoSpacer.medium(),
              Expanded(
                child: _buildStatCard(
                  'Team Members',
                  '24',
                  Icons.people,
                  tokens.successColor,
                ),
              ),
              CorpoSpacer.medium(),
              Expanded(
                child: _buildStatCard(
                  'Completed Tasks',
                  '156',
                  Icons.check_circle,
                  tokens.infoColor,
                ),
              ),
              CorpoSpacer.medium(),
              Expanded(
                child: _buildStatCard(
                  'Pending Reviews',
                  '8',
                  Icons.rate_review,
                  tokens.warningColor,
                ),
              ),
            ],
          ),
          CorpoSpacer.large(),

          // Recent Activity
          CorpoCard(
            padding: CorpoCardPadding.large,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CorpoHeading(
                      'Recent Activity',
                      level: CorpoHeadingLevel.h2,
                    ),
                    CorpoTextButton(
                      onPressed: () {},
                      child: const Text('View All'),
                    ),
                  ],
                ),
                CorpoSpacer.medium(),
                CorpoTimeline(
                  shrinkWrap:
                      true, // ✅ CRITICAL: Fix unbounded height in Column
                  items: [
                    CorpoTimelineItem(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CorpoText(
                            'Project "Mobile App" updated',
                            variant: CorpoTextVariant.bodyMedium,
                          ),
                          CorpoText(
                            'Added new user authentication flow',
                            variant: CorpoTextVariant.bodySmall,
                            color: tokens.textSecondary,
                          ),
                          CorpoText(
                            '2 hours ago',
                            variant: CorpoTextVariant.caption,
                            color: tokens.textSecondary,
                          ),
                        ],
                      ),
                      indicator: CorpoIcon(
                        Icons.app_registration,
                        size: CorpoIconSize.small,
                      ),
                    ),
                    CorpoTimelineItem(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CorpoText(
                            'Team meeting completed',
                            variant: CorpoTextVariant.bodyMedium,
                          ),
                          CorpoText(
                            'Sprint planning for Q4 objectives',
                            variant: CorpoTextVariant.bodySmall,
                            color: tokens.textSecondary,
                          ),
                          CorpoText(
                            '5 hours ago',
                            variant: CorpoTextVariant.caption,
                            color: tokens.textSecondary,
                          ),
                        ],
                      ),
                      indicator: CorpoIcon(
                        Icons.meeting_room,
                        size: CorpoIconSize.small,
                      ),
                    ),
                    CorpoTimelineItem(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CorpoText(
                            'Code review approved',
                            variant: CorpoTextVariant.bodyMedium,
                          ),
                          CorpoText(
                            'Feature branch merged to development',
                            variant: CorpoTextVariant.bodySmall,
                            color: tokens.textSecondary,
                          ),
                          CorpoText(
                            '1 day ago',
                            variant: CorpoTextVariant.caption,
                            color: tokens.textSecondary,
                          ),
                        ],
                      ),
                      indicator: CorpoIcon(
                        Icons.code,
                        size: CorpoIconSize.small,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return CorpoCard(
      padding: CorpoCardPadding.medium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CorpoIcon(icon, color: color, size: CorpoIconSize.medium),
              CorpoBadge(
                '+12%',
                variant: CorpoBadgeVariant.success,
                size: CorpoBadgeSize.small,
              ),
            ],
          ),
          CorpoSpacer.medium(),
          CorpoHeading(value, level: CorpoHeadingLevel.h1, color: color),
          CorpoSpacer.extraSmall(),
          CorpoText(
            title,
            variant: CorpoTextVariant.bodyMedium,
            color: tokens.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildComponentsDemo() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return SingleChildScrollView(
      padding: EdgeInsets.all(tokens.spacing4x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CorpoHeading('Component Showcase', level: CorpoHeadingLevel.h1),
          CorpoSpacer.small(),
          CorpoText(
            'All these components are styled by design tokens. Change one file, transform everything!',
            variant: CorpoTextVariant.bodyLarge,
            color: tokens.textSecondary,
          ),
          CorpoSpacer.large(),

          // Buttons Section
          _buildComponentSection(
            'Buttons',
            'Various button styles and states',
            Column(
              children: [
                Row(
                  children: [
                    CorpoButton(onPressed: () {}, child: const Text('Primary')),
                    CorpoSpacer.medium(),
                    CorpoOutlinedButton(
                      onPressed: () {},
                      child: const Text('Outlined'),
                    ),
                    CorpoSpacer.medium(),
                    CorpoTextButton(
                      onPressed: () {},
                      child: const Text('Text'),
                    ),
                  ],
                ),
                CorpoSpacer.medium(),
                Row(
                  children: [
                    CorpoButton.danger(
                      onPressed: () {},
                      child: const Text('Danger'),
                    ),
                    CorpoSpacer.medium(),
                    CorpoButton(onPressed: null, child: const Text('Disabled')),
                    CorpoSpacer.medium(),
                    CorpoIconButton(icon: Icons.favorite, onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),

          // Badges Section
          _buildComponentSection(
            'Badges & Status',
            'Status indicators and notifications',
            Wrap(
              spacing: tokens.spacing2x,
              runSpacing: tokens.spacing2x,
              children: [
                CorpoBadge('Active', variant: CorpoBadgeVariant.success),
                CorpoBadge('Pending', variant: CorpoBadgeVariant.warning),
                CorpoBadge('Error', variant: CorpoBadgeVariant.error),
                CorpoBadge('Info', variant: CorpoBadgeVariant.info),
                CorpoBadge.count(12, variant: CorpoBadgeVariant.primary),
                CorpoBadge.dot(variant: CorpoBadgeVariant.success),
              ],
            ),
          ),

          // Avatars Section
          _buildComponentSection(
            'Avatars',
            'User representation components',
            Row(
              children: [
                CorpoAvatar.initials('John Doe', size: CorpoAvatarSize.small),
                CorpoSpacer.medium(),
                CorpoAvatar.initials(
                  'Jane Smith',
                  size: CorpoAvatarSize.medium,
                ),
                CorpoSpacer.medium(),
                CorpoAvatar.withStatus(
                  name: 'Bob Wilson',
                  status: CorpoAvatarStatus.online,
                  size: CorpoAvatarSize.large,
                ),
                CorpoSpacer.medium(),
                CorpoAvatar.withStatus(
                  name: 'Alice Brown',
                  status: CorpoAvatarStatus.away,
                  size: CorpoAvatarSize.extraLarge,
                ),
              ],
            ),
          ),

          // Progress & Loading
          _buildComponentSection(
            'Progress & Loading',
            'Progress indicators and loading states',
            Column(
              children: [
                CorpoProgressBar(value: 0.7, label: 'Project Progress'),
                CorpoSpacer.medium(),
                Row(
                  children: [
                    CorpoSpinner(size: CorpoSpinnerSize.small),
                    CorpoSpacer.medium(),
                    CorpoSpinner(size: CorpoSpinnerSize.medium),
                    CorpoSpacer.medium(),
                    CorpoSpinner(size: CorpoSpinnerSize.large),
                    CorpoSpacer.medium(),
                    CorpoText(
                      'Loading...',
                      variant: CorpoTextVariant.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentSection(
    String title,
    String description,
    Widget content,
  ) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Column(
      children: [
        CorpoCard(
          padding: CorpoCardPadding.large,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CorpoHeading(title, level: CorpoHeadingLevel.h3),
              CorpoSpacer.extraSmall(),
              CorpoText(
                description,
                variant: CorpoTextVariant.bodyMedium,
                color: tokens.textSecondary,
              ),
              CorpoSpacer.large(),
              content,
            ],
          ),
        ),
        CorpoSpacer.large(),
      ],
    );
  }

  Widget _buildFormsDemo() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return SingleChildScrollView(
      padding: EdgeInsets.all(tokens.spacing4x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CorpoHeading('Forms & Inputs', level: CorpoHeadingLevel.h1),
          CorpoSpacer.small(),
          CorpoText(
            'Complete form controls with validation and accessibility.',
            variant: CorpoTextVariant.bodyLarge,
            color: tokens.textSecondary,
          ),
          CorpoSpacer.large(),
          CorpoCard(
            padding: CorpoCardPadding.large,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CorpoHeading('User Registration', level: CorpoHeadingLevel.h2),
                CorpoSpacer.large(),

                // Text Fields
                CorpoTextField(
                  label: 'Full Name',
                  placeholder: 'Enter your full name',
                  helperText: 'This will be displayed on your profile',
                ),
                CorpoSpacer.medium(),

                CorpoTextField(
                  label: 'Email Address',
                  placeholder: 'name@company.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                CorpoSpacer.medium(),

                CorpoTextField(
                  label: 'Password',
                  placeholder: 'Enter a secure password',
                  obscureText: true,
                  helperText: 'Must be at least 8 characters',
                ),
                CorpoSpacer.large(),

                // Checkboxes
                CorpoCheckbox(
                  value: _notificationsEnabled,
                  onChanged: (value) =>
                      setState(() => _notificationsEnabled = value ?? false),
                  label: 'Email notifications',
                  description: 'Receive updates about your account',
                ),
                CorpoSpacer.medium(),

                CorpoCheckbox(
                  value: _marketingEmails,
                  onChanged: (value) =>
                      setState(() => _marketingEmails = value ?? false),
                  label: 'Marketing emails',
                  description: 'Receive product updates and offers',
                ),
                CorpoSpacer.large(),

                // Switch
                CorpoSwitch(
                  value: _isDarkMode,
                  onChanged: (value) => setState(() => _isDarkMode = value),
                  label: 'Dark Mode',
                  description: 'Toggle between light and dark themes',
                ),
                CorpoSpacer.large(),

                // Radio Buttons
                CorpoText('Account Type', variant: CorpoTextVariant.labelLarge),
                CorpoSpacer.small(),

                CorpoRadio<String>(
                  value: 'personal',
                  groupValue: _selectedUser,
                  onChanged: (value) => setState(() => _selectedUser = value!),
                  label: 'Personal Account',
                  description: 'For individual use',
                ),

                CorpoRadio<String>(
                  value: 'business',
                  groupValue: _selectedUser,
                  onChanged: (value) => setState(() => _selectedUser = value!),
                  label: 'Business Account',
                  description: 'For teams and organizations',
                ),
                CorpoSpacer.large(),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: CorpoButton(
                        onPressed: () => _showSuccessAlert(),
                        child: const Text('Create Account'),
                      ),
                    ),
                    CorpoSpacer.medium(),
                    Expanded(
                      child: CorpoOutlinedButton(
                        onPressed: () {},
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTablesDemo() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return SingleChildScrollView(
      padding: EdgeInsets.all(tokens.spacing4x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CorpoHeading('Data Tables', level: CorpoHeadingLevel.h1),
          CorpoSpacer.small(),
          CorpoText(
            'Comprehensive data display with sorting and selection.',
            variant: CorpoTextVariant.bodyLarge,
            color: tokens.textSecondary,
          ),
          CorpoSpacer.large(),
          CorpoCard(
            padding: CorpoCardPadding.large,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CorpoHeading('Team Members', level: CorpoHeadingLevel.h2),
                    CorpoButton(
                      onPressed: () {},
                      child: const Text('Add Member'),
                    ),
                  ],
                ),
                CorpoSpacer.large(),

                // Member List
                ...List.generate(5, (index) {
                  final members = [
                    {
                      'name': 'John Doe',
                      'role': 'Developer',
                      'status': 'Active',
                    },
                    {
                      'name': 'Jane Smith',
                      'role': 'Designer',
                      'status': 'Active',
                    },
                    {'name': 'Bob Wilson', 'role': 'Manager', 'status': 'Away'},
                    {
                      'name': 'Alice Brown',
                      'role': 'Developer',
                      'status': 'Active',
                    },
                    {
                      'name': 'Charlie Davis',
                      'role': 'QA Engineer',
                      'status': 'Offline',
                    },
                  ];

                  final member = members[index];
                  return Column(
                    children: [
                      CorpoListTile(
                        leading: CorpoAvatar.initials(member['name']!),
                        title: Text(member['name']!),
                        subtitle: Text(member['role']!),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CorpoBadge(
                              member['status']!,
                              variant: member['status'] == 'Active'
                                  ? CorpoBadgeVariant.success
                                  : member['status'] == 'Away'
                                      ? CorpoBadgeVariant.warning
                                      : CorpoBadgeVariant.neutral,
                              size: CorpoBadgeSize.small,
                            ),
                            CorpoSpacer.small(),
                            CorpoIconButton(
                              icon: Icons.more_vert,
                              onPressed: () {},
                              size: CorpoIconButtonSize.small,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      if (index < 4) CorpoDivider(),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsDemo() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return SingleChildScrollView(
      padding: EdgeInsets.all(tokens.spacing4x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CorpoHeading('Settings', level: CorpoHeadingLevel.h1),
          CorpoSpacer.small(),
          CorpoText(
            'Application preferences and configurations.',
            variant: CorpoTextVariant.bodyLarge,
            color: tokens.textSecondary,
          ),
          CorpoSpacer.large(),

          // Theme Settings
          CorpoCard(
            padding: CorpoCardPadding.large,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CorpoHeading('Theme Settings', level: CorpoHeadingLevel.h2),
                CorpoSpacer.medium(),
                CorpoText(
                  'Customize the appearance of your application.',
                  variant: CorpoTextVariant.bodyMedium,
                  color: tokens.textSecondary,
                ),
                CorpoSpacer.large(),

                // Theme Preset Buttons - THE MAGIC! 🎨
                CorpoText(
                  'Quick Theme Presets',
                  variant: CorpoTextVariant.labelLarge,
                ),
                CorpoSpacer.medium(),
                Wrap(
                  spacing: tokens.spacing2x,
                  runSpacing: tokens.spacing2x,
                  children: [
                    CorpoButton(
                      onPressed: () {
                        CorpoDesignTokens.applyCorporateTheme();
                        setState(() {}); // Refresh UI
                      },
                      child: const Text('Corporate Blue'),
                    ),
                    CorpoButton(
                      onPressed: () {
                        CorpoDesignTokens.applyModernTheme();
                        setState(() {}); // Refresh UI
                      },
                      child: const Text('Modern Purple'),
                    ),
                    CorpoButton(
                      onPressed: () {
                        CorpoDesignTokens.applyFriendlyTheme();
                        setState(() {}); // Refresh UI
                      },
                      child: const Text('Friendly Orange'),
                    ),
                    CorpoButton(
                      onPressed: () {
                        CorpoDesignTokens.applyMinimalTheme();
                        setState(() {}); // Refresh UI
                      },
                      child: const Text('Minimal B&W'),
                    ),
                  ],
                ),
                CorpoSpacer.large(),

                // Volume Slider
                CorpoText(
                  'Volume: ${_volume.round()}%',
                  variant: CorpoTextVariant.labelLarge,
                ),
                CorpoSpacer.small(),
                Slider(
                  value: _volume,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  activeColor: tokens.primaryColor,
                  onChanged: (value) => setState(() => _volume = value),
                ),
              ],
            ),
          ),
          CorpoSpacer.large(),

          // Notification Settings
          CorpoCard(
            padding: CorpoCardPadding.large,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CorpoHeading('Notifications', level: CorpoHeadingLevel.h2),
                CorpoSpacer.large(),
                CorpoListTile(
                  leading: CorpoIcon(
                    Icons.notifications,
                    size: CorpoIconSize.medium,
                  ),
                  title: const Text('Push Notifications'),
                  subtitle: const Text('Receive notifications on this device'),
                  trailing: CorpoSwitch(
                    value: _notificationsEnabled,
                    onChanged: (value) =>
                        setState(() => _notificationsEnabled = value),
                  ),
                ),
                CorpoDivider(),
                CorpoListTile(
                  leading: CorpoIcon(Icons.email, size: CorpoIconSize.medium),
                  title: const Text('Email Notifications'),
                  subtitle: const Text('Receive notifications via email'),
                  trailing: CorpoSwitch(
                    value: _marketingEmails,
                    onChanged: (value) =>
                        setState(() => _marketingEmails = value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: tokens.primaryColor,
      unselectedItemColor: tokens.textSecondary,
      backgroundColor: tokens.surfaceColor,
      items: [
        BottomNavigationBarItem(
          icon: CorpoIcon(Icons.dashboard, size: CorpoIconSize.small),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: CorpoIcon(Icons.widgets, size: CorpoIconSize.small),
          label: 'Components',
        ),
        BottomNavigationBarItem(
          icon: CorpoIcon(Icons.edit_note, size: CorpoIconSize.small),
          label: 'Forms',
        ),
        BottomNavigationBarItem(
          icon: CorpoIcon(Icons.table_chart, size: CorpoIconSize.small),
          label: 'Data',
        ),
        BottomNavigationBarItem(
          icon: CorpoIcon(Icons.settings, size: CorpoIconSize.small),
          label: 'Settings',
        ),
      ],
    );
  }

  Widget _buildFAB() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return FloatingActionButton(
      onPressed: () => _showNewProjectDialog(),
      backgroundColor: tokens.primaryColor,
      foregroundColor: tokens.getTextColorFor(tokens.primaryColor),
      child: CorpoIcon(Icons.add, size: CorpoIconSize.medium),
    );
  }

  void _showNotificationsDialog() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: tokens.surfaceColor,
        title: CorpoHeading('Notifications', level: CorpoHeadingLevel.h3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CorpoListTile(
              leading: CorpoAvatar.initials(
                'John Doe',
                size: CorpoAvatarSize.small,
              ),
              title: const Text('New message from John'),
              subtitle: const Text('2 minutes ago'),
              dense: true,
            ),
            CorpoListTile(
              leading: CorpoIcon(Icons.task_alt, color: tokens.successColor),
              title: const Text('Task completed'),
              subtitle: const Text('1 hour ago'),
              dense: true,
            ),
            CorpoListTile(
              leading: CorpoIcon(Icons.meeting_room, color: tokens.infoColor),
              title: const Text('Meeting reminder'),
              subtitle: const Text('3 hours ago'),
              dense: true,
            ),
          ],
        ),
        actions: [
          CorpoTextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          CorpoButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Mark All Read'),
          ),
        ],
      ),
    );
  }

  void _showNewProjectDialog() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: tokens.surfaceColor,
        title: CorpoHeading('Create New Project', level: CorpoHeadingLevel.h3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CorpoTextField(
              label: 'Project Name',
              placeholder: 'Enter project name',
            ),
            CorpoSpacer.medium(),
            CorpoTextField(
              label: 'Description',
              placeholder: 'Brief project description',
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          CorpoTextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          CorpoButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessAlert();
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showSuccessAlert() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: tokens.successColor,
        content: Row(
          children: [
            CorpoIcon(
              Icons.check_circle,
              color: tokens.getTextColorFor(tokens.successColor),
              size: CorpoIconSize.small,
            ),
            CorpoSpacer.small(),
            CorpoText(
              'Action completed successfully!',
              color: tokens.getTextColorFor(tokens.successColor),
              variant: CorpoTextVariant.bodyMedium,
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

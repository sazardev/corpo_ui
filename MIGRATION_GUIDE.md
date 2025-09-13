# Migrating from Material Design to Corpo UI

This guide helps you migrate from standard Material Design components to Corpo UI components, providing professional corporate styling while maintaining familiar APIs and behavior.

## Overview

Corpo UI builds upon Material Design principles while adding corporate-specific design patterns and enhanced accessibility features. The migration process is designed to be straightforward, with most components providing similar APIs to their Material counterparts.

## Component Migration Map

### Buttons

| Material Component | Corpo UI Component | Migration Notes |
|-------------------|-------------------|-----------------|
| `ElevatedButton` | `CorpoButton` | Primary button styling with corporate colors |
| `OutlinedButton` | `CorpoOutlinedButton` | Professional outlined styling |
| `TextButton` | `CorpoTextButton` | Minimal button with corporate typography |
| `IconButton` | `CorpoIconButton` | Icon-only button with enhanced accessibility |
| `FloatingActionButton` | `CorpoButton.floating` | Corporate-styled FAB variant |

#### Migration Example: Buttons

**Before (Material):**
```dart
ElevatedButton(
  onPressed: () => saveDocument(),
  child: Text('Save'),
)

OutlinedButton(
  onPressed: () => cancel(),
  child: Text('Cancel'),
)

TextButton(
  onPressed: () => learnMore(),
  child: Text('Learn More'),
)
```

**After (Corpo UI):**
```dart
CorpoButton(
  onPressed: () => saveDocument(),
  child: Text('Save'),
)

CorpoOutlinedButton(
  onPressed: () => cancel(),
  child: Text('Cancel'),
)

CorpoTextButton(
  onPressed: () => learnMore(),
  child: Text('Learn More'),
)
```

### Typography

| Material Component | Corpo UI Component | Migration Notes |
|-------------------|-------------------|-----------------|
| `Text` with theme styles | `CorpoText` | Semantic typography variants |
| Manual heading styles | `CorpoHeading` | Structured heading hierarchy |
| Code/monospace text | `CorpoCode` | Specialized code display |
| Form labels | `CorpoLabel` | Consistent form labeling |

#### Migration Example: Typography

**Before (Material):**
```dart
Text(
  'Welcome',
  style: Theme.of(context).textTheme.headlineLarge,
)

Text(
  'Body content here',
  style: Theme.of(context).textTheme.bodyMedium,
)
```

**After (Corpo UI):**
```dart
CorpoHeading(
  'Welcome',
  level: CorpoHeadingLevel.h1,
)

CorpoText(
  'Body content here',
  variant: CorpoTextVariant.bodyMedium,
)
```

### Form Components

| Material Component | Corpo UI Component | Migration Notes |
|-------------------|-------------------|-----------------|
| `TextField` | `CorpoTextField` | Enhanced validation and accessibility |
| `Checkbox` | `CorpoCheckbox` | Corporate styling with labels |
| `Switch` | `CorpoSwitch` | Professional toggle styling |
| `Radio` | `CorpoRadio` | Enhanced radio button groups |
| `DropdownButton` | `CorpoDropdown` | Improved dropdown with search |
| `Slider` | `CorpoSlider` | Corporate-styled range input |
| `DatePicker` | `CorpoDatePicker` | Enhanced date selection |
| `TimePicker` | `CorpoTimePicker` | Professional time input |

#### Migration Example: Forms

**Before (Material):**
```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
  ),
  validator: (value) => value?.isEmpty == true ? 'Required' : null,
)

Checkbox(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value ?? false),
)
```

**After (Corpo UI):**
```dart
CorpoTextField(
  label: 'Email',
  placeholder: 'Enter your email',
  validator: CorpoValidation.compose([
    CorpoValidation.required(),
    CorpoValidation.email(),
  ]),
)

CorpoCheckbox(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value ?? false),
  label: 'I agree to terms',
)
```

### Layout Components

| Material Component | Corpo UI Component | Migration Notes |
|-------------------|-------------------|-----------------|
| `Card` | `CorpoCard` | Professional card styling |
| `Divider` | `CorpoDivider` | Enhanced divider with labels |
| `Container` with styling | `CorpoSurface` | Semantic surface component |
| Manual spacing | `CorpoSpacer` | Consistent spacing system |

#### Migration Example: Layout

**Before (Material):**
```dart
Card(
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      children: [
        Text('Title'),
        SizedBox(height: 16),
        Text('Content'),
      ],
    ),
  ),
)
```

**After (Corpo UI):**
```dart
CorpoCard(
  child: Column(
    children: [
      CorpoHeading('Title', level: CorpoHeadingLevel.h3),
      CorpoSpacer.medium(),
      CorpoText('Content'),
    ],
  ),
)
```

### Navigation Components

| Material Component | Corpo UI Component | Migration Notes |
|-------------------|-------------------|-----------------|
| `AppBar` | `CorpoAppBar` | Corporate app bar styling |
| `BottomNavigationBar` | `CorpoBottomNavigation` | Enhanced bottom navigation |
| `TabBar` | `CorpoTabs` | Professional tab styling |
| `Drawer` | `CorpoDrawer` | Corporate navigation drawer |
| `Breadcrumbs` (manual) | `CorpoBreadcrumb` | Built-in breadcrumb navigation |

### Feedback Components

| Material Component | Corpo UI Component | Migration Notes |
|-------------------|-------------------|-----------------|
| `AlertDialog` | `CorpoDialog` | Corporate dialog styling |
| `SnackBar` | `CorpoSnackbar` | Enhanced notification system |
| `CircularProgressIndicator` | `CorpoSpinner` | Professional loading indicator |
| `LinearProgressIndicator` | `CorpoProgressBar` | Enhanced progress display |
| Manual alerts | `CorpoAlert` | Semantic alert components |

## Step-by-Step Migration Process

### 1. Update Dependencies

Add Corpo UI to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  corpo_ui: ^0.0.1
```

### 2. Import Corpo UI

Replace or add Corpo UI imports:

```dart
import 'package:corpo_ui/corpo_ui.dart';
```

### 3. Update Theme

Replace your Material theme with Corpo UI theme:

**Before:**
```dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    // ... other theme properties
  ),
  home: MyApp(),
)
```

**After:**
```dart
MaterialApp(
  theme: CorpoTheme.light(),
  darkTheme: CorpoTheme.dark(),
  themeMode: ThemeMode.system,
  home: MyApp(),
)
```

### 4. Migrate Components Gradually

Start with the most commonly used components and work your way through:

1. **Buttons** - Usually the easiest migration
2. **Typography** - Provides immediate visual improvement
3. **Form Components** - Enhanced validation and UX
4. **Layout Components** - Better spacing and consistency
5. **Navigation** - Improved navigation patterns
6. **Feedback** - Enhanced user feedback

### 5. Update Validation Logic

Corpo UI provides built-in validation utilities:

**Before:**
```dart
String? validateEmail(String? value) {
  if (value?.isEmpty == true) return 'Email is required';
  if (!value!.contains('@')) return 'Invalid email';
  return null;
}
```

**After:**
```dart
// Use built-in validation
validator: CorpoValidation.compose([
  CorpoValidation.required('Email is required'),
  CorpoValidation.email('Invalid email'),
])
```

## Common Migration Patterns

### Pattern 1: Form Migration

**Before:**
```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      TextField(
        decoration: InputDecoration(labelText: 'Name'),
        validator: (value) => value?.isEmpty == true ? 'Required' : null,
      ),
      SizedBox(height: 16),
      ElevatedButton(
        onPressed: _submit,
        child: Text('Submit'),
      ),
    ],
  ),
)
```

**After:**
```dart
CorpoForm(
  key: _formKey,
  children: [
    CorpoTextField(
      label: 'Name',
      validator: CorpoValidation.required(),
    ),
    CorpoSpacer.medium(),
    CorpoButton(
      onPressed: _submit,
      child: Text('Submit'),
    ),
  ],
)
```

### Pattern 2: Card Layout Migration

**Before:**
```dart
Card(
  margin: EdgeInsets.all(8),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 8),
        Text('Subtitle', style: Theme.of(context).textTheme.bodyMedium),
        Divider(),
        Text('Content'),
      ],
    ),
  ),
)
```

**After:**
```dart
CorpoCard(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CorpoHeading('Title', level: CorpoHeadingLevel.h3),
      CorpoSpacer.small(),
      CorpoText('Subtitle', variant: CorpoTextVariant.bodyMedium),
      CorpoDivider(),
      CorpoText('Content'),
    ],
  ),
)
```

### Pattern 3: Navigation Migration

**Before:**
```dart
Scaffold(
  appBar: AppBar(title: Text('My App')),
  bottomNavigationBar: BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    ],
  ),
)
```

**After:**
```dart
Scaffold(
  appBar: CorpoAppBar(title: Text('My App')),
  bottomNavigationBar: CorpoBottomNavigation(
    items: [
      CorpoBottomNavigationItem(icon: Icons.home, label: 'Home'),
      CorpoBottomNavigationItem(icon: Icons.search, label: 'Search'),
    ],
  ),
)
```

## Breaking Changes and Considerations

### API Differences

1. **Validation**: Corpo UI uses a composable validation system instead of simple validator functions
2. **Spacing**: Use `CorpoSpacer` instead of `SizedBox` for consistent spacing
3. **Typography**: Semantic variants instead of theme-based styling
4. **Colors**: Corporate color system with semantic naming

### Performance Considerations

- Corpo UI components are designed for performance with minimal rebuilds
- Built-in optimizations for large forms and lists
- Responsive utilities cache breakpoint calculations

### Accessibility Improvements

- Enhanced screen reader support
- Better keyboard navigation
- Improved focus management
- Higher contrast ratios
- Semantic markup

## Migration Checklist

- [ ] Update `pubspec.yaml` with Corpo UI dependency
- [ ] Replace theme with `CorpoTheme.light()` and `CorpoTheme.dark()`
- [ ] Migrate button components
- [ ] Update typography to use semantic variants
- [ ] Replace form components with Corpo UI equivalents
- [ ] Update validation logic to use built-in validators
- [ ] Migrate layout components (cards, dividers, spacing)
- [ ] Update navigation components
- [ ] Replace feedback components (dialogs, alerts, progress)
- [ ] Test accessibility with screen readers
- [ ] Verify responsive behavior
- [ ] Update tests to work with new components

## Troubleshooting

### Common Issues

1. **Import Errors**: Ensure you've imported `package:corpo_ui/corpo_ui.dart`
2. **Theme Issues**: Use `CorpoTheme.light()` instead of custom `ThemeData`
3. **Validation Errors**: Use `CorpoValidation` utilities instead of custom validators
4. **Spacing Issues**: Replace `SizedBox` with `CorpoSpacer` for consistency

### Getting Help

- Check the component documentation in the showcase app
- Review example applications in the `example/` directory
- Open issues on the GitHub repository for bugs or questions
- Join the community discussions for best practices

## Benefits After Migration

- **Consistency**: Unified design system across your application
- **Accessibility**: Enhanced support for assistive technologies
- **Maintainability**: Semantic components reduce code complexity
- **Performance**: Optimized components with built-in best practices
- **Responsiveness**: Built-in responsive design utilities
- **Professional Appearance**: Corporate-appropriate styling out of the box

The migration to Corpo UI provides immediate benefits in terms of visual consistency, accessibility, and maintainability while preserving the familiar Flutter development experience.

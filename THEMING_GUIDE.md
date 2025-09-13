# Corpo UI Theming and Customization Guide

This comprehensive guide covers how to customize and extend the Corpo UI design system to match your brand and specific requirements while maintaining consistency and accessibility.

## Table of Contents

1. [Theme System Overview](#theme-system-overview)
2. [Basic Theme Configuration](#basic-theme-configuration)
3. [Color System Customization](#color-system-customization)
4. [Typography Customization](#typography-customization)
5. [Component Theming](#component-theming)
6. [Creating Custom Variants](#creating-custom-variants)
7. [Responsive Customization](#responsive-customization)
8. [Dark Mode Customization](#dark-mode-customization)
9. [Brand Integration](#brand-integration)
10. [Advanced Customization](#advanced-customization)

## Theme System Overview

Corpo UI's theme system extends Material Design's theming capabilities with corporate-specific design tokens and semantic naming conventions. The system is built around:

- **Design Tokens**: Centralized values for colors, spacing, typography
- **Semantic Naming**: Business-oriented color and component naming
- **Component Theming**: Individual component customization
- **Responsive Design**: Adaptive theming based on screen size
- **Accessibility**: Built-in contrast and accessibility considerations

### Architecture

```
CorpoTheme
├── Color System (CorpoColors)
├── Typography System (CorpoTypography)
├── Spacing System (CorpoSpacing)
├── Component Themes
└── Responsive Utilities
```

## Basic Theme Configuration

### Using Default Themes

The simplest way to use Corpo UI is with the default light and dark themes:

```dart
MaterialApp(
  theme: CorpoTheme.light(),
  darkTheme: CorpoTheme.dark(),
  themeMode: ThemeMode.system,
  home: MyApp(),
)
```

### Custom Theme Creation

Create a custom theme by extending the base themes:

```dart
class MyAppTheme {
  static ThemeData light() {
    final baseTheme = CorpoTheme.light();
    
    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: MyBrandColors.primary,
        secondary: MyBrandColors.secondary,
      ),
      textTheme: baseTheme.textTheme.copyWith(
        headlineLarge: baseTheme.textTheme.headlineLarge?.copyWith(
          fontFamily: 'MyBrandFont',
        ),
      ),
    );
  }
  
  static ThemeData dark() {
    final baseTheme = CorpoTheme.dark();
    // Similar customizations for dark theme
    return baseTheme.copyWith(/* ... */);
  }
}
```

## Color System Customization

### Understanding the Color System

Corpo UI uses a semantic color system organized into categories:

```dart
// Primary Brand Colors
CorpoColors.primary50    // Lightest
CorpoColors.primary500   // Main brand color
CorpoColors.primary900   // Darkest

// Secondary Colors
CorpoColors.secondary50  // Lightest
CorpoColors.secondary500 // Main secondary
CorpoColors.secondary900 // Darkest

// Semantic Colors
CorpoColors.success      // Success states
CorpoColors.warning      // Warning states
CorpoColors.error        // Error states
CorpoColors.info         // Informational states

// Neutral Colors
CorpoColors.neutralWhite // Pure white
CorpoColors.neutral50    // Very light gray
CorpoColors.neutral900   // Very dark gray
```

### Creating Custom Color Schemes

#### Method 1: Extending CorpoColors

```dart
abstract final class MyBrandColors extends CorpoColors {
  // Override primary colors
  static const Color primary50 = Color(0xFFE3F2FD);
  static const Color primary500 = Color(0xFF1976D2);  // Your brand blue
  static const Color primary900 = Color(0xFF0D47A1);
  
  // Add custom brand colors
  static const Color brandAccent = Color(0xFFFF5722);
  static const Color brandWarning = Color(0xFFFFC107);
  
  // Override semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
}
```

#### Method 2: Creating a Color Palette Class

```dart
class BrandColorPalette {
  // Primary palette
  static const MaterialColor primary = MaterialColor(
    0xFF1976D2,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF1976D2),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
  
  // Semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
}
```

### Applying Custom Colors

```dart
class CustomCorpoTheme {
  static ThemeData lightTheme() {
    return CorpoTheme.light().copyWith(
      colorScheme: const ColorScheme.light(
        primary: BrandColorPalette.primary,
        secondary: Color(0xFF03DAC6),
        error: BrandColorPalette.error,
        surface: Color(0xFFFFFBFE),
        onSurface: Color(0xFF1C1B1F),
      ),
      // Override component colors
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: BrandColorPalette.primary,
        ),
      ),
    );
  }
}
```

## Typography Customization

### Understanding the Typography System

Corpo UI provides a semantic typography scale:

```dart
// Display styles (largest)
CorpoTypography.displayLarge
CorpoTypography.displayMedium
CorpoTypography.displaySmall

// Headline styles
CorpoTypography.headlineLarge
CorpoTypography.headlineMedium
CorpoTypography.headlineSmall

// Title styles
CorpoTypography.titleLarge
CorpoTypography.titleMedium
CorpoTypography.titleSmall

// Body styles
CorpoTypography.bodyLarge
CorpoTypography.bodyMedium
CorpoTypography.bodySmall

// Label styles (smallest)
CorpoTypography.labelLarge
CorpoTypography.labelMedium
CorpoTypography.labelSmall
```

### Custom Typography Configuration

#### Using Google Fonts

```dart
import 'package:google_fonts/google_fonts.dart';

class BrandTypography {
  static TextTheme createTextTheme() {
    final baseTheme = CorpoTypography.textTheme;
    
    return GoogleFonts.robotoTextTheme(baseTheme).copyWith(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      ),
      headlineLarge: GoogleFonts.roboto(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
      ),
    );
  }
}
```

#### Custom Font Family Configuration

```dart
class BrandTypography {
  static const String primaryFont = 'YourBrandFont';
  static const String displayFont = 'YourDisplayFont';
  
  static TextTheme get textTheme => TextTheme(
    displayLarge: TextStyle(
      fontFamily: displayFont,
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      height: 1.12,
    ),
    headlineLarge: TextStyle(
      fontFamily: primaryFont,
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.25,
    ),
    bodyLarge: TextStyle(
      fontFamily: primaryFont,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
    ),
    // ... other styles
  );
}
```

### Responsive Typography

Create typography that adapts to screen size:

```dart
class ResponsiveTypography {
  static TextStyle getHeadlineStyle(BuildContext context) {
    final screenSize = CorpoScreenSize.of(context);
    
    if (screenSize.isMobile) {
      return const TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
    } else if (screenSize.isTablet) {
      return const TextStyle(fontSize: 28, fontWeight: FontWeight.w600);
    } else {
      return const TextStyle(fontSize: 32, fontWeight: FontWeight.w600);
    }
  }
}
```

## Component Theming

### Button Theming

Customize button appearance across your app:

```dart
class CustomButtonThemes {
  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: BrandColorPalette.primary,
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  );
  
  static OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: BrandColorPalette.primary,
      side: BorderSide(color: BrandColorPalette.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
```

### Input Field Theming

```dart
class CustomInputThemes {
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: BrandColorPalette.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.red),
    ),
    labelStyle: TextStyle(
      color: Colors.grey.shade700,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    helperStyle: TextStyle(
      color: Colors.grey.shade600,
      fontSize: 14,
    ),
    contentPadding: const EdgeInsets.all(16),
  );
}
```

### Card Theming

```dart
class CustomCardTheme {
  static CardTheme cardTheme = CardTheme(
    elevation: 2,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: Colors.white,
    surfaceTintColor: BrandColorPalette.primary.withOpacity(0.05),
    margin: const EdgeInsets.all(8),
  );
}
```

## Creating Custom Variants

### Custom Button Variants

```dart
enum CustomButtonVariant {
  gradient,
  glass,
  minimal,
}

class CustomCorpoButton extends StatelessWidget {
  const CustomCorpoButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = CustomButtonVariant.gradient,
  });
  
  final VoidCallback? onPressed;
  final Widget child;
  final CustomButtonVariant variant;
  
  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case CustomButtonVariant.gradient:
        return _buildGradientButton();
      case CustomButtonVariant.glass:
        return _buildGlassButton();
      case CustomButtonVariant.minimal:
        return _buildMinimalButton();
    }
  }
  
  Widget _buildGradientButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            BrandColorPalette.primary,
            BrandColorPalette.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: child,
      ),
    );
  }
  
  // ... other button implementations
}
```

### Custom Input Components

```dart
class BrandTextField extends StatelessWidget {
  const BrandTextField({
    super.key,
    required this.label,
    this.helperText,
    this.onChanged,
    this.validator,
  });
  
  final String label;
  final String? helperText;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: BrandColorPalette.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            helperText: helperText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: BrandColorPalette.primary, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
      ],
    );
  }
}
```

## Responsive Customization

### Adaptive Theming

```dart
class ResponsiveTheme {
  static ThemeData getTheme(BuildContext context) {
    final screenSize = CorpoScreenSize.of(context);
    final baseTheme = CorpoTheme.light();
    
    if (screenSize.isMobile) {
      return baseTheme.copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: const TextStyle(fontSize: 14),
          ),
        ),
      );
    } else if (screenSize.isTablet) {
      return baseTheme.copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      );
    } else {
      return baseTheme.copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      );
    }
  }
}
```

### Responsive Component Variants

```dart
class ResponsiveCard extends StatelessWidget {
  const ResponsiveCard({
    super.key,
    required this.child,
  });
  
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return CorpoResponsiveBuilder(
      builder: (context, screenSize) {
        double padding;
        double borderRadius;
        double elevation;
        
        if (screenSize.isMobile) {
          padding = 12.0;
          borderRadius = 8.0;
          elevation = 1.0;
        } else if (screenSize.isTablet) {
          padding = 16.0;
          borderRadius = 10.0;
          elevation = 2.0;
        } else {
          padding = 20.0;
          borderRadius = 12.0;
          elevation = 3.0;
        }
        
        return Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: child,
          ),
        );
      },
    );
  }
}
```

## Dark Mode Customization

### Creating Custom Dark Themes

```dart
class BrandDarkTheme {
  static ThemeData darkTheme() {
    const darkColorScheme = ColorScheme.dark(
      primary: Color(0xFF90CAF9),      // Lighter blue for dark mode
      secondary: Color(0xFF03DAC6),
      surface: Color(0xFF121212),
      background: Color(0xFF121212),
      onSurface: Color(0xFFE1E1E1),
      onBackground: Color(0xFFE1E1E1),
    );
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      brightness: Brightness.dark,
      
      // Dark-specific component themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
        ),
      ),
      
      cardTheme: CardTheme(
        color: const Color(0xFF1E1E1E),
        elevation: 4,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkColorScheme.primary),
        ),
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
      ),
    );
  }
}
```

### Dark Mode Color Adjustments

```dart
class AdaptiveColors {
  static Color getCardColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark 
        ? const Color(0xFF1E1E1E)
        : Colors.white;
  }
  
  static Color getTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark 
        ? Colors.white 
        : Colors.black87;
  }
  
  static Color getBorderColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark 
        ? Colors.grey.shade600 
        : Colors.grey.shade300;
  }
}
```

## Brand Integration

### Complete Brand Theme Implementation

```dart
class CorporateBrandTheme {
  // Brand colors
  static const Color primaryBrand = Color(0xFF1565C0);
  static const Color secondaryBrand = Color(0xFF00ACC1);
  static const Color accentBrand = Color(0xFFFF7043);
  
  // Brand fonts
  static const String primaryFont = 'Roboto';
  static const String headingFont = 'Roboto Slab';
  
  static ThemeData getLightTheme() {
    const colorScheme = ColorScheme.light(
      primary: primaryBrand,
      secondary: secondaryBrand,
      tertiary: accentBrand,
      surface: Color(0xFFFFFBFE),
      background: Color(0xFFFFFBFE),
    );
    
    final textTheme = GoogleFonts.robotoTextTheme().copyWith(
      displayLarge: GoogleFonts.robotoSlab(
        fontSize: 57,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: GoogleFonts.robotoSlab(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      
      // Component themes
      appBarTheme: AppBarTheme(
        backgroundColor: primaryBrand,
        foregroundColor: Colors.white,
        elevation: 2,
        titleTextStyle: GoogleFonts.robotoSlab(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBrand,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      cardTheme: CardTheme(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        shadowColor: primaryBrand.withOpacity(0.1),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryBrand, width: 2),
        ),
        labelStyle: GoogleFonts.roboto(
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
  
  static ThemeData getDarkTheme() {
    // Similar implementation for dark theme
    // with adjusted colors for dark mode
  }
}
```

## Advanced Customization

### Creating a Theme Builder

```dart
class ThemeBuilder {
  final Color primaryColor;
  final Color secondaryColor;
  final String fontFamily;
  final bool useMaterial3;
  
  const ThemeBuilder({
    required this.primaryColor,
    required this.secondaryColor,
    required this.fontFamily,
    this.useMaterial3 = true,
  });
  
  ThemeData buildLightTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      secondary: secondaryColor,
    );
    
    return ThemeData(
      useMaterial3: useMaterial3,
      colorScheme: colorScheme,
      fontFamily: fontFamily,
      
      // Build component themes based on colors
      elevatedButtonTheme: _buildButtonTheme(colorScheme),
      inputDecorationTheme: _buildInputTheme(colorScheme),
      cardTheme: _buildCardTheme(colorScheme),
    );
  }
  
  ElevatedButtonThemeData _buildButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
  
  InputDecorationTheme _buildInputTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
    );
  }
  
  CardTheme _buildCardTheme(ColorScheme colorScheme) {
    return CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: colorScheme.surface,
    );
  }
}
```

### Runtime Theme Switching

```dart
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  String _selectedBrand = 'default';
  
  ThemeMode get themeMode => _themeMode;
  String get selectedBrand => _selectedBrand;
  
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
  
  void setBrand(String brand) {
    _selectedBrand = brand;
    notifyListeners();
  }
  
  ThemeData getLightTheme() {
    switch (_selectedBrand) {
      case 'corporate':
        return CorporateBrandTheme.getLightTheme();
      case 'tech':
        return TechBrandTheme.getLightTheme();
      default:
        return CorpoTheme.light();
    }
  }
  
  ThemeData getDarkTheme() {
    switch (_selectedBrand) {
      case 'corporate':
        return CorporateBrandTheme.getDarkTheme();
      case 'tech':
        return TechBrandTheme.getDarkTheme();
      default:
        return CorpoTheme.dark();
    }
  }
}
```

## Best Practices

### 1. Consistency
- Use semantic naming for colors and components
- Maintain consistent spacing and typography scales
- Follow accessibility guidelines for contrast ratios

### 2. Performance
- Avoid creating themes in build methods
- Cache theme instances when possible
- Use const constructors for theme data

### 3. Maintainability
- Organize theme code in separate files
- Use design tokens for centralized values
- Document custom theme decisions

### 4. Testing
- Test themes in both light and dark modes
- Verify accessibility compliance
- Test on different screen sizes

## Troubleshooting

### Common Issues

1. **Colors not applying**: Ensure you're using the correct ColorScheme properties
2. **Fonts not loading**: Verify font assets are included in pubspec.yaml
3. **Theme not updating**: Check that you're rebuilding widgets after theme changes
4. **Accessibility issues**: Use tools like Flutter Inspector to verify contrast ratios

### Debugging Tips

```dart
// Debug current theme values
void debugTheme(BuildContext context) {
  final theme = Theme.of(context);
  print('Primary color: ${theme.colorScheme.primary}');
  print('Text theme: ${theme.textTheme}');
  print('Button theme: ${theme.elevatedButtonTheme}');
}
```

This comprehensive theming guide provides the foundation for creating beautiful, consistent, and accessible corporate applications with Corpo UI while maintaining the flexibility to adapt to your specific brand requirements.

# Corpo UI - The ShadCN of Flutter 🎨

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Pub Version](https://img.shields.io/pub/v/corpo_ui?style=flat)](https://pub.dev/packages/corpo_ui)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

**¡Por fin! El poder de ShadCN UI, pero para Flutter.** 

Corpo UI es el primer paquete de Flutter que implementa la filosofía revolucionaria de ShadCN: **cambia un archivo, transforma toda tu app**. Ya no más hardcodear colores en 50 lugares diferentes. Ya no más inconsistencias. Una sola línea de código cambia todo tu diseño.

> **"¿Recuerdas la primera vez que usaste ShadCN en React? Esa misma sensación, pero en Flutter."**

## 🚀 La Magia de ShadCN en Flutter

```dart
// ¿Quieres cambiar TODA tu app a tema púrpura?
CorpoDesignTokens.configure(primaryColor: Colors.purple);

// ¿Prefieres bordes más redondeados en TODOS los componentes?
CorpoDesignTokens.configure(borderRadius: 16.0);

// ¿Cambiar la fuente de TODA la aplicación?
CorpoDesignTokens.configure(fontFamily: 'Poppins');
```

**¡Y TODOS los componentes se actualizan automáticamente!** Botones, cards, inputs, modales... todo.

## ⚡ Quick Start - 30 segundos para el wow factor

1. **Instala:**
```bash
flutter pub add corpo_ui
```

2. **Importa y configura:**
```dart
import 'package:corpo_ui/corpo_ui.dart';

void main() {
  // 🎨 Elige tu tema (o crea uno personalizado)
  CorpoDesignTokens.applyModernTheme(); // Púrpura elegante
  // CorpoDesignTokens.applyFriendlyTheme(); // Naranja amigable  
  // CorpoDesignTokens.applyMinimalTheme(); // Minimalista B&W
  
  runApp(MyApp());
}
```

3. **Usa los componentes:**
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            CorpoButton(
              onPressed: () {},
              child: Text('Este botón usa el tema automáticamente'),
            ),
            CorpoCard(
              child: CorpoText('Esta card también se adapta'),
            ),
          ],
        ),
      ),
    );
  }
}
```

**¡Ya está!** Tu app tiene un diseño consistente y profesional.

## 🎨 Temas Pre-configurados

```dart
// Corporativo profesional (azul)
CorpoDesignTokens.applyCorporateTheme();

// Moderno y elegante (púrpura)  
CorpoDesignTokens.applyModernTheme();

// Amigable y cálido (naranja)
CorpoDesignTokens.applyFriendlyTheme();

// Minimalista limpio (B&W)
CorpoDesignTokens.applyMinimalTheme();
```

## 🛠️ Personalización Total

¿Quieres algo único? Personaliza todo:

```dart
CorpoDesignTokens.configure(
  // Colores
  primaryColor: Color(0xFF6366F1),
  secondaryColor: Color(0xFF8B5CF6),
  successColor: Color(0xFF10B981),
  
  // Espaciado
  baseSpacing: 6.0, // Más generoso
  
  // Tipografía  
  fontFamily: 'SF Pro Display',
  baseFontSize: 16.0,
  
  // Bordes
  borderRadius: 12.0,
  borderRadiusLarge: 20.0,
);
```

## 🏗️ Componentes Disponibles

### ✅ Ya Disponibles:
- **Botones**: Primary, Secondary, Ghost, Icon buttons
- **Layout**: Cards, Surfaces, Dividers, Spacers  
- **Inputs**: Text fields, Checkboxes, Radio, Switches
- **Typography**: Headings, Text, Labels, Code blocks
- **Navigation**: App bars, Bottom nav, Breadcrumbs, Tabs
- **Feedback**: Alerts, Dialogs, Skeletons, Snackbars
- **Progress**: Progress bars, Spinners
- **Media**: Avatars, Images, Icons, Badges

### 🚧 En Desarrollo:
- **Forms**: Validación avanzada, Date/Time pickers
- **Data**: Tables, Lists, Timeline
- **Overlays**: Modals, Popovers, Tooltips

## 🎯 ¿Por qué Corpo UI?

### El Problema Tradicional:
```dart
// 😤 Código tradicional: colores hardcodeados por todos lados
Container(color: Color(0xFF3182CE))
ElevatedButton(style: ButtonStyle(backgroundColor: Color(0xFF3182CE)))
Card(color: Color(0xFFFFFFFF))
Text(style: TextStyle(color: Color(0xFF1A202C)))

// ¿Quieres cambiar el color primario? ¡A buscar y reemplazar en 50 archivos!
```

### La Solución Corpo UI:
```dart
// 😍 Con Corpo UI: un solo lugar controla todo
CorpoDesignTokens.configure(primaryColor: Colors.teal);

// Todos estos componentes se actualizan automáticamente:
CorpoButton() // ✅ Usa el teal automáticamente
CorpoCard()   // ✅ Bordes y colores consistentes  
CorpoText()   // ✅ Tipografía unificada
```

## 📚 Ejemplos Completos

### Cambio de Tema en Tiempo Real:
```dart
class ThemeSwitcher extends StatefulWidget {
  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            CorpoDesignTokens.applyModernTheme();
            setState(() {}); // ¡Toda la app cambia!
          },
          child: Text('Tema Moderno'),
        ),
        ElevatedButton(
          onPressed: () {
            CorpoDesignTokens.applyFriendlyTheme();
            setState(() {}); // ¡Otra vez magia!
          },
          child: Text('Tema Amigable'),
        ),
        // Los componentes de abajo se actualizan automáticamente
        CorpoButton(child: Text('Botón que se adapta')),
        CorpoCard(child: Text('Card que se adapta')),
      ],
    );
  }
}
```

### Dashboard Corporativo:
```dart
void main() {
  CorpoDesignTokens.applyCorporateTheme();
  runApp(CorporateDashboard());
}

class CorporateDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CorpoAppBar(title: 'Dashboard'),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CorpoCard(
                    child: Column(
                      children: [
                        CorpoText('Ventas', variant: CorpoTextVariant.heading),
                        CorpoText('$124,532', variant: CorpoTextVariant.display),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CorpoCard(
                    child: Column(
                      children: [
                        CorpoText('Usuarios', variant: CorpoTextVariant.heading),
                        CorpoText('2,847', variant: CorpoTextVariant.display),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            CorpoButton(
              onPressed: () {},
              child: Text('Generar Reporte'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎨 Inspiración y Filosofía

Corpo UI está **profundamente inspirado por [ShadCN UI](https://ui.shadcn.com/)**, el revolucionario sistema de diseño que transformó el desarrollo web con React. Hemos traído esa misma filosofía a Flutter:

- **Un archivo controla todo**: Como las CSS variables de ShadCN
- **Componentes que se adaptan**: Sin configuración manual
- **Temas intercambiables**: Cambia toda la app en una línea
- **Personalización extrema**: Para que sea TU diseño, no el nuestro

### Lo que aprendimos de ShadCN:

1. **Configuración > Convención**: Flexibilidad total sobre decisiones arbitrarias
2. **Design Tokens**: Un sistema centralizado que se propaga a todo
3. **Developer Experience**: Hacer que lo complejo sea simple
4. **Consistencia Automática**: Los componentes simplemente funcionan juntos

## 🔥 Casos de Uso Perfectos

### 🏢 Apps Corporativas
```dart
CorpoDesignTokens.applyCorporateTheme();
// Obtienes: Azul profesional, tipografía legible, espaciado conservador
```

### 🎨 Apps Creativas  
```dart
CorpoDesignTokens.configure(
  primaryColor: Colors.deepPurple,
  borderRadius: 20.0,
  fontFamily: 'Montserrat',
);
// Obtienes: Diseño moderno y creativo
```

### 🏥 Apps Médicas
```dart
CorpoDesignTokens.configure(
  primaryColor: Colors.teal,
  successColor: Colors.green.shade600,
  errorColor: Colors.red.shade600,
  baseSpacing: 8.0, // Más espacioso para accesibilidad
);
// Obtienes: Colores médicos tradicionales, accesible
```

### 🎮 Apps Gaming
```dart
CorpoDesignTokens.configure(
  primaryColor: Colors.orange,
  borderRadius: 0, // Sin bordes redondeados
  fontFamily: 'Orbitron',
);
// Obtienes: Look gaming con tipografía futurista
```

# Specifications

- **Language**: Dart
- **Framework**: Flutter
- **License**: MIT
- **Version**: 1.0.0
- **Dependencies**: None (pure Dart/Flutter package)
- **Platform Support**: iOS, Android, Web, Desktop
- **Documentation**: Comprehensive documentation available on [GitHub](https://github.com/sazardev/corpo_ui)
- **Community**: Open-source with contributions welcome on GitHub
- **Testing**: Unit tests and widget tests included
- **CI/CD**: Continuous integration set up with GitHub Actions  
- **Code Quality**: Follows Dart and Flutter best practices and style guidelines
- **Internationalization**: Supports multiple languages and locales
- **Accessibility**: Designed with accessibility in mind, following WCAG guidelines
- **Performance**: Optimized for performance with minimal overhead
- **Customization**: Highly customizable components and themes
- **Versioning**: Semantic versioning for easy tracking of changes and updates
- **Examples**: Sample applications and code snippets provided for quick start
- **Support**: Active community support through GitHub issues and discussions
- **Integration**: Easy to integrate with existing Flutter projects
- **Updates**: Regular updates and improvements based on user feedback
- **Design Principles**: Follows modern design principles and trends
- **Component Library**: Extensive library of UI components including buttons, cards, modals, forms, and more
- **Theming**: Built-in support for light and dark themes, with easy customization options
- **Animations**: Smooth animations and transitions for enhanced user experience
- **State Management**: Compatible with popular state management solutions in Flutter
- **Documentation Generation**: Uses Dartdoc for generating API documentation
- **Code Coverage**: Maintains high code coverage with automated testing

# Features

Corpo UI offers a variety of features to help you build a solid design system:

- A wide range of pre-designed UI components such as buttons, cards, modals, and more.
- Customizable themes to match your brand's identity.
- Responsive design principles to ensure your app looks great on all devices.
- Easy integration with existing Flutter projects.
- Comprehensive documentation and examples to get you started quickly.
- Regular updates and improvements based on community feedback.
- Open-source and community-driven development.
- Accessibility features to ensure your app is usable by everyone.
- Well-structured and maintainable codebase for easy customization and extension.
- Support for dark mode and light mode themes.
- Built-in animations and transitions for a polished user experience.
- Integration with popular state management solutions in Flutter.
- Performance optimizations to ensure smooth and responsive UI interactions.
- Cross-platform compatibility for building apps on iOS, Android, and web.
- A growing library of components and utilities to meet diverse design needs.

# Getting Started

To get started with Corpo UI, follow these steps:
1. Add the dependency to your `pubspec.yaml` file:

```yamldependencies:
  corpo_ui: ^1.0.0
```

or run the following command in your terminal:

```bash
flutter pub add corpo_ui
```
2. Import the package in your Dart file:

```dart
import 'package:corpo_ui/corpo_ui.dart';
```
3. Use the provided components and themes in your Flutter application. For example, to use a button from Corpo UI:

```dart
import 'package:flutter/material.dart';
import 'package:corpo_ui/corpo_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corpo UI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Corpo UI Demo'),
        ),
        body: Center(
          child: CorpoButton(
            onPressed: () {
              // Handle button press
            },
            child: Text('Press Me'),
          ),
        ),
      ),
    );
  }
}
```

4. Explore the documentation and examples on the [GitHub repository](https://github.com/sazardev/corpo_ui).
5. Customize the components and themes as needed to fit your design requirements.
6. Run your Flutter application to see Corpo UI in action!
7. For more advanced usage and customization options, refer to the detailed documentation provided in the repository.
8. If you encounter any issues or have questions, feel free to open an issue on the GitHub repository or join the community discussions.
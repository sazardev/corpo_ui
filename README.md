# Corpo UI - The foundation for your design system

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Pub Version](https://img.shields.io/pub/v/corpo_ui?style=flat)](https://pub.dev/packages/corpo_ui)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)


Corpo UI is a comprehensive Flutter package that provides a robust foundation for building design systems. It offers a wide range of customizable UI components, themes, and utilities to help developers create consistent and visually appealing applications with ease. Whether you're starting a new project or enhancing an existing one, Corpo UI simplifies the process of implementing design principles and ensures a cohesive user experience across your app.

> Corpo UI is inspired by the design principles of corporate applications, focusing on clarity, usability, and professionalism.

> It is designed to be flexible and adaptable, allowing developers to tailor the components to fit their specific design needs.

> With Corpo UI, you can accelerate your development process and maintain a high standard of design quality in your Flutter applications.

> Also, this package is open-source and welcomes contributions from the community to help improve and expand its offerings.

> Corpo UI is highly inspired by [Shadcn UI](https://ui.shadcn.com/).

## Motivation

Building a design system from scratch can be time-consuming and challenging. Corpo UI aims to alleviate these challenges by providing a ready-to-use set of components and design guidelines that adhere to best practices in UI/UX design. This allows developers to focus on building features and functionality rather than worrying about the intricacies of design implementation.

# The problem

Creating a consistent and visually appealing design system can be a daunting task for developers, especially when starting from scratch. It often involves significant time and effort to design, implement, and maintain UI components that adhere to best practices in design principles. This can lead to inconsistencies in the user interface, increased development time, and challenges in scaling the application as new features are added.

# The solution

Corpo UI addresses these challenges by providing a comprehensive Flutter package that offers a wide range of pre-designed and customizable UI components, themes, and utilities. By leveraging Corpo UI, developers can quickly implement a cohesive design system that ensures consistency across their applications. The package is designed to be flexible and adaptable, allowing developers to tailor the components to fit their specific design needs. This not only accelerates the development process but also helps maintain a high standard of design quality in Flutter applications.

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
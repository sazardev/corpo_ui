# Corpo UI Design System Changelog

## 0.2.1

* Optimize animated components for performance
  - Introduced `RepaintBoundary` in `CorpoSkeleton` and `CorpoImage` to isolate repaints
  - Delayed animation starts using `WidgetsBinding.instance.addPostFrameCallback` to improve initial load performance
  - Reduced number of simultaneous animations in example app (from 3 to 1 spinner)

## 0.2.0

* Introduce Design Tokens as single source of truth for styling

## 0.1.2

* Fix pub.dev score issues for better package quality
* Add comprehensive example application with working demonstrations
* Fix deprecated Color API usage (red, green, blue, alpha properties)
* Improve package structure for pub.dev validation
* Address static analysis issues to achieve higher pub points

## 0.1.1

Refactor widget build methods for consistency and readability

- Simplified build methods in FormApplicationExample and ResponsiveDesignShowcase classes to use arrow syntax.
- Updated padding values from 16.0 to 16 for consistency.
- Changed anonymous function parameters to explicit types for clarity.
- Replaced list initializations with type-specific lists for better type safety.
- Improved code readability by using const constructors where applicable.

## 0.1.0

* Initial release of Corpo UI design system
* Complete Phase 6: Developer Experience implementation
* Comprehensive component library with:
  - Typography (headings, text, labels, code)
  - Buttons (primary, outlined, text, icon buttons)
  - Layout components (cards, surfaces, dividers, spacers)
  - Input components (text fields, checkboxes, radio buttons, switches)
  - Form components (dropdowns, date/time pickers, sliders, validation)
  - Navigation components (app bar, bottom navigation, breadcrumbs, tabs, drawer)
  - Feedback components (alerts, dialogs, skeletons, snackbars)
  - Data display (data tables, list tiles, expansion panels, timeline, stepper)
  - Media components (responsive images, avatars)
  - Overlay components (modals, popovers, sheets, tooltips)
  - Progress indicators (progress bars, spinners)
  - Badge and icon components
* Complete theme system with light/dark mode support
* Responsive design utilities and breakpoint system
* Accessibility features and WCAG compliance tools
* Animation and transition components
* Comprehensive documentation and API references
* Example applications demonstrating real-world usage
* Migration guide from Material Design components
* Theming and customization guide
* Extensive test coverage with unit and integration tests

## 0.0.1

* Initial project setup and package structure

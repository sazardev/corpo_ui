# CORPO UI - COMPLETE SHADCN MIGRATION ROADMAP

## 🎯 MISSION: Total Migration to Design Tokens
Transform Corpo UI into a true ShadCN-style system where `lib/src/design_tokens.dart` controls ALL styling. **Zero hardcoded values.**

## 🎉 CURRENT PROGRESS SUMMARY

**🚀 MASSIVE ACHIEVEMENT: Priority 1, 2, 3, 4, 5 & 6 Complete!**

✅ **Typography Components**: 4/4 COMPLETED (100%)
✅ **Input Components**: 4/4 COMPLETED (100%) - All components including complex text field!
✅ **Layout Components**: 3/3 COMPLETED (100%) - All structural elements done
✅ **Button Components**: 5/5 COMPLETED (100%) - All button variants fully migrated!
✅ **Form Components**: 8/8 COMPLETED (100%) - ALL form controls migrated! 🎉
✅ **Navigation Components**: 5/5 COMPLETED (100%) - ALL navigation components migrated! 🎉
✅ **Progress Components**: 2/2 COMPLETED (100%) - ALL progress indicators migrated! 🎉
✅ **Feedback Components**: 4/4 COMPLETED (100%) - ALL feedback components migrated! 🎉

**🎉 INCREDIBLE MILESTONE: 35/98 critical components fully migrated!**

**Total Progress: 35/98 components migrated (35.7%)**

### 🎯 Next Steps:
1. ✅ ALL Priority 1, 2, 3, 4, 5 & 6 Components - **COMPLETED!**
2. Move to Overlay Components (Priority 7) - Ready for next priority level!
3. Continue with Avatar/Badge, Data, and Media components - Over 35% complete!

## 🚨 MIGRATION STATUS OVERVIEW

### ✅ COMPLETED (29/98 components)
- `lib/src/components/buttons/corpo_button.dart` - **REFERENCE IMPLEMENTATION**
- `lib/src/components/buttons/button_style.dart` - **FULLY MIGRATED** - Color manipulation helpers
- `lib/src/components/buttons/corpo_icon_button.dart` - **FULLY MIGRATED** - Dynamic sizing
- `lib/src/components/buttons/corpo_outlined_button.dart` - **FULLY MIGRATED** - Border integration  
- `lib/src/components/buttons/corpo_text_button.dart` - **FULLY MIGRATED** - Text styling
- `lib/src/components/typography/corpo_text.dart` - **FULLY MIGRATED** - Text variants
- `lib/src/components/typography/corpo_heading.dart` - **FULLY MIGRATED** - Heading system  
- `lib/src/components/typography/corpo_label.dart` - **FULLY MIGRATED** - Label variants
- `lib/src/components/typography/corpo_code.dart` - **FULLY MIGRATED** - Code display
- `lib/src/components/inputs/corpo_text_field.dart` - **FULLY MIGRATED** - Complex input system
- `lib/src/components/inputs/corpo_checkbox.dart` - **FULLY MIGRATED** - Checkbox with states
- `lib/src/components/inputs/corpo_radio.dart` - **FULLY MIGRATED** - Radio button system
- `lib/src/components/inputs/corpo_switch.dart` - **FULLY MIGRATED** - Toggle switches
- `lib/src/components/layout/corpo_card.dart` - **FULLY MIGRATED** - Card containers  
- `lib/src/components/layout/corpo_surface.dart` - **FULLY MIGRATED** - Surface foundation
- `lib/src/components/layout/corpo_spacer.dart` - **FULLY MIGRATED** - Spacing system
- `lib/src/components/layout/corpo_divider.dart` - **FULLY MIGRATED** - Visual separators
- `lib/src/components/forms/corpo_form.dart` - **FULLY MIGRATED** - Form containers
- `lib/src/components/forms/corpo_dropdown.dart` - **FULLY MIGRATED** - Selection controls
- `lib/src/components/forms/corpo_search_field.dart` - **FULLY MIGRATED** - Search inputs
- `lib/src/components/forms/corpo_slider.dart` - **FULLY MIGRATED** - Range controls
- `lib/src/components/forms/corpo_date_picker.dart` - **FULLY MIGRATED** - Date selection
- `lib/src/components/forms/corpo_time_picker.dart` - **FULLY MIGRATED** - Time selection
- `lib/src/components/forms/corpo_form_field.dart` - **FULLY MIGRATED** - Form field wrapper
- `lib/src/components/forms/validation.dart` - **FULLY MIGRATED** - Validation utilities
- `lib/src/components/navigation/corpo_app_bar.dart` - **FULLY MIGRATED** - App bar with tokens
- `lib/src/components/navigation/corpo_tabs.dart` - **FULLY MIGRATED** - All tab styles
- `lib/src/components/navigation/corpo_breadcrumb.dart` - **FULLY MIGRATED** - Breadcrumb navigation
- `lib/src/components/navigation/corpo_bottom_navigation.dart` - **FULLY MIGRATED** - Bottom navigation
- `lib/src/components/navigation/corpo_drawer.dart` - **FULLY MIGRATED** - Navigation drawer
- `lib/src/components/forms/corpo_form_field.dart` - **FULLY MIGRATED** - Field wrappers

### ⚠️ PARTIALLY MIGRATED (1/98 components)  
- `lib/src/components/layout/corpo_card.dart` - Uses tokens for spacing/border, needs color migration

### ❌ CRITICAL MIGRATIONS NEEDED (86/98 components)
[Rest of remaining components...]

## 📋 COMPLETE COMPONENT MIGRATION CHECKLIST

### 🏷️ TYPOGRAPHY COMPONENTS (PRIORITY 1 - CRITICAL) ✅ COMPLETED
These are used everywhere and block other migrations:

- [x] `lib/src/components/typography/corpo_text.dart` ✅ **MIGRATED**
  - ~~**Issues**: Uses `CorpoColors.primary500` in docs, needs token integration~~
  - **Status**: Uses `CorpoDesignTokens()` for all styling
  
- [x] `lib/src/components/typography/corpo_heading.dart` ✅ **MIGRATED**
  - ~~**Issues**: Likely uses `CorpoTypography.*` constants~~
  - **Status**: Uses `tokens.fontSizeXLarge/fontSizeLarge/baseFontSize`
  
- [x] `lib/src/components/typography/corpo_label.dart` ✅ **MIGRATED**
  - ~~**Issues**: Label styling with old constants~~
  - **Status**: Token-based font sizes and colors implemented
  
- [x] `lib/src/components/typography/corpo_code.dart` ✅ **MIGRATED**
  - ~~**Issues**: Code block styling~~
  - **Status**: Typography tokens and background colors implemented

### 🖲️ INPUT COMPONENTS (PRIORITY 1 - CRITICAL) ✅ COMPLETED
Essential for forms and user interaction:

- [x] `lib/src/components/inputs/corpo_text_field.dart` ✅ **MIGRATED**
  - ~~**Issues**: Border colors, padding, focus states - COMPLEX COMPONENT~~
  - **Status**: Full migration completed - all method signatures updated to use design tokens
  
- [x] `lib/src/components/inputs/corpo_checkbox.dart` ✅ **MIGRATED**
  - ~~**Issues**: Heavy use of `CorpoColors.primary500/neutral*` (lines 238-260)~~
  - **Status**: All color logic converted to token system
  
- [x] `lib/src/components/inputs/corpo_radio.dart` ✅ **MIGRATED**
  - ~~**Issues**: Similar color patterns to checkbox~~
  - **Status**: Token-based colors and spacing implemented
  
- [x] `lib/src/components/inputs/corpo_switch.dart` ✅ **MIGRATED**
  - ~~**Issues**: Colors and interaction states~~
  - **Status**: Token system integration complete

### 🔘 BUTTON COMPONENTS (PRIORITY 2) ✅ COMPLETED
Core interaction elements:

- [x] `lib/src/components/buttons/button_style.dart` ✅ **MIGRATED**
  - ~~**Issues**: Heavy hardcoded colors (lines 114, 170, 225, 307)~~
  - **Status**: All ButtonStyle definitions converted to design tokens with helper methods for color manipulation
  
- [x] `lib/src/components/buttons/corpo_icon_button.dart` ✅ **MIGRATED**
  - ~~**Issues**: Icon sizing and colors~~
  - **Status**: Token-based sizing and colors implemented with dynamic sizing calculations
  
- [x] `lib/src/components/buttons/corpo_outlined_button.dart` ✅ **MIGRATED**
  - ~~**Issues**: Border colors and styles~~
  - **Status**: Border colors, padding, and text styles converted to token system
  
- [x] `lib/src/components/buttons/corpo_text_button.dart` ✅ **MIGRATED**
  - ~~**Issues**: Text colors and hover states~~
  - **Status**: Text colors and all styling properties integrated with design tokens

### 🏗️ LAYOUT COMPONENTS (PRIORITY 2) ✅ COMPLETED
Structural elements:

- [x] `lib/src/components/layout/corpo_surface.dart` ✅ **MIGRATED**
  - ~~**Issues**: Background colors and elevation~~
  - **Status**: Surface colors from tokens implemented
  
- [x] `lib/src/components/layout/corpo_divider.dart` ✅ **MIGRATED**
  - ~~**Issues**: Border colors and thickness~~
  - **Status**: Token-based colors, spacing, and typography implemented
  
- [x] `lib/src/components/layout/corpo_spacer.dart` ✅ **MIGRATED**
  - ~~**Issues**: Spacing constants~~
  - **Status**: Complete spacing token system integration

### 📝 FORM COMPONENTS (PRIORITY 3) - 100% COMPLETE! 🎉✨
Complex form controls - **8/8 components migrated:**

- [x] `lib/src/components/forms/corpo_form.dart` - **FULLY MIGRATED**
  - **Status**: Complete background colors and spacing token integration
  - **Migration**: `CorpoSpacing.medium` → `tokens.spacing4x` ✅
  
- [x] `lib/src/components/forms/corpo_dropdown.dart` - **FULLY MIGRATED**
  - **Status**: Complete token integration for borders, colors, spacing
  - **Migration**: Comprehensive styling system with design tokens ✅
  
- [x] `lib/src/components/forms/corpo_search_field.dart` - **FULLY MIGRATED**
  - **Status**: Complete input styling and icons token integration
  - **Migration**: Clean token system implementation ✅
  
- [x] `lib/src/components/forms/corpo_slider.dart` - **FULLY MIGRATED**
  - **Status**: Complex color system fully converted (lines 141-260)
  - **Migration**: All `CorpoColors.*` and `CorpoSpacing.*` converted to tokens ✅
  
- [x] `lib/src/components/forms/corpo_date_picker.dart` - **FULLY MIGRATED**
  - **Status**: Complete spacing and color token integration
  - **Migration**: Theme picker integration with design tokens ✅
  
- [x] `lib/src/components/forms/corpo_time_picker.dart` - **FULLY MIGRATED**
  - **Status**: Complete time picker styling with token system
  - **Migration**: Range support and theme integration ✅
  
- [x] `lib/src/components/forms/corpo_form_field.dart` - **FULLY MIGRATED**
  - **Status**: Complete form field wrapper with token integration
  - **Migration**: Label and error styling with design tokens ✅
  
- [x] `lib/src/components/forms/validation.dart` - **FULLY MIGRATED**
  - **Status**: Validation logic utility (no visual changes needed)
  - **Migration**: Pure functional utility - no styling constants ✅

### 🧭 NAVIGATION COMPONENTS (PRIORITY 4) - ✅ **COMPLETED**
Navigation and wayfinding:

- [x] `lib/src/components/navigation/corpo_app_bar.dart` - **FULLY MIGRATED**
  - **Status**: Complete app bar with token integration
  - **Migration**: Background colors, typography, and helper methods ✅
  
- [x] `lib/src/components/navigation/corpo_tabs.dart` - **FULLY MIGRATED**
  - **Status**: All tab styles (underlined, filled, outlined) migrated
  - **Migration**: All `CorpoColors.*`, `CorpoSpacing.*`, `CorpoTypography.*` to tokens ✅
  
- [x] `lib/src/components/navigation/corpo_breadcrumb.dart` - **FULLY MIGRATED**
  - **Status**: Complete breadcrumb with token integration
  - **Migration**: Color, spacing, and typography patterns fully migrated ✅
  
- [x] `lib/src/components/navigation/corpo_bottom_navigation.dart` - **FULLY MIGRATED**
  - **Status**: Bottom navigation with badge support migrated
  - **Migration**: Colors, layout, and typography with tokens ✅
  
- [x] `lib/src/components/navigation/corpo_drawer.dart` - **FULLY MIGRATED**
  - **Status**: Drawer, header, items, sections, and dividers migrated
  - **Migration**: Complete token integration across all components ✅

### 🔄 PROGRESS COMPONENTS (PRIORITY 5) - ✅ **COMPLETED**
Loading and progress indicators:

- [x] `lib/src/components/progress/corpo_progress_bar.dart` - **FULLY MIGRATED**
  - **Status**: Complete progress bar with linear and stepped styles
  - **Migration**: All `CorpoColors.*`, `CorpoSpacing.*`, `CorpoTypography.*` to tokens ✅
  
- [x] `lib/src/components/progress/corpo_spinner.dart` - **FULLY MIGRATED**
  - **Status**: All spinner styles (circular, dots, linear) with sizing methods
  - **Migration**: Complete token integration across all sizing and color methods ✅

### 💬 FEEDBACK COMPONENTS (PRIORITY 6) - ✅ **COMPLETED**
User feedback and alerts:

- [x] `lib/src/components/feedback/corpo_alert.dart` - **FULLY MIGRATED**
  - **Status**: Complete semantic color system with token integration
  - **Migration**: All `CorpoColors.*`, `CorpoSpacing.*`, `CorpoTypography.*` to tokens ✅
  
- [x] `lib/src/components/feedback/corpo_dialog.dart` - **FULLY MIGRATED**
  - **Status**: Complete modal dialog with token-based styling
  - **Migration**: Background colors, borders, spacing, and typography with tokens ✅
  
- [x] `lib/src/components/feedback/corpo_snackbar.dart` - **FULLY MIGRATED**
  - **Status**: Toast notifications with complete color and positioning system
  - **Migration**: All semantic colors, spacing, and animation systems migrated ✅
  
- [x] `lib/src/components/feedback/corpo_skeleton.dart` - **FULLY MIGRATED**
  - **Status**: Loading placeholders with token-based animation colors
  - **Migration**: Animation colors, spacing, and border radius with tokens ✅

### 🎯 OVERLAY COMPONENTS (PRIORITY 4)
Modal and overlay elements:

- [ ] `lib/src/components/overlay/corpo_modal.dart`
  - **Issues**: Background and border colors
  - **Migration**: Token system
  
- [ ] `lib/src/components/overlay/corpo_sheet.dart`
  - **Issues**: Border radius and spacing (line 289+)
  - **Migration**: Token integration
  
- [ ] `lib/src/components/overlay/corpo_tooltip.dart`
  - **Issues**: Background and text colors
  - **Migration**: Token system
  
- [ ] `lib/src/components/overlay/corpo_popover.dart`
  - **Issues**: Similar to tooltip
  - **Migration**: Token integration

### 👤 AVATAR & BADGE COMPONENTS (PRIORITY 4)
User representation:

- [ ] `lib/src/components/avatars/corpo_avatar.dart`
  - **Issues**: Colors and sizing (lines 277-399)
  - **Migration**: All `CorpoColors.*` to tokens
  
- [ ] `lib/src/components/badges/corpo_badge.dart`
  - **Issues**: Background colors and typography
  - **Migration**: Token system

### 📊 DATA COMPONENTS (PRIORITY 5)
Data display and organization:

- [ ] `lib/src/components/data/corpo_data_table.dart`
  - **Issues**: Border and header colors
  - **Migration**: Token system
  
- [ ] `lib/src/components/data/corpo_list_tile.dart`
  - **Issues**: Colors and spacing
  - **Migration**: Token integration
  
- [ ] `lib/src/components/data/corpo_expansion_panel.dart`
  - **Issues**: Border radius and colors (line 239+)
  - **Migration**: Token system
  
- [ ] `lib/src/components/data/corpo_timeline.dart`
  - **Issues**: Line colors and spacing
  - **Migration**: Token integration
  
- [ ] `lib/src/components/data/corpo_stepper.dart`
  - **Issues**: Colors and connector styling
  - **Migration**: Token system

### 🖼️ MEDIA & ICON COMPONENTS (PRIORITY 5)
Media and visual elements:

- [ ] `lib/src/components/media/corpo_image.dart`
  - **Issues**: Border radius and placeholders
  - **Migration**: Token system
  
- [ ] `lib/src/components/icons/corpo_icon.dart`
  - **Issues**: Color and sizing
  - **Migration**: Token integration

## 🗂️ LEGACY SYSTEM REMOVAL (AFTER MIGRATION)

### Files to DEPRECATE after migration:
- [ ] `lib/src/constants/colors.dart` - Replace with `CorpoDesignTokens`
- [ ] `lib/src/constants/spacing.dart` - Replace with token spacing
- [ ] `lib/src/constants/typography.dart` - Replace with token typography

### Export Cleanup in `lib/corpo_ui.dart`:
- [ ] Remove exports for deprecated constants
- [ ] Keep only `export 'src/design_tokens.dart';`

## 🎯 MIGRATION SUCCESS CRITERIA

### Component Level:
- [ ] Zero `CorpoColors.*` references
- [ ] Zero `CorpoSpacing.*` references  
- [ ] Zero `CorpoTypography.*` references
- [ ] Zero hardcoded `Color(0x...)` values
- [ ] Zero hardcoded `EdgeInsets.*` values
- [ ] Zero hardcoded `BorderRadius.circular(...)` values
- [ ] All styling reads from `CorpoDesignTokens()` instance

### System Level:
- [ ] All 4 preset themes work instantly (`applyCorporateTheme`, `applyModernTheme`, `applyFriendlyTheme`, `applyMinimalTheme`)
- [ ] Custom theme configuration via `CorpoDesignTokens.configure()` affects all components
- [ ] Zero lint warnings on `dart analyze`
- [ ] All tests pass after migration
- [ ] Documentation examples use token system

## 🚀 EXECUTION STRATEGY

### Phase 1: Foundation (Week 1)
1. Migrate Typography components (blocks everything else)
2. Migrate core Input components  
3. Complete Layout components

### Phase 2: Interaction (Week 2)
1. Finish Button components
2. Complete Form components
3. Migrate Navigation components

### Phase 3: Feedback (Week 3)
1. Migrate Progress components
2. Complete Feedback components
3. Migrate Overlay components

### Phase 4: Polish (Week 4)
1. Migrate Avatar & Badge components
2. Complete Data components
3. Finish Media & Icon components
4. Remove legacy constants
5. Final testing and documentation

## 🏁 DEFINITION OF DONE

**Corpo UI migration is complete when:**
1. All 98 components use ONLY `CorpoDesignTokens()` for styling
2. Legacy `src/constants/` files are removed
3. All 4 preset themes work perfectly
4. Custom theming via `CorpoDesignTokens.configure()` works
5. Zero hardcoded values remain in the codebase
6. ShadCN philosophy: "Change one file, transform your entire app" ✅

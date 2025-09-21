/// A comprehensive data table component for the Corpo UI design system.
///
/// CorpoDataTable provides consistent data display with sorting, filtering,
/// and pagination capabilities across corporate applications. It follows
/// Material Design principles adapted for professional business use.
///
/// The component includes features essential for corporate data management:
/// - Sortable columns with visual indicators
/// - Row selection (single and multiple)
/// - Pagination with configurable page sizes
/// - Loading states and empty state handling
/// - Responsive design for various screen sizes
///
/// Example usage:
/// ```dart
/// CorpoDataTable<User>(
///   columns: [
///     CorpoDataColumn(
///       key: 'name',
///       label: 'Name',
///       sortable: true,
///     ),
///     CorpoDataColumn(
///       key: 'email',
///       label: 'Email',
///       sortable: true,
///     ),
///     CorpoDataColumn(
///       key: 'role',
///       label: 'Role',
///       width: 120,
///     ),
///   ],
///   rows: users,
///   onSort: (columnKey, ascending) => sortUsers(columnKey, ascending),
///   onSelectionChanged: (selectedRows) => handleSelection(selectedRows),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Configuration for a data table column.
class CorpoDataColumn<T> {
  /// Creates a data table column configuration.
  const CorpoDataColumn({
    required this.key,
    required this.label,
    this.sortable = false,
    this.width,
    this.flex,
    this.alignment = Alignment.centerLeft,
    this.cellBuilder,
    this.headerBuilder,
  });

  /// Unique identifier for this column.
  final String key;

  /// Display label for the column header.
  final String label;

  /// Whether this column can be sorted.
  final bool sortable;

  /// Fixed width for this column.
  final double? width;

  /// Flex value for this column when width is not specified.
  final int? flex;

  /// Alignment for cell content.
  final Alignment alignment;

  /// Custom builder for cell content.
  final Widget Function(BuildContext context, T item)? cellBuilder;

  /// Custom builder for header content.
  final Widget Function(BuildContext context)? headerBuilder;
}

/// Data for a table row.
class CorpoDataRow<T> {
  /// Creates a data table row.
  const CorpoDataRow({
    required this.data,
    required this.cells,
    this.selectable = true,
    this.onTap,
    this.color,
  });

  /// The underlying data object for this row.
  final T data;

  /// Cell values mapped by column key.
  final Map<String, dynamic> cells;

  /// Whether this row can be selected.
  final bool selectable;

  /// Callback when the row is tapped.
  final VoidCallback? onTap;

  /// Background color for this row.
  final Color? color;
}

/// Sort direction for table columns.
enum CorpoSortDirection {
  /// Ascending sort order.
  ascending,

  /// Descending sort order.
  descending,
}

/// A comprehensive data table widget following Corpo UI design principles.
///
/// This component provides enterprise-grade data display with sorting,
/// selection, and pagination capabilities.
class CorpoDataTable<T> extends StatefulWidget {
  /// Creates a Corpo UI data table.
  factory CorpoDataTable({
    required List<CorpoDataColumn<T>> columns,
    required List<CorpoDataRow<T>> rows,
    String? sortColumnKey,
    CorpoSortDirection sortDirection = CorpoSortDirection.ascending,
    void Function(String columnKey, CorpoSortDirection direction)? onSort,
    bool selectable = false,
    Set<T>? selectedRows,
    void Function(Set<T> selectedRows)? onSelectionChanged,
    void Function(T rowData)? onRowTap,
    bool loading = false,
    Widget? emptyWidget,
    double headerHeight = 56.0,
    double rowHeight = 48.0,
    double horizontalMargin = 24.0,
    double columnSpacing = 56.0,
    bool showCheckboxColumn = true,
    TextStyle? headingTextStyle,
    TextStyle? dataTextStyle,
    Key? key,
  }) => CorpoDataTable._(
    columns: columns,
    rows: rows,
    sortColumnKey: sortColumnKey,
    sortDirection: sortDirection,
    onSort: onSort,
    selectable: selectable,
    selectedRows: selectedRows ?? <T>{},
    onSelectionChanged: onSelectionChanged,
    onRowTap: onRowTap,
    loading: loading,
    emptyWidget: emptyWidget,
    headerHeight: headerHeight,
    rowHeight: rowHeight,
    horizontalMargin: horizontalMargin,
    columnSpacing: columnSpacing,
    showCheckboxColumn: showCheckboxColumn,
    headingTextStyle: headingTextStyle,
    dataTextStyle: dataTextStyle,
    key: key,
  );

  /// Creates a Corpo UI data table.
  const CorpoDataTable._({
    required this.columns,
    required this.rows,
    required this.selectedRows,
    this.sortColumnKey,
    this.sortDirection = CorpoSortDirection.ascending,
    this.onSort,
    this.selectable = false,
    this.onSelectionChanged,
    this.onRowTap,
    this.loading = false,
    this.emptyWidget,
    this.headerHeight = 56.0,
    this.rowHeight = 48.0,
    this.horizontalMargin = 24.0,
    this.columnSpacing = 56.0,
    this.showCheckboxColumn = true,
    this.headingTextStyle,
    this.dataTextStyle,
    super.key,
  });

  /// Column configurations for the table.
  final List<CorpoDataColumn<T>> columns;

  /// Data rows to display.
  final List<CorpoDataRow<T>> rows;

  /// Currently sorted column key.
  final String? sortColumnKey;

  /// Current sort direction.
  final CorpoSortDirection sortDirection;

  /// Callback when a column header is tapped for sorting.
  final void Function(String columnKey, CorpoSortDirection direction)? onSort;

  /// Whether rows can be selected.
  final bool selectable;

  /// Currently selected row data.
  final Set<T> selectedRows;

  /// Callback when row selection changes.
  final void Function(Set<T> selectedRows)? onSelectionChanged;

  /// Callback when a row is tapped.
  final void Function(T rowData)? onRowTap;

  /// Whether the table is in a loading state.
  final bool loading;

  /// Widget to display when the table is empty.
  final Widget? emptyWidget;

  /// Height of the header row.
  final double headerHeight;

  /// Height of data rows.
  final double rowHeight;

  /// Horizontal margin for the table.
  final double horizontalMargin;

  /// Spacing between columns.
  final double columnSpacing;

  /// Whether to show the checkbox column for selection.
  final bool showCheckboxColumn;

  /// Text style for column headers.
  final TextStyle? headingTextStyle;

  /// Text style for data cells.
  final TextStyle? dataTextStyle;

  @override
  State<CorpoDataTable<T>> createState() => _CorpoDataTableState<T>();
}

class _CorpoDataTableState<T> extends State<CorpoDataTable<T>> {
  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    if (widget.loading) {
      return _buildLoadingState();
    }

    if (widget.rows.isEmpty) {
      return widget.emptyWidget ?? _buildEmptyState(isDark, tokens);
    }

    return _buildDataTable(isDark, tokens);
  }

  /// Builds the loading state.
  Widget _buildLoadingState() => Container(
    height: 200,
    alignment: Alignment.center,
    child: const CircularProgressIndicator(),
  );

  /// Builds the empty state.
  Widget _buildEmptyState(bool isDark, CorpoDesignTokens tokens) => Container(
    height: 200,
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.table_chart_outlined,
          size: 48,
          color: isDark ? tokens.textSecondary : tokens.textSecondary,
        ),
        SizedBox(height: tokens.spacing4x),
        Text(
          'No data available',
          style: TextStyle(
            fontSize: tokens.fontSizeLarge,
            fontFamily: tokens.fontFamily,
            color: isDark ? tokens.textSecondary : tokens.textSecondary,
          ),
        ),
      ],
    ),
  );

  /// Builds the main data table.
  Widget _buildDataTable(bool isDark, CorpoDesignTokens tokens) {
    final List<DataColumn> dataColumns = _buildDataColumns(isDark, tokens);
    final List<DataRow> dataRows = _buildDataRows(isDark, tokens);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: dataColumns,
        rows: dataRows,
        sortColumnIndex: widget.sortColumnKey != null
            ? widget.columns.indexWhere(
                (CorpoDataColumn<T> col) => col.key == widget.sortColumnKey,
              )
            : null,
        sortAscending: widget.sortDirection == CorpoSortDirection.ascending,
        onSelectAll: widget.selectable ? _handleSelectAll : null,
        headingRowHeight: widget.headerHeight,
        dataRowHeight: widget.rowHeight,
        horizontalMargin: widget.horizontalMargin,
        columnSpacing: widget.columnSpacing,
        showCheckboxColumn: widget.selectable && widget.showCheckboxColumn,
        headingTextStyle:
            widget.headingTextStyle ?? _getHeadingStyle(isDark, tokens),
        dataTextStyle: widget.dataTextStyle ?? _getDataStyle(isDark, tokens),
        headingRowColor: WidgetStateProperty.all(
          isDark ? tokens.surfaceColor.withOpacity(0.1) : tokens.surfaceColor,
        ),
        dataRowColor: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return isDark
                ? tokens.primaryColor.withOpacity(0.3)
                : tokens.primaryColor.withOpacity(0.1);
          }
          if (states.contains(WidgetState.hovered)) {
            return isDark
                ? tokens.surfaceColor.withOpacity(0.15)
                : tokens.surfaceColor.withOpacity(0.5);
          }
          return null;
        }),
      ),
    );
  }

  /// Builds data column definitions.
  List<DataColumn> _buildDataColumns(bool isDark, CorpoDesignTokens tokens) =>
      widget.columns
          .map(
            (CorpoDataColumn<T> column) => DataColumn(
              label:
                  column.headerBuilder?.call(context) ??
                  Text(column.label, style: _getHeadingStyle(isDark, tokens)),
              onSort: column.sortable && widget.onSort != null
                  ? (int columnIndex, bool ascending) {
                      final CorpoSortDirection direction = ascending
                          ? CorpoSortDirection.ascending
                          : CorpoSortDirection.descending;
                      widget.onSort!(column.key, direction);
                    }
                  : null,
            ),
          )
          .toList();

  /// Builds data row definitions.
  List<DataRow> _buildDataRows(bool isDark, CorpoDesignTokens tokens) =>
      widget.rows.map((CorpoDataRow<T> row) {
        final bool isSelected = widget.selectedRows.contains(row.data);

        return DataRow(
          cells: widget.columns.map((CorpoDataColumn<T> column) {
            final dynamic cellValue = row.cells[column.key];

            return DataCell(
              column.cellBuilder?.call(context, row.data) ??
                  _buildDefaultCell(cellValue, isDark, tokens),
              onTap: row.onTap ?? () => widget.onRowTap?.call(row.data),
            );
          }).toList(),
          selected: isSelected,
          onSelectChanged: widget.selectable && row.selectable
              ? (bool? selected) =>
                    _handleRowSelection(row.data, selected ?? false)
              : null,
          color: row.color != null ? WidgetStateProperty.all(row.color) : null,
        );
      }).toList();

  /// Builds a default cell widget.
  Widget _buildDefaultCell(
    dynamic value,
    bool isDark,
    CorpoDesignTokens tokens,
  ) {
    String displayText;

    if (value == null) {
      displayText = '-';
    } else if (value is String) {
      displayText = value;
    } else {
      displayText = value.toString();
    }

    return Text(
      displayText,
      style: _getDataStyle(isDark, tokens),
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Handles select all checkbox.
  void _handleSelectAll(bool? selected) {
    if (widget.onSelectionChanged == null) return;

    if (selected == true) {
      final Set<T> allSelectable = widget.rows
          .where((CorpoDataRow<T> row) => row.selectable)
          .map((CorpoDataRow<T> row) => row.data)
          .toSet();
      widget.onSelectionChanged!(allSelectable);
    } else {
      widget.onSelectionChanged!(<T>{});
    }
  }

  /// Handles individual row selection.
  void _handleRowSelection(T rowData, bool selected) {
    if (widget.onSelectionChanged == null) return;

    final Set<T> newSelection = Set<T>.from(widget.selectedRows);

    if (selected) {
      newSelection.add(rowData);
    } else {
      newSelection.remove(rowData);
    }

    widget.onSelectionChanged!(newSelection);
  }

  /// Gets the heading text style.
  TextStyle _getHeadingStyle(bool isDark, CorpoDesignTokens tokens) =>
      TextStyle(
        fontSize: tokens.baseFontSize,
        fontFamily: tokens.fontFamily,
        fontWeight: FontWeight.w600, // semiBold equivalent
        color: isDark ? tokens.textSecondary : tokens.textPrimary,
      );

  /// Gets the data text style.
  TextStyle _getDataStyle(bool isDark, CorpoDesignTokens tokens) => TextStyle(
    fontSize: tokens.baseFontSize,
    fontFamily: tokens.fontFamily,
    color: isDark ? tokens.textSecondary : tokens.textPrimary,
  );
}

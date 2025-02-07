import 'package:dropdown_search/dropdown_search.dart' as dropdown_search;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field for selecting value(s) from a searchable list
class FormBuilderSearchableDropdown<T> extends FormBuilderField<T> {
  /// final List<DropdownMenuItem<T>> items;

  ///show/hide the search box
  final bool showSearchBox;

  ///true if the filter on items is applied onlie (via API)
  final bool isFilteredOnline;

  ///show/hide clear selected item
  final bool showClearButton;

  ///offline items list
  final List<T> items;

  ///selected item
  final T? selectedItem;

  ///function that returns item from API
  final dropdown_search.DropdownSearchOnFind<T>? onFind;

  ///to customize list of items UI
  final dropdown_search.DropdownSearchBuilder<T>? dropdownBuilder;

  ///to customize selected item
  final dropdown_search.DropdownSearchPopupItemBuilder<T>? popupItemBuilder;

  ///decoration for search box
  final InputDecoration? searchBoxDecoration;

  ///the title for dialog/menu/bottomSheet
  final Color? popupBackgroundColor;

  ///custom widget for the popup title
  final Widget? popupTitle;

  ///customize the fields the be shown
  final dropdown_search.DropdownSearchItemAsString<T>? itemAsString;

  ///	custom filter function
  final dropdown_search.DropdownSearchFilterFn<T>? filterFn;

  ///MENU / DIALOG/ BOTTOM_SHEET
  final dropdown_search.Mode mode;

  ///the max height for dialog/bottomSheet/Menu
  final double? maxHeight;

  ///the max width for the dialog
  final double? dialogMaxWidth;

  ///select the selected item in the menu/dialog/bottomSheet of items
  final bool showSelectedItem;

  ///function that compares two object with the same type to detected if it's the selected item or not
  final dropdown_search.DropdownSearchCompareFn<T>? compareFn;

  ///custom layout for empty results
  final EmptyBuilder? emptyBuilder;

  ///custom layout for loading items
  final LoadingBuilder? loadingBuilder;

  ///custom layout for error
  final dropdown_search.ErrorBuilder? errorBuilder;

  ///the search box will be focused if true
  final bool autoFocusSearchBox;

  ///custom shape for the popup
  final ShapeBorder? popupShape;

  ///handle auto validation
  final bool autoValidate;

  ///custom dropdown clear button icon widget
  final Widget? clearButton;

  ///custom dropdown icon button widget
  final Widget? dropDownButton;

  ///If true, the dropdownBuilder will continue the uses of material behavior
  ///This will be useful if you want to handle a custom UI only if the item !=null
  final bool dropdownBuilderSupportsNullItem;

  ///defines if an item of the popup is enabled or not, if the item is disabled,
  ///it cannot be clicked
  final dropdown_search.DropdownSearchPopupItemEnabled<T>? popupItemDisabled;

  ///set a custom color for the popup barrier
  final Color? popupBarrierColor;

  final Widget Function(BuildContext)? clearButtonBuilder;
  final Widget Function(BuildContext)? dropdownButtonBuilder;
  final FavoriteItemsBuilder<T>? favoriteItemBuilder;
  final List<T> Function(List<T>)? favoriteItems;
  final Future<bool> Function(T?, T?)? onBeforeChange;
  final MainAxisAlignment favoriteItemsAlignment;
  final void Function()? onPopupDismissed;
  final TextEditingController? searchBoxController;
  final Duration? searchDelay;
  final bool showAsSuffixIcons;
  final bool showFavoriteItems;

  /// Creates field for selecting value(s) from a searchable list
  FormBuilderSearchableDropdown({
    Key? key,
    //From Super
    required String name,
    FormFieldValidator<T>? validator,
    T? initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<T?>? onChanged,
    ValueTransformer<T?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<T>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
    required this.items,
    this.autoValidate = false,
    this.mode = dropdown_search.Mode.MENU,
    String? hint,
    this.isFilteredOnline = false,
    this.popupTitle,
    this.selectedItem,
    this.onFind,
    this.dropdownBuilder,
    this.popupItemBuilder,
    this.showSearchBox = true,
    this.showClearButton = false,
    this.searchBoxDecoration,
    this.popupBackgroundColor,
    this.maxHeight,
    this.filterFn,
    this.itemAsString,
    this.showSelectedItem = false,
    this.compareFn,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.autoFocusSearchBox = false,
    this.dialogMaxWidth,
    this.clearButton,
    this.dropDownButton,
    this.dropdownBuilderSupportsNullItem = false,
    this.popupShape,
    this.popupItemDisabled,
    this.popupBarrierColor,
    String? label,
    this.clearButtonBuilder,
    this.dropdownButtonBuilder,
    this.favoriteItemBuilder,
    this.favoriteItems,
    this.onBeforeChange,
    this.favoriteItemsAlignment = MainAxisAlignment.start,
    this.onPopupDismissed,
    this.searchBoxController,
    this.searchDelay,
    this.showAsSuffixIcons = false,
    this.showFavoriteItems = false,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration.copyWith(
            hintText: hint,
            labelText: label,
          ),
          focusNode: focusNode,
          builder: (FormFieldState<T?> field) {
            final state = field as _FormBuilderSearchableDropdownState<T>;

            return dropdown_search.DropdownSearch<T>(
              //Hack to rebuild when didChange is called
              key: ValueKey(state.value),
              items: items,
              maxHeight: maxHeight,
              onFind: onFind,
              onChanged: (val) {
                state.requestFocus();
                state.didChange(val);
              },
              showSearchBox: showSearchBox,
              enabled: state.enabled,
              searchFieldProps: dropdown_search.TextFieldProps(
                autofocus: autoFocusSearchBox,
                decoration: searchBoxDecoration,
                controller: searchBoxController,
              ),
              autoValidateMode: autovalidateMode,
              clearButton: clearButton,
              compareFn: compareFn,
              dialogMaxWidth: dialogMaxWidth,
              dropdownBuilder: dropdownBuilder,
              dropdownBuilderSupportsNullItem: dropdownBuilderSupportsNullItem,
              dropDownButton: dropDownButton,
              dropdownSearchDecoration: state.decoration,
              emptyBuilder: emptyBuilder,
              errorBuilder: errorBuilder,
              filterFn: filterFn,
              isFilteredOnline: isFilteredOnline,
              itemAsString: itemAsString,
              loadingBuilder: loadingBuilder,
              popupBackgroundColor: popupBackgroundColor,
              mode: mode,
              popupBarrierColor: popupBarrierColor,
              popupItemBuilder: popupItemBuilder,
              popupItemDisabled: popupItemDisabled,
              popupShape: popupShape,
              popupTitle: popupTitle,
              selectedItem: state.value,
              showClearButton: showClearButton,
              showSelectedItems: showSelectedItem,
              clearButtonBuilder: clearButtonBuilder,
              dropdownButtonBuilder: dropdownButtonBuilder,
              favoriteItemBuilder: favoriteItemBuilder,
              favoriteItems: favoriteItems,
              onBeforeChange: onBeforeChange,
              favoriteItemsAlignment: favoriteItemsAlignment,
              onPopupDismissed: onPopupDismissed,
              searchDelay: searchDelay,
              showAsSuffixIcons: showAsSuffixIcons,
              showFavoriteItems: showFavoriteItems,
            );
          },
        );

  @override
  _FormBuilderSearchableDropdownState<T> createState() =>
      _FormBuilderSearchableDropdownState<T>();
}

class _FormBuilderSearchableDropdownState<T>
    extends FormBuilderFieldState<FormBuilderSearchableDropdown<T>, T> {}

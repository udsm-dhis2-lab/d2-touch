enum SortOrder { DESC, ASC }

class SortOrderUtil {
  static String? getSortOrderParameters(Map<String, SortOrder>? sortOrder) {
    if (sortOrder == null || sortOrder == {}) {
      return null;
    }

    final sortParams = sortOrder.keys.map((key) {
      SortOrder? order = sortOrder[key];
      switch (order) {
        case SortOrder.ASC:
          return '$key ASC';
        case SortOrder.DESC:
          return '$key DESC';
        default:
          return null;
      }
    }).where((order) => order != null);

    return sortParams.length > 0 ? sortParams.join(', ') : null;
  }
}

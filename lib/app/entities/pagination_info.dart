class PaginatedResponse<T> {
  final int? next;
  final T data;
  PaginatedResponse({
    this.next,
    required this.data,
  });

  // ignore: avoid_shadowing_type_parameters
  PaginatedResponse<T> copyWith<T>({
    int? next,
    required T data,
  }) =>
      PaginatedResponse(
        next: next ?? this.next,
        data: data,
      );
}

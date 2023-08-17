class Shopping {
  final int total;

  Shopping copyWith(int? total) {
    return Shopping(
      total ?? this.total,
    );
  }

  Shopping(this.total);
}

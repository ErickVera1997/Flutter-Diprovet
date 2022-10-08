class Shoping {
  final int total;

  Shoping copyWith(int? total) {
    return Shoping(
      total ?? this.total,
    );
  }

  Shoping(this.total);
}

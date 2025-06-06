class Block {
  final String id;
  final String blockerId;
  final String blockedId;
  final DateTime createdAt;

  Block({
    required this.id,
    required this.blockerId,
    required this.blockedId,
    required this.createdAt,
  });

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      id: json['id'],
      blockerId: json['blockerId'],
      blockedId: json['blockedId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'blockerId': blockerId,
      'blockedId': blockedId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
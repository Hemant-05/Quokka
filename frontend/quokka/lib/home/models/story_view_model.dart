import 'package:quokka/home/models/story_model.dart';
import 'package:quokka/home/models/user_model.dart';

class StoryView {
  final String id;
  final Story story;
  final String storyId;
  final UserModel viewer;
  final String viewerId;
  final DateTime viewedAt;

  StoryView({
    required this.story,
    required this.viewer,
    required this.id,
    required this.storyId,
    required this.viewerId,
    required this.viewedAt,
  });

  factory StoryView.fromJson(Map<String, dynamic> json) {
    return StoryView(
      id: json['id'],
      storyId: json['storyId'],
      viewerId: json['viewerId'],
      viewedAt: DateTime.parse(json['viewedAt']),
      story: Story.fromJson(json['story']),
      viewer: UserModel.fromJson(json['viewer']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storyId': storyId,
      'viewerId': viewerId,
      'viewedAt': viewedAt.toIso8601String(),
      'story': story.toJson(),
    };
  }
}

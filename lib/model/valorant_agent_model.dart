class ValorantAgentModel {
  final String? displayName;
  final String? displayIcon;
  final String? description;
  final String? role;

  ValorantAgentModel({
    this.displayName,
    this.displayIcon,
    this.description,
    this.role,
  });

  factory ValorantAgentModel.fromJson(Map<String, dynamic> json) {
    return ValorantAgentModel(
      displayName: json['displayName'],
      displayIcon: json['displayIcon'],
      description: json['description'],
      role: json['role'],
    );
  }
}

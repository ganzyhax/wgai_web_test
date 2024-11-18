part of 'atlas_bloc.dart';

@immutable
sealed class AtlasEvent {}

class AtlasLoad extends AtlasEvent {}

class AtlasLoadByClusterId extends AtlasEvent {
  final String clusterId;
  AtlasLoadByClusterId({required this.clusterId});
}

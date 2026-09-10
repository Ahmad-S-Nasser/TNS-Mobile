part of 'children_cubit.dart';

enum ChildrenStatus { initial, loading, loaded, error }

class ChildrenState extends Equatable {
  final ChildrenStatus status;
  final List<ChildModel> children;
  final String? errorMessage;
  final bool isSubmitting;
  final bool actionSucceeded;

  const ChildrenState({
    required this.status,
    this.children = const [],
    this.errorMessage,
    this.isSubmitting = false,
    this.actionSucceeded = false,
  });

  const ChildrenState.initial() : this(status: ChildrenStatus.initial);

  ChildrenState copyWith({
    ChildrenStatus? status,
    List<ChildModel>? children,
    String? errorMessage,
    bool isSubmitting = false,
    bool actionSucceeded = false,
  }) =>
      ChildrenState(
        status: status ?? this.status,
        children: children ?? this.children,
        errorMessage: errorMessage,
        isSubmitting: isSubmitting,
        actionSucceeded: actionSucceeded,
      );

  @override
  List<Object?> get props =>
      [status, children, errorMessage, isSubmitting, actionSucceeded];
}

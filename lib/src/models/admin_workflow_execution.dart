// admin_workflow_execution.dart
// AdminWorkflowExecution canonical model - Complete implementation based on @medusajs/types v2.10.1

import 'package:json_annotation/json_annotation.dart';

part 'admin_workflow_execution.g.dart';

/// Transaction step status enumeration
enum TransactionStepStatus {
  @JsonValue('idle')
  idle,
  @JsonValue('ok')
  ok,
  @JsonValue('waiting_response')
  waitingResponse,
  @JsonValue('temp_failure')
  tempFailure,
  @JsonValue('permanent_failure')
  permanentFailure,
}

/// Transaction state enumeration
enum TransactionState {
  @JsonValue('not_started')
  notStarted,
  @JsonValue('invoking')
  invoking,
  @JsonValue('waiting_to_compensate')
  waitingToCompensate,
  @JsonValue('compensating')
  compensating,
  @JsonValue('done')
  done,
  @JsonValue('reverted')
  reverted,
  @JsonValue('failed')
  failed,
}

/// Transaction step state enumeration
enum TransactionStepState {
  @JsonValue('not_started')
  notStarted,
  @JsonValue('invoking')
  invoking,
  @JsonValue('compensating')
  compensating,
  @JsonValue('done')
  done,
  @JsonValue('reverted')
  reverted,
  @JsonValue('failed')
  failed,
  @JsonValue('dormant')
  dormant,
  @JsonValue('skipped')
  skipped,
  @JsonValue('skipped_failure')
  skippedFailure,
  @JsonValue('timeout')
  timeout,
}

/// Step invoke result
@JsonSerializable(fieldRename: FieldRename.snake)
class StepInvokeResult {
  /// The output details of the step
  final StepInvokeOutput output;

  const StepInvokeResult({required this.output});

  factory StepInvokeResult.fromJson(Map<String, dynamic> json) =>
      _$StepInvokeResultFromJson(json);

  Map<String, dynamic> toJson() => _$StepInvokeResultToJson(this);
}

/// Step invoke output
@JsonSerializable(fieldRename: FieldRename.snake)
class StepInvokeOutput {
  /// The output of the step. This is the first parameter
  /// passed to the returned StepResponse function
  final dynamic output;

  /// The input of the step's compensation function.
  /// This is the second parameter passed to the returned StepResponse function
  final dynamic compensateInput;

  const StepInvokeOutput({this.output, this.compensateInput});

  factory StepInvokeOutput.fromJson(Map<String, dynamic> json) =>
      _$StepInvokeOutputFromJson(json);

  Map<String, dynamic> toJson() => _$StepInvokeOutputToJson(this);
}

/// Step error
@JsonSerializable(fieldRename: FieldRename.snake)
class StepError {
  /// The error details
  final Map<String, dynamic> error;

  /// The ID of the action that failed
  final String action;

  /// The type of the handler that failed. It can be invoke or compensate
  final String handlerType;

  const StepError({
    required this.error,
    required this.action,
    required this.handlerType,
  });

  factory StepError.fromJson(Map<String, dynamic> json) =>
      _$StepErrorFromJson(json);

  Map<String, dynamic> toJson() => _$StepErrorToJson(this);
}

/// Workflow execution context data
@JsonSerializable(fieldRename: FieldRename.snake)
class WorkflowExecutionContextData {
  /// The details of the invocation of the workflow execution's steps.
  /// The key is the step's ID, and the value is the step's details.
  /// These details are only included for steps that have their saveResponse property set to true
  final Map<String, StepInvokeResult> invoke;

  /// The payload or input of the workflow execution
  final dynamic payload;

  const WorkflowExecutionContextData({required this.invoke, this.payload});

  factory WorkflowExecutionContextData.fromJson(Map<String, dynamic> json) =>
      _$WorkflowExecutionContextDataFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowExecutionContextDataToJson(this);
}

/// Workflow execution context
@JsonSerializable(fieldRename: FieldRename.snake)
class WorkflowExecutionContext {
  /// The data of the workflow execution
  final WorkflowExecutionContextData data;

  /// The output of the compensation function of the workflow execution.
  /// The key is the step's ID, and the value is the compensation function's output.
  /// These details are only included for steps that have their saveResponse property set to true
  final Map<String, dynamic> compensate;

  /// The errors of the workflow execution
  final List<StepError> errors;

  const WorkflowExecutionContext({
    required this.data,
    required this.compensate,
    required this.errors,
  });

  factory WorkflowExecutionContext.fromJson(Map<String, dynamic> json) =>
      _$WorkflowExecutionContextFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowExecutionContextToJson(this);
}

/// Workflow execution definition
@JsonSerializable(fieldRename: FieldRename.snake)
class WorkflowExecutionDefinition {
  /// If true, the step is executed asynchronously
  final bool? async;

  /// If true, the compensation function for this step is executed asynchronously
  final bool? compensateAsync;

  /// If true, no compensation action will be triggered for this step in case of a failure
  final bool? noCompensation;

  /// Indicates whether the workflow should continue even if there is a permanent failure in this step
  final bool? continueOnPermanentFailure;

  /// Indicates whether the workflow should skip all subsequent steps in case of a permanent failure in this step
  final dynamic skipOnPermanentFailure; // bool or string

  /// The maximum number of times this step should be retried in case of temporary failures
  final int? maxRetries;

  /// If true, the workflow will not wait for their sibling steps to complete before moving to the next step
  final bool? noWait;

  /// The interval (in seconds) between retry attempts after a temporary failure
  final int? retryInterval;

  /// The interval (in seconds) to retry a step even if its status is WAITING
  final int? retryIntervalAwaiting;

  /// If true, the response of this step will be stored. Default is true
  final bool? saveResponse;

  /// The maximum amount of time (in seconds) to wait for this step to complete
  final int? timeout;

  const WorkflowExecutionDefinition({
    this.async,
    this.compensateAsync,
    this.noCompensation,
    this.continueOnPermanentFailure,
    this.skipOnPermanentFailure,
    this.maxRetries,
    this.noWait,
    this.retryInterval,
    this.retryIntervalAwaiting,
    this.saveResponse,
    this.timeout,
  });

  factory WorkflowExecutionDefinition.fromJson(Map<String, dynamic> json) =>
      _$WorkflowExecutionDefinitionFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowExecutionDefinitionToJson(this);
}

/// Workflow execution function
@JsonSerializable(fieldRename: FieldRename.snake)
class WorkflowExecutionFn {
  /// The state of the step
  final TransactionStepState state;

  /// The status of the step
  final TransactionStepStatus status;

  const WorkflowExecutionFn({required this.state, required this.status});

  factory WorkflowExecutionFn.fromJson(Map<String, dynamic> json) =>
      _$WorkflowExecutionFnFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowExecutionFnToJson(this);
}

/// Admin workflow execution step
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminWorkflowExecutionStep {
  /// The ID of the step
  final String id;

  /// The invoke function of the step
  final WorkflowExecutionFn invoke;

  /// The definition of the step
  final WorkflowExecutionDefinition definition;

  /// The compensate function of the step
  final WorkflowExecutionFn compensate;

  /// The depth of the step
  final int depth;

  /// The date the step was started
  final int startedAt;

  const AdminWorkflowExecutionStep({
    required this.id,
    required this.invoke,
    required this.definition,
    required this.compensate,
    required this.depth,
    required this.startedAt,
  });

  factory AdminWorkflowExecutionStep.fromJson(Map<String, dynamic> json) =>
      _$AdminWorkflowExecutionStepFromJson(json);

  Map<String, dynamic> toJson() => _$AdminWorkflowExecutionStepToJson(this);
}

/// Admin workflow execution execution details
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminWorkflowExecutionExecution {
  /// The details of the workflow execution's steps.
  /// The key is the step's ID, and the value is the step's details
  final Map<String, AdminWorkflowExecutionStep> steps;

  const AdminWorkflowExecutionExecution({required this.steps});

  factory AdminWorkflowExecutionExecution.fromJson(Map<String, dynamic> json) =>
      _$AdminWorkflowExecutionExecutionFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminWorkflowExecutionExecutionToJson(this);
}

/// Admin workflow execution entity
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminWorkflowExecution {
  /// The ID of the workflow execution
  final String id;

  /// The ID of the workflow
  final String workflowId;

  /// The ID of the transaction
  final String transactionId;

  /// The execution details of the workflow
  final AdminWorkflowExecutionExecution execution;

  /// The context of the workflow execution.
  /// This includes the data, errors and the output of the step and compensation functions of the workflow execution
  final WorkflowExecutionContext context;

  /// The state of the workflow execution
  final TransactionState state;

  /// The date the workflow execution was created
  final DateTime createdAt;

  /// The date the workflow execution was updated
  final DateTime updatedAt;

  /// The date the workflow execution was deleted
  final DateTime? deletedAt;

  const AdminWorkflowExecution({
    required this.id,
    required this.workflowId,
    required this.transactionId,
    required this.execution,
    required this.context,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminWorkflowExecution.fromJson(Map<String, dynamic> json) =>
      _$AdminWorkflowExecutionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminWorkflowExecutionToJson(this);
}

// Query Parameters

/// Admin get workflow executions parameters
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminGetWorkflowExecutionsParams {
  /// Filter using a search query
  final String? q;

  /// Filter by the ID of the transaction to retrieve workflow executions for a specific transaction
  final List<String>? transactionId;

  /// Filter by the ID of the workflow to retrieve workflow executions for a specific workflow
  final List<String>? workflowId;

  /// Pagination limit
  final int? limit;

  /// Pagination offset
  final int? offset;

  /// Fields to expand in response
  final List<String>? expand;

  /// Fields to select in response
  final List<String>? fields;

  const AdminGetWorkflowExecutionsParams({
    this.q,
    this.transactionId,
    this.workflowId,
    this.limit,
    this.offset,
    this.expand,
    this.fields,
  });

  factory AdminGetWorkflowExecutionsParams.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminGetWorkflowExecutionsParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminGetWorkflowExecutionsParamsToJson(this);
}

// Response Types

/// Acknowledgement for workflow run
@JsonSerializable(fieldRename: FieldRename.snake)
class Acknowledgement {
  /// The acknowledgement ID or status
  final String id;

  /// The acknowledgement status
  final String status;

  const Acknowledgement({required this.id, required this.status});

  factory Acknowledgement.fromJson(Map<String, dynamic> json) =>
      _$AcknowledgementFromJson(json);

  Map<String, dynamic> toJson() => _$AcknowledgementToJson(this);
}

/// Admin workflow execution response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminWorkflowExecutionResponse {
  /// The workflow execution's details
  final AdminWorkflowExecution workflowExecution;

  const AdminWorkflowExecutionResponse({required this.workflowExecution});

  factory AdminWorkflowExecutionResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminWorkflowExecutionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminWorkflowExecutionResponseToJson(this);
}

/// Admin workflow execution list response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminWorkflowExecutionListResponse {
  /// The list of workflow executions
  final List<AdminWorkflowExecution> workflowExecutions;

  /// Total count
  final int? count;

  /// Pagination offset
  final int? offset;

  /// Pagination limit
  final int? limit;

  const AdminWorkflowExecutionListResponse({
    required this.workflowExecutions,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminWorkflowExecutionListResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminWorkflowExecutionListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminWorkflowExecutionListResponseToJson(this);
}

/// Admin workflow run response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminWorkflowRunResponse {
  /// The acknowledgement details
  final Acknowledgement acknowledgement;

  const AdminWorkflowRunResponse({required this.acknowledgement});

  factory AdminWorkflowRunResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminWorkflowRunResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminWorkflowRunResponseToJson(this);
}

// =============================================================================
// ADMIN WORKFLOW EXECUTION RESOURCE - Official @medusajs/types v2.10.1 (CANONICAL)
// =============================================================================

import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin workflow execution management resource for Medusa v2.10+
///
/// Provides comprehensive workflow execution tracking and management capabilities
/// for Medusa's durable execution engine with transaction states, step management,
/// and asynchronous execution support.
///
/// Features:
/// - Workflow execution CRUD operations
/// - Execution state tracking (pending, running, completed, failed, etc.)
/// - Step-by-step execution monitoring
/// - Transaction-based execution with rollback capabilities
/// - Compensation and retry handling
/// - Idempotent execution support
/// - Background and async execution management
///
/// Example:
/// ```dart
/// // List workflow executions
/// final executions = await medusa.admin.workflowExecution.list();
///
/// // Get execution by ID
/// final execution = await medusa.admin.workflowExecution.retrieve('exec_01H...');
///
/// // Create new execution
/// final newExecution = await medusa.admin.workflowExecution.create({
///   'workflow_id': 'order-fulfillment',
///   'input': {'order_id': 'order_01H...'},
///   'idempotent': true,
/// });
///
/// // Cancel execution
/// await medusa.admin.workflowExecution.cancel('exec_01H...', {
///   'reason': 'Customer requested cancellation',
/// });
/// ```
class AdminWorkflowExecutionResource extends AdminResource {
  const AdminWorkflowExecutionResource(super.client);

  /// API endpoint path for workflow executions
  String get resourcePath => '$basePath/workflow-executions';

  /// List workflow executions with pagination and filtering
  ///
  /// [query] - Query parameters for filtering and pagination:
  /// - `workflow_id`: Filter by workflow ID
  /// - `transaction_id`: Filter by transaction ID
  /// - `status`: Filter by execution status
  /// - `idempotent`: Filter by idempotent flag
  /// - `background`: Filter by background execution flag
  /// - `limit`: Number of items to return (default: 20)
  /// - `offset`: Number of items to skip (default: 0)
  /// - `with_deleted`: Include deleted executions
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns paginated list of workflow executions
  Future<PaginatedResponse<AdminWorkflowExecution>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminWorkflowExecution>(
      endpoint: resourcePath,
      dataKey: 'workflow_executions',
      fromJson: AdminWorkflowExecution.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a specific workflow execution by ID
  ///
  /// [id] - The workflow execution ID
  /// [query] - Optional query parameters:
  /// - `expand`: Fields to expand in the response
  /// - `fields`: Fields to include in the response
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns the workflow execution or null if not found
  Future<AdminWorkflowExecution?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminWorkflowExecution>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'workflow_execution',
      fromJson: AdminWorkflowExecution.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new workflow execution
  ///
  /// [data] - Workflow execution creation data:
  /// - `workflow_id` (required): The workflow to execute
  /// - `transaction_id`: Transaction ID for idempotency
  /// - `input`: Input data for the workflow
  /// - `metadata`: Additional metadata
  /// - `priority`: Execution priority
  /// - `timeout`: Execution timeout in milliseconds
  /// - `idempotent`: Whether execution is idempotent
  /// - `background`: Whether to run in background
  /// - `async_execution`: Whether to execute asynchronously
  /// - `tags`: Tags for filtering and organization
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns the created workflow execution
  Future<AdminWorkflowExecution?> create(
    Map<String, dynamic> data, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminWorkflowExecution>(
      endpoint: resourcePath,
      dataKey: 'workflow_execution',
      fromJson: AdminWorkflowExecution.fromJson,
      body: data,
      headers: headers,
    );
  }

  /// Update a workflow execution
  ///
  /// [id] - The workflow execution ID
  /// [data] - Update data:
  /// - `metadata`: Updated metadata
  /// - `tags`: Updated tags
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns the updated workflow execution
  Future<AdminWorkflowExecution?> update(
    String id,
    Map<String, dynamic> data, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminWorkflowExecution>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'workflow_execution',
      fromJson: AdminWorkflowExecution.fromJson,
      body: data,
      headers: headers,
    );
  }

  /// Delete a workflow execution
  ///
  /// [id] - The workflow execution ID
  /// [headers] - Optional headers for the request
  ///
  /// Returns deletion confirmation
  Future<Map<String, dynamic>> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    return await deleteGeneric(
      id: id,
      endpoint: '$resourcePath/$id',
      headers: headers,
    );
  }

  /// Cancel a running workflow execution
  ///
  /// [id] - The workflow execution ID
  /// [data] - Cancellation data:
  /// - `reason`: Cancellation reason
  /// - `force`: Force cancellation even if running
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns the cancelled workflow execution
  Future<AdminWorkflowExecution?> cancel(
    String id,
    Map<String, dynamic> data, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/cancel',
      method: 'POST',
      body: data,
      headers: headers,
    );

    final workflowData = response['workflow_execution'];
    return workflowData != null
        ? AdminWorkflowExecution.fromJson(workflowData as Map<String, dynamic>)
        : null;
  }

  /// Retry a failed workflow execution
  ///
  /// [id] - The workflow execution ID
  /// [data] - Retry configuration:
  /// - `reset_to_step`: Step to reset execution to
  /// - `input`: Override input data
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns the retried workflow execution
  Future<AdminWorkflowExecution?> retry(
    String id,
    Map<String, dynamic> data, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/retry',
      method: 'POST',
      body: data,
      headers: headers,
    );

    final workflowData = response['workflow_execution'];
    return workflowData != null
        ? AdminWorkflowExecution.fromJson(workflowData as Map<String, dynamic>)
        : null;
  }

  /// Get execution steps for a workflow execution
  ///
  /// [id] - The workflow execution ID
  /// [query] - Optional query parameters:
  /// - `limit`: Number of steps to return
  /// - `offset`: Number of steps to skip
  /// - `status`: Filter by step status
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns paginated list of execution steps
  Future<PaginatedResponse<AdminWorkflowExecutionStep>> getSteps(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminWorkflowExecutionStep>(
      endpoint: '$resourcePath/$id/steps',
      dataKey: 'steps',
      fromJson: AdminWorkflowExecutionStep.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Get execution logs for a workflow execution
  ///
  /// [id] - The workflow execution ID
  /// [query] - Optional query parameters:
  /// - `limit`: Number of log entries to return
  /// - `offset`: Number of log entries to skip
  /// - `level`: Filter by log level
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns execution logs
  Future<Map<String, dynamic>> getLogs(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/logs',
      method: 'GET',
      query: query,
      headers: headers,
    );

    return response;
  }

  /// Get execution metrics for monitoring
  ///
  /// [query] - Optional query parameters:
  /// - `workflow_id`: Filter by workflow ID
  /// - `start_date`: Start date for metrics
  /// - `end_date`: End date for metrics
  /// - `granularity`: Metrics granularity (hour, day, week)
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns execution metrics and statistics
  Future<Map<String, dynamic>> getMetrics({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/metrics',
      method: 'GET',
      query: query,
      headers: headers,
    );

    return response;
  }

  /// Get execution statistics
  ///
  /// [query] - Optional query parameters:
  /// - `workflow_id`: Filter by workflow ID
  /// - `status`: Filter by execution status
  /// - `period`: Time period for statistics
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns execution statistics
  Future<Map<String, dynamic>> getStatistics({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/statistics',
      method: 'GET',
      query: query,
      headers: headers,
    );

    return response;
  }

  /// Bulk cancel multiple workflow executions
  ///
  /// [data] - Bulk cancellation data:
  /// - `execution_ids`: List of execution IDs to cancel
  /// - `reason`: Cancellation reason
  /// - `force`: Force cancellation
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns bulk operation results
  Future<Map<String, dynamic>> bulkCancel(
    Map<String, dynamic> data, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/bulk-cancel',
      method: 'POST',
      body: data,
      headers: headers,
    );

    return response;
  }

  /// Bulk retry multiple failed workflow executions
  ///
  /// [data] - Bulk retry data:
  /// - `execution_ids`: List of execution IDs to retry
  /// - `reset_to_step`: Step to reset executions to
  ///
  /// [headers] - Optional headers for the request
  ///
  /// Returns bulk operation results
  Future<Map<String, dynamic>> bulkRetry(
    Map<String, dynamic> data, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/bulk-retry',
      method: 'POST',
      body: data,
      headers: headers,
    );

    return response;
  }
}

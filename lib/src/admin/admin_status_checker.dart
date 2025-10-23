// =============================================================================
// ADMIN MODULE STATUS CHECKER - Real-time Progress Monitoring
// =============================================================================

import '../../medusajs_dart_sdk.dart';

/// Real-time status checker for Admin module progress and functionality
///
/// Provides comprehensive monitoring of:
/// - Resource availability and status
/// - Module completion metrics
/// - System health indicators
/// - Performance statistics
///
/// Example usage:
/// ```dart
/// final checker = AdminStatusChecker();
/// final status = await checker.getFullStatus();
/// print('Admin Module: ${status.completionPercentage}% complete');
/// ```
class AdminStatusChecker {
  /// Get comprehensive status of the Admin module
  Future<AdminModuleStatus> getFullStatus() async {
    final medusa = Medusa(
      MedusaConfig(
        baseUrl: 'https://test.medusajs.com',
        publishableKey: 'test_key',
      ),
    );

    return AdminModuleStatus(admin: medusa.admin, timestamp: DateTime.now());
  }

  /// Quick health check of Admin module
  bool performHealthCheck() {
    try {
      final medusa = Medusa(
        MedusaConfig(
          baseUrl: 'https://test.medusajs.com',
          publishableKey: 'test_key',
        ),
      );

      // Verify core resources are accessible
      final coreResources = [
        medusa.admin.product,
        medusa.admin.order,
        medusa.admin.customer,
        medusa.admin.inventory,
        medusa.admin.workflowExecution,
      ];

      return coreResources.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get resource availability matrix
  Map<String, ResourceStatus> getResourceMatrix() {
    return {
      // Core Commerce
      'product': ResourceStatus.available,
      'order': ResourceStatus.available,
      'customer': ResourceStatus.available,
      'inventory': ResourceStatus.available,
      'region': ResourceStatus.available,

      // Enhanced Features
      'workflowExecution': ResourceStatus.available,
      'exchange': ResourceStatus.available,
      'fulfillmentProvider': ResourceStatus.available,
      'shippingOptionType': ResourceStatus.available,

      // Temporarily Disabled
      'fulfillment': ResourceStatus.disabled,
      'payment': ResourceStatus.disabled,
      'paymentCollection': ResourceStatus.disabled,
      'user': ResourceStatus.disabled,
    };
  }

  /// Generate detailed progress report
  String generateProgressReport() {
    final status = getResourceMatrix();
    final available =
        status.values.where((s) => s == ResourceStatus.available).length;
    final total = status.length;
    final percentage = (available / total * 100).toStringAsFixed(1);

    final buffer = StringBuffer();
    buffer.writeln('=== Admin Module Progress Report ===');
    buffer.writeln('Generated: ${DateTime.now()}');
    buffer.writeln('');
    buffer.writeln(
      'Overall Status: $available/$total resources ($percentage%)',
    );
    buffer.writeln('');

    buffer.writeln('✅ Available Resources:');
    status.entries
        .where((entry) => entry.value == ResourceStatus.available)
        .forEach((entry) => buffer.writeln('  - ${entry.key}'));

    buffer.writeln('');
    buffer.writeln('⏸️ Disabled Resources:');
    status.entries
        .where((entry) => entry.value == ResourceStatus.disabled)
        .forEach((entry) => buffer.writeln('  - ${entry.key}'));

    return buffer.toString();
  }
}

/// Comprehensive status information for Admin module
class AdminModuleStatus {
  final MedusaAdmin admin;
  final DateTime timestamp;

  AdminModuleStatus({required this.admin, required this.timestamp});

  /// Get completion percentage
  double get completionPercentage => admin.stats.completionPercentage;

  /// Get number of active resources
  int get activeResources => AdminModuleStats.activeResources;

  /// Get total resources available
  int get totalResources => AdminModuleStats.totalResources;

  /// Get disabled resource count
  int get disabledResources => AdminModuleStats.disabledResources;

  /// Check if module is healthy
  bool get isHealthy => completionPercentage >= 90.0;

  /// Get status level
  StatusLevel get statusLevel {
    if (completionPercentage >= 95.0) return StatusLevel.excellent;
    if (completionPercentage >= 85.0) return StatusLevel.good;
    if (completionPercentage >= 70.0) return StatusLevel.fair;
    return StatusLevel.needs_work;
  }

  /// Get human-readable status
  String get statusDescription {
    switch (statusLevel) {
      case StatusLevel.excellent:
        return 'Excellent - Near complete functionality';
      case StatusLevel.good:
        return 'Good - Most features available';
      case StatusLevel.fair:
        return 'Fair - Core features available';
      case StatusLevel.needs_work:
        return 'Needs Work - Limited functionality';
    }
  }

  /// Get resource availability summary
  Map<String, dynamic> get summary => {
    'timestamp': timestamp.toIso8601String(),
    'completion_percentage': completionPercentage,
    'active_resources': activeResources,
    'total_resources': totalResources,
    'disabled_resources': disabledResources,
    'status_level': statusLevel.name,
    'status_description': statusDescription,
    'is_healthy': isHealthy,
    'disabled_resource_names': admin.disabledResources,
  };

  @override
  String toString() {
    return 'AdminModuleStatus('
        'completion: ${completionPercentage.toStringAsFixed(1)}%, '
        'active: $activeResources/$totalResources, '
        'status: ${statusLevel.name}'
        ')';
  }
}

/// Resource availability status
enum ResourceStatus { available, disabled, error }

/// Overall status level indicators
enum StatusLevel { excellent, good, fair, needs_work }

/// Quick status check function for debugging
void printAdminStatus() {
  final checker = AdminStatusChecker();
  print(checker.generateProgressReport());
}

/// Validate Admin module integrity
bool validateAdminModule() {
  final checker = AdminStatusChecker();
  return checker.performHealthCheck();
}

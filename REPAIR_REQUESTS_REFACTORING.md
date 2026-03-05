# Repair Requests Feature Refactoring

## Overview
Refactored the repair requests feature to follow clean architecture principles with proper separation of concerns.

## Changes Made

### 1. Model Separation
Created separate files for each model class:
- `repair_request_model.dart` - Main response model
- `repair_request_content.dart` - Individual repair request data
- `repair_request_sort.dart` - Sorting configuration (for future use with sorted arrays)
- `repair_request_sort_info.dart` - Sort information object (sorted, empty, unsorted flags)
- `repair_request_pageable.dart` - Pagination information

**Location:** `lib/features/admin/tabs/manage-repair-requests/data/models/`

**Note:** The API returns `sort` as an object with boolean flags (`sorted`, `empty`, `unsorted`), not as an array. The `RepairRequestSortInfo` model handles this structure, while `RepairRequestSort` is kept for potential future use if the API returns sorted arrays.

### 2. Data Layer

#### Data Source
- **Interface:** `repair_requests_remote_datasource.dart`
- **Implementation:** `repair_requests_remote_datasource_impl.dart`
  - Handles API calls via ApiClient
  - Implements error extraction from DioException
  - Provides detailed logging for debugging

#### Repository
- **Interface:** `repair_requests_repo.dart`
- **Implementation:** `repair_requests_repo_impl.dart`
  - Delegates to data source
  - Follows repository pattern

### 3. Domain Layer

#### Use Cases
- `get_all_repair_requests_usecase.dart` - Fetches all repair requests with pagination
- `get_repair_requests_by_status_usecase.dart` - Fetches repair requests filtered by status

### 4. Presentation Layer

#### Cubit
- `repair_requests_cubit.dart` - Manages state for repair requests
  - Uses use cases for business logic
  - Handles error extraction and formatting

#### States
- `repair_requests_states.dart`
  - RepairRequestsInitial
  - RepairRequestsLoading
  - RepairRequestsSuccess
  - RepairRequestsError

#### View
- `admin_repair_requests_screen.dart`
  - Displays repair requests in a data table
  - Supports search and status filtering
  - Implements pagination
  - Responsive design for mobile and desktop

### 5. Localization
Added new translation keys:
- `device_category` - Device Category / فئة الجهاز
- `delivery_method` - Delivery Method / طريقة التوصيل
- `confirmed` - Confirmed / مؤكد

### 6. Dependency Injection
All classes are properly registered with `@injectable` and `@LazySingleton` annotations for automatic dependency injection.

## Architecture Benefits

1. **Separation of Concerns**: Each layer has a single responsibility
2. **Testability**: Easy to mock dependencies and test each layer independently
3. **Maintainability**: Changes in one layer don't affect others
4. **Scalability**: Easy to add new features or modify existing ones
5. **Error Handling**: Centralized error extraction and handling
6. **Type Safety**: Proper model separation ensures type safety

## File Structure
```
lib/features/admin/tabs/manage-repair-requests/
├── data/
│   ├── datasource/
│   │   └── repair_requests_remote_datasource.dart
│   ├── datasource_impl/
│   │   └── repair_requests_remote_datasource_impl.dart
│   ├── models/
│   │   ├── repair_request_model.dart
│   │   ├── repair_request_content.dart
│   │   ├── repair_request_sort.dart
│   │   ├── repair_request_sort_info.dart
│   │   └── repair_request_pageable.dart
│   └── repo_impl/
│       └── repair_requests_repo_impl.dart
├── domain/
│   ├── repo/
│   │   └── repair_requests_repo.dart
│   └── usecases/
│       ├── get_all_repair_requests_usecase.dart
│       └── get_repair_requests_by_status_usecase.dart
└── presentation/
    ├── view/
    │   └── admin_repair_requests_screen.dart
    └── viewmodel/
        ├── repair_requests_cubit.dart
        └── states/
            └── repair_requests_states.dart
```

## API Integration
The feature integrates with the following API endpoints:
- `GET /admin/repair-requests?page={page}` - Get all repair requests
- `GET /admin/repair-requests/status/{status}?page={page}` - Get repair requests by status

## Error Handling
- DioException errors are properly extracted and formatted
- User-friendly error messages are displayed
- Detailed logging for debugging purposes
- Fallback error messages for unexpected errors

## Next Steps
1. Test the API call to verify the JSON deserialization fix works correctly
2. Add unit tests for use cases
3. Add widget tests for the screen
4. Add integration tests for the complete flow
5. Consider adding caching mechanism for offline support
6. Add pull-to-refresh functionality

## Issues Fixed

### JSON Deserialization Error
**Problem:** The API returns `sort` as an object `{"sorted":false,"empty":true,"unsorted":true}`, but the models expected it to be a `List<RepairRequestSort>`, causing a type cast error.

**Solution:** Created `RepairRequestSortInfo` model to match the actual API response structure and updated both `RepairRequestModel` and `RepairRequestPageable` to use `RepairRequestSortInfo?` instead of `List<RepairRequestSort>?`.

**Files Modified:**
- Created: `repair_request_sort_info.dart`
- Updated: `repair_request_model.dart` (changed sort field type)
- Updated: `repair_request_pageable.dart` (changed sort field type)
- Regenerated: All `.g.dart` files via build_runner

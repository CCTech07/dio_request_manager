# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2025-03-28
### Added
- Initial release of `dio_request_manager`.
- Support for `GET`, `POST`, `PUT`, and `DELETE` requests.
- Automatic token handling with `getToken` callback.
- Error handling with custom exceptions (`ApiException`, `NetworkException`, etc.).
- API response standardization with `ApiResponse` class.
- Logging for API requests and responses.
- Customizable base URL for flexibility.

### Fixed
- Improved error handling for network failures.

## [1.1.0] - Upcoming
### Added
- Planned support for request retries.
- Improved logging with request/response details.

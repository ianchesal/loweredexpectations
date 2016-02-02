# lowered-expectations Release Notes

## 1.0.1

* Move development dependencies out of the gemspec into the gemfile.
* Fix spec and integration tests to look for specific raised error for `.which` method.
* Resolve `NameError` raise on checking path to see if command exists.

## 1.0.0

* Our first release
* Supports finding things on `PATH` but not absolute or relative executables
* Has not been tested in Windows but, hey, it should work, right?

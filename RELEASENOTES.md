# lowered-expectations Release Notes

## 1.1.0

* Updated development dependencies to avoid CVEs
* Updated cops
* Dropped support for Ruby 2.0, 2.1 and 2.2

## 1.0.3

* Bugfix for exitstatus checks when running in quiet mode

## 1.0.2

* Updated rubocop library to cover CVE-2017-8418
* Updated everything else while I was at it
* Fixed everything that broke because of the updates
* Updated Travis configuration to ensure we test against every 2.x release of ruby

## 1.0.1

* Move development dependencies out of the gemspec into the gemfile.
* Fix spec and integration tests to look for specific raised error for `.which` method.
* Resolve `NameError` raise on checking path to see if command exists.

## 1.0.0

* Our first release
* Supports finding things on `PATH` but not absolute or relative executables
* Has not been tested in Windows but, hey, it should work, right?

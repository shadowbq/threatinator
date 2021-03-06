0.4.0
====
* FORK NAMESPACE - shadowbq-threatinator
* Table output includes event_types
* AMQP JSON data output plugin

0.3.0
====
* IP URL breakouts

0.2.1
====
* Ensure that FeedRunner calls output formatters #finish method (allows for
  closing of any file handles) - [@justfalter](https://github.com/justfalter)
* Ensure that HTTP fetcher does not reuse sockets (and thus leave them open) - [@justfalter](https://github.com/justfalter)

0.2.0
====

* Fix file-handle leak - [@justfalter](https://github.com/justfalter)
* BREAKING CHANGE: Event#ipv4s -> now an Ipv4ObservableCollection that consists on Ipv4Observable objects.
* Normalize and validate ipv4 addresses.
* Add URL support [@justfalter](https://github.com/justfalter)
* Re-implement Event model, get rid of PropertyDefiner [@justfalter](https://github.com/justfalter)
* Disable decoding when testing the parsing of a single record. [@justfalter](https://github.com/justfalter)

0.1.6
====

* [#121](https://github.com/cikl/threatinator/issues/121) Add threatinator list 'json' output format. [@justfalter](https://github.com/justfalter)

0.1.5
====

* [#56](https://github.com/cikl/threatinator/issues/56): Add missing require for 'set' - [@justfalter](https://github.com/justfalter)

0.1.4
=====
* [#115](https://github.com/cikl/threatinator/issues/115): Add missing require for 'set'. - [@justfalter](https://github.com/justfalter)

0.1.2
====

* Actually include the feeds in the release. Sigh. - [@justfalter](https://github.com/justfalter)


0.1.2
=====
* [#56](https://github.com/cikl/threatinator/pull/56): Gemify threatinator - [@justfalter](https://github.com/justfalter)
* [#55](https://github.com/cikl/threatinator/pull/55): Rewrote configuration handling - [@justfalter](https://github.com/justfalter)
* [#51](https://github.com/cikl/threatinator/pull/51): Clean up spec layout - [@justfalter](https://github.com/justfalter)
* [#43](https://github.com/cikl/threatinator/issues/43): Make output modules pluggable - [@justfalter](https://github.com/justfalter)
* [#46](https://github.com/cikl/threatinator/pull/46): Relocate all parsers related stuff to parser directory - [@justfalter](https://github.com/justfalter)
* [#40](https://github.com/cikl/threatinator/pull/40): Add feed handler for Phishtank - [@justfalter](https://github.com/justfalter)
* [#40](https://github.com/cikl/threatinator/pull/40): Break support for JRuby until we find a decent JSON parser - [@justfalter](https://github.com/justfalter)
* [#40](https://github.com/cikl/threatinator/pull/40): Add JSON parsing support - [@justfalter](https://github.com/justfalter)
* [#33](https://github.com/cikl/threatinator/pull/33): Add CSV parsing support - [@justfalter](https://github.com/justfalter)

0.1.1
====

* Remember to rev the changelog. - [@justfalter](https://github.com/justfalter)


0.1.0
====

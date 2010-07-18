---
layout: blog
title: Version Semantically
categories:
  - best_practices
---

The relationship between interface and implementation is a game of cat-and-mouse. Implementers naturally strive for feature-completeness and interface maintainers for stability. [Semantic Versioning](http://semver.org/) can help tremendously here.  Some **strong** recommendations:

* Use *tiny* versions for updating documentation. For example:

      # version 1.2.3:
      def foo(bar)
        return @adapter.fooify(bar)
      end
    
      # version 1.2.4:
      # @param [Bar] bar
      # @return [String] the foo representation of bar
      def foo(bar)
        return @adapter.fooify(bar)
      end

* Use *minor* or *tiny* versions for _adding_ implementation adapters. If you have autoloading default implementations, new implementations must be at the bottom of the list if using *tiny* versions. For example:

      # version 1.2.3:
      module Foo
        module Adapters
          class Bar
            ...
          end
        end
      end
    
      # version 1.2.4:
      module Foo
        module Adapters
          class Bar
            ...
          end
        class Baz
            ...
          end
        end
      end

* Use *major* versions for any changes to the interface itself: additions, deletions, and modifications. Adding or modifying methods will break backwards compatibility for implementers. Removing or modifying methods will break backwards compatibility for clients.

* Use *major* versions for removing implementation adapters.

* Deprecate methods and classes for at least one full *minor* version before removing them completely in the following *major* version. For example:

      # version 1.2.3:
      def foo...
    
      # version 1.3.0:
      # @deprecated
      def foo...
    
      # version 2.0.0:
      # (gone)

---
layout: blog
title: Consider Using Proxies for Adapters
categories:
  - best_practices
---

Having implementation adapters that are proxies that properly define `#method_missing` and `#respond_to?` allows clients to take advantage of non-standard functionality when using interface classes. For example

    # in your interface library:
    module MyInteface
      module Adapters
        class FooAdapter
          def initialize(name)
            require 'foo'
            @backing_foo = Foo.new(:name => name)
          end
          def standard_interface_call
            @backing_foo.bar
          end
          def respond_to?(sym)
            super || @backing_foo.respond_to?(sym)
          end
          def method_missing(sym, *args, &block)
            if @backing_foo.respond_to?(sym)
              @backing_foo.send(sym, *args, &block)
            else
              super
            end
          end
        end
      end
    end
    
    # in a client:
    widget = MyInterface.widget('widget name')
    widget.standard_interface_call
    if widget.respond_to?(:special_foo_only_functionality)
      ...
    end

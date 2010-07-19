---
layout: blog
title: Use Autoload
categories:
  - best_practices
---

Separating implementation adapters into individual files and using `autoload` will reduce load time and memory usage for clients without forcing them to manually `require 'interface/implementation'`. For example

    # in lib/my_interface.rb:
    module MyInterface
      module Adapters
        autoload :FooAdapter, 'my_interface/adapters/foo.rb'
        autoload :BarAdapter, 'my_interface/adapters/bar.rb'
        autoload :BazAdapter, 'my_interface/adapters/baz.rb'
      end
    end
    
    # in lib/my_interface/adapters/foo.rb:
    require 'foo'
    module MyInterface
      module Adapters
        class FooAdapter
          ...
        end
      end
    end

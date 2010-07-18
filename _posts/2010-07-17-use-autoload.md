---
layout: blog
title: Use Autoload
categories:
  - best_practices
---

Separating implementation adapters into individual files and using `autoload` will reduce load time and memory usage for clients without forcing them to manually `require 'interface/implementation'`. For example

    # in lib/my_interface.rb:
    module MyInteface
      module Adapters
        autoload :FooAdapter, 'my_inteface/adapters/foo.rb'
        autoload :BarAdapter, 'my_inteface/adapters/bar.rb'
        autoload :BazAdapter, 'my_inteface/adapters/baz.rb'
      end
    end
    
    # in lib/my_inteface/adapters/foo.rb:
    require 'foo'
    module MyInterface
      module Adapters
        class FooAdapter
          ...
        end
      end
    end

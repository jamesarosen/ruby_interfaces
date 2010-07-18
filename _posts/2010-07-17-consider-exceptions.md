---
layout: blog
title: Consider Exceptions
categories: best-practices
---

If implementations use custom exceptions (e.g. [`TwitterError`](http://github.com/jnunemaker/twitter/tree/HEAD/lib/twitter.rb)), consider offering an interface version so clients have an easier time writing `rescue` phrases. The most extensible way is to declare one or more exception modules in your interface and then mix them into the implementation exception classes when you load them. For example:

    # in your interface library:
    module MyInterface
      module ParseException; end;
      
      class SomeImplementationAdapter
        def initialize
          require 'some_implementation'
          unless SomeImplementation::ParseException < MyInterface::ParseException
            SomeImplementation::ParseException.send :include, MyInterface::ParseException
          end
        end
      end
    end
    
    # in a client:
    MyInteface.use 'some_implementation'
    begin
      value = MyInterface.parse('foo')
    rescue MyInterface::ParseException
      ...
    end

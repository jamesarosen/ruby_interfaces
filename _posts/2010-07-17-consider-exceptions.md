---
layout: blog
title: Consider Exceptions
categories:
  - best_practices
---

If implementations use custom exceptions (e.g. [`TwitterError`](http://github.com/jnunemaker/twitter/tree/HEAD/lib/twitter.rb)), consider offering an interface version so clients have an easier time writing `rescue` phrases.

## Option 1: Mixins

Declare one or more exception modules in your interface and then mix them into the implementation exception classes when you load them. For example:

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
    MyInterface.use 'some_implementation'
    begin
      value = MyInterface.parse('foo')
    rescue MyInterface::ParseException
      ...
    end

## Option 2: Exception Class Arrays

Declare one or more "constant" `Array`s containing known exception classes. Populate the `Array`(s) with classes whose implementations are loaded. For example:

    # in your interface library:
    module MyInterface
      PARSE_EXCEPTION_CLASSES = []
      
      class SomeImplementationAdapter
        def initialize
          require 'some_implementation'
          unless MyInterface::PARSE_EXCEPTION_CLASSES.include?(SomeImplementation::ParseException)
            MyInterface::PARSE_EXCEPTION_CLASSES << SomeImplementation::ParseException
          end
        end
      end
    end
    
    # in a client:
    MyInterface.use 'some_implementation'
    begin
      value = MyInterface.parse('foo')
    rescue *MyInterface::PARSE_EXCEPTION_CLASSES
      ...
    end

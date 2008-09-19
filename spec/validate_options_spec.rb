require File.dirname(__FILE__) + '/spec_helper'

class Foo
  def bar(options = {})
    validate_options options, :foobar, :baz
  end
end

class Bar
  def foo(argument1, argument2, options = {})
    true
  end
  validate_options_for :foo, :bar
end

class Foobar
  def baz(options = nil)
    validate_options options, :bar, :foo, :barz do |op|
      raise ArgumentError, 'bar cannot be a negative number' if op[:bar] && op[:bar] < 0
      raise 'barz should be either yes or no' if op[:barz] && !%{yes no}.include?(op[:barz].to_s)
    end
  end
end

describe ValidateOptions do
  describe 'inside a method' do
    it "validates options" do
      enabled do
        lambda { Foo.new.bar }.should_not raise_error
        lambda { Foo.new.bar(nil) }.should_not raise_error
        lambda { Foo.new.bar(:foobar => 1) }.should_not raise_error
        lambda { Foo.new.bar(:foobar => 1, :baz => 2) }.should_not raise_error
        lambda { Foo.new.bar(:foobaz => 1, :baz => 2) }.should raise_error(ArgumentError)
      end
    end

    it "does not validate options when disabled" do
      lambda { Foo.new.bar(:foobaz => 1, :baz => 2) }.should_not raise_error

      # Make sure that validate_options is really
      # a no-op when the module is disabled.
      options = {}
      options.should_not_receive(:keys)
      Foo.new.bar(options)
    end

    it "takes a block for more fine-grained control over option validation" do
      enabled do
        lambda { Foobar.new.baz }.should_not raise_error
        lambda { Foobar.new.baz(:baz => 1) }.should raise_error(ArgumentError)
        lambda { Foobar.new.baz(:foo => 1) }.should_not raise_error

        lambda { Foobar.new.baz(:bar => 1) }.should_not raise_error
        lambda { Foobar.new.baz(:bar => -1) }.should raise_error(ArgumentError)
        
        lambda { Foobar.new.baz(:barz => true) }.should raise_error(ArgumentError)
      end
    end
  end

  describe 'as a class method' do
    it "validates options for a given method" do
      enabled do
        lambda { Bar.new.foo(nil, nil) }.should_not raise_error
        lambda { Bar.new.foo(nil, nil, :bar => 1) }.should_not raise_error
        lambda { Bar.new.foo(nil, nil, :baz => 1) }.should raise_error(ArgumentError)
        
        Bar.new.foo(nil, nil).should be_true
      end
    end
    
    it "does not validate options when disabled" do
      lambda { Bar.new.foo(nil, nil, :baz => 1) }.should_not raise_error

      # Make sure that validate_options is really
      # a no-op when the module is disabled.
      options = {}
      options.should_not_receive(:keys)
      Bar.new.foo(nil, nil, options)
    end
  end
end

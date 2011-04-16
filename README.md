# ActsAsOrderable
## Install

    gem install acts_as_orderable

and in your Gemfile:
    
    gem 'acts_as_orderable'

Model declaration:

    class CoolClass < ActiveRecord::Base
        acts_as_orderable
    end    

## About

Simple Rails gem allowing ActiveRecord models to have order and to move them up and down

Requirements

    table.integer :element_order, :default => 0, :null => false

It works well with acts_ac_tree (each node has its own order so they don't interfere with each other)

Use `:position => :first` or `:position => :last` to set default new element behavior - should it be append as and first or last element. Default is `:last`. This default behavior will also be used when switching parents when you use `acts_as_tree`.

## Example

    class CoolClass < ActiveRecord::Base
        acts_as_orderable
    end

    # Creating some records record
    a = CoolClass.new(:name => A); a.save
    b = CoolClass.new(:name => B); b.save
    c = CoolClass.new(:name => C); c.save
    d = CoolClass.new(:name => D); d.save

    #Order:
    0 => A
    1 => B
    2 => C
    3 => D

Lets take element C and lest move it 1 element up

    c.move_up(1)

    #New Order:
    0 => A
    1 => C
    2 => B
    3 => D

Now lest move C 2 elements down
    
    c.move_down(2)

    # Order:
    0 => A
    1 => B
    2 => D
    3 => C

# Additional notes

With acts_as_tree plugin, you use it in the same way, just remember that you operate on a node order.

There is one more thing: if you look into element_order column, numbers are not always like: 0, 1, 2, 3, 4, etc. They are more like 0, 1, 23, 452, 523.
That's because when you delete a row, there will be deleted also one "order". But don't worry, everything works fine even then.

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Maciej Mensfeld. See LICENSE for details.

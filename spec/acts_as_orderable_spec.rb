require 'spec_helper'

ROOT = File.expand_path(File.dirname(__FILE__))

class CoolElement < ActiveRecord::Base
  acts_as_orderable
end

class CoolerElement < ActiveRecord::Base
  acts_as_orderable :position => :first
end

class WayCoolerElement < ActiveRecord::Base
  acts_as_tree
  acts_as_orderable
end

describe CoolElement do
  subject { CoolElement }
  before(:each){ CoolElement.destroy_all}

  context "when adding first element" do
    it "always should  have order equal 0" do
      a = subject.new
      a.save
      a.element_order.should == 0    
    end    
  end
  
  context "when we add second and third elements" do

    it "should be in a correct order" do
      a=subject.create; b=subject.create; c=subject.create
      a.reload; b.reload; c.reload
      a.element_order.should == 0
      b.element_order.should == 1
      c.element_order.should == 2
    end
  
    it "should return valid previous element" do
      a=subject.create; b=subject.create; c=subject.create
      a.reload; b.reload; c.reload
      a.previous.should == nil
      b.previous.should == a
      c.previous.should == b
    end
    
    it "should return valid next element" do
      a=subject.create; b=subject.create; c=subject.create
      a.reload; b.reload; c.reload
      a.next.should == b
      b.next.should == c
      c.next.should == nil
    end

    it "should be able to move them up" do
      a=subject.create; b=subject.create; c=subject.create
      a.reload; b.reload; c.reload
      c.move_up
      a.reload; b.reload; c.reload
      a.element_order.should == 0
      c.element_order.should == 1
      b.element_order.should == 2
      c.move_up
      a.reload; b.reload; c.reload
      c.element_order.should == 0
      a.element_order.should == 1
      b.element_order.should == 2
      c.move_up
      a.reload; b.reload; c.reload
      c.element_order.should == 0
      a.element_order.should == 1
      b.element_order.should == 2
      a.move_up
      a.reload; b.reload; c.reload
      a.element_order.should == 0
      c.element_order.should == 1
      b.element_order.should == 2
    end

    it "should be able to move them down" do
      a=subject.create; b=subject.create; c=subject.create
      a.reload; b.reload; c.reload
      a.move_down
      a.reload; b.reload; c.reload
      b.element_order.should == 0
      a.element_order.should == 1
      c.element_order.should == 2
      a.move_down
      a.reload; b.reload; c.reload
      b.element_order.should == 0
      c.element_order.should == 1
      a.element_order.should == 2
      a.move_down
      a.reload; b.reload; c.reload
      b.element_order.should == 0
      c.element_order.should == 1
      a.element_order.should == 2
      b.move_down
      a.reload; b.reload; c.reload
      c.element_order.should == 0
      b.element_order.should == 1
      a.element_order.should == 2
    end

  end

  context "when we delete one" do
    it "should work just fine" do
      a=subject.create; b=subject.create; c=subject.create; d=subject.create
      a.reload; b.reload; c.reload; d.reload
      b.destroy
      a.reload; c.reload; d.reload
      a.move_down
      a.reload; c.reload; d.reload
      a.element_order.should be > c.element_order
      a.element_order.should be < d.element_order
      a.move_up
      a.reload; c.reload; d.reload
      a.element_order.should be < c.element_order
      a.element_order.should be < d.element_order
    end
  end

end

describe CoolerElement do
  subject { CoolerElement }
  before(:each){ CoolerElement.destroy_all}

  context "when adding first element" do
    it "always should  have order equal 0" do
      a = subject.new
      a.save
      a.element_order.should == 0    
    end
  end

  context "when we add second and third elements" do

    it "should be in a correct order" do
      a=subject.create; b=subject.create; c=subject.create
      a.reload; b.reload; c.reload
      c.element_order.should == 0
      b.element_order.should == 1
      a.element_order.should == 2
    end

    it "should return valid previous element" do
      a=subject.create; b=subject.create; c=subject.create
      a.reload; b.reload; c.reload
      c.previous.should == nil
      b.previous.should == c
    end

    it "should return valid next element" do
      a=subject.create; b=subject.create; c=subject.create
      a.reload; b.reload; c.reload
      a.next.should == nil
      b.next.should == a
      c.next.should == b
    end

    it "should be able to move them up" do
      a=subject.create; b=subject.create; c=subject.create
      a.reload; b.reload; c.reload
      a.move_up
      a.reload; b.reload; c.reload
      c.element_order.should == 0
      a.element_order.should == 1
      b.element_order.should == 2
      a.move_up
      a.reload; b.reload; c.reload
      a.element_order.should == 0
      c.element_order.should == 1
      b.element_order.should == 2
      a.move_up
      a.reload; b.reload; c.reload
      a.element_order.should == 0
      c.element_order.should == 1
      b.element_order.should == 2
      b.move_up
      a.reload; b.reload; c.reload
      a.element_order.should == 0
      b.element_order.should == 1
      c.element_order.should == 2
    end

    it "should be able to move them down" do
      a=subject.create; b=subject.create; c=subject.create
      a.reload; b.reload; c.reload
      c.move_down
      a.reload; b.reload; c.reload
      b.element_order.should == 0
      c.element_order.should == 1
      a.element_order.should == 2
      c.move_down
      a.reload; b.reload; c.reload
      b.element_order.should == 0
      a.element_order.should == 1
      c.element_order.should == 2
      c.move_down
      a.reload; b.reload; c.reload
      b.element_order.should == 0
      a.element_order.should == 1
      c.element_order.should == 2
      b.move_down
      a.reload; b.reload; c.reload
      a.element_order.should == 0
      b.element_order.should == 1
      c.element_order.should == 2
    end

  end

  context "when we delete one" do
    it "should work just fine" do
      a=subject.create; b=subject.create; c=subject.create; d=subject.create
      a.reload; b.reload; c.reload; d.reload
      b.destroy
      a.reload; c.reload; d.reload
      d.move_down
      a.reload; c.reload; d.reload
      d.element_order.should be > c.element_order
      d.element_order.should be < a.element_order
      d.move_up
      a.reload; c.reload; d.reload
      d.element_order.should be < c.element_order
      d.element_order.should be < a.element_order
    end
  end

end

describe WayCoolerElement do
  subject { WayCoolerElement }
  before(:each){ WayCoolerElement.destroy_all}

  context "when adding first child element" do

    it "always should  have order equal 0" do
      a = ''
      5.times {a = subject.create}
      a = a.children.create
      a.save
      a.element_order.should == 0
    end

  end

  context "when switching roots order" do

    it "should not interfere with children" do
      a = subject.create
      b = subject.create
      a.reload; b.reload
      a.element_order.should == 0
      b.element_order.should == 1
      aa = a.children.create
      ab = a.children.create
      ac = a.children.create
      ba = b.children.create
      bb = b.children.create
      bc = b.children.create
      a.reload; b.reload
      aa.reload; ab.reload; ac.reload;
      ba.reload; bb.reload; bc.reload;
      a.element_order.should == 0
      b.element_order.should == 1
      aa.element_order.should == 0
      ab.element_order.should == 1
      ac.element_order.should == 2
      ba.element_order.should == 0
      bb.element_order.should == 1
      bc.element_order.should == 2
      a.move_down
      a.reload; b.reload
      a.element_order.should == 1
      b.element_order.should == 0
      aa.reload; ab.reload; ac.reload;
      ba.reload; bb.reload; bc.reload;
      aa.element_order.should == 0
      ab.element_order.should == 1
      ac.element_order.should == 2
      ba.element_order.should == 0
      bb.element_order.should == 1
      bc.element_order.should == 2
    end

  end

  context "when changing root element" do
    it "should be last" do
      a = subject.create
      b = subject.create
      aa = a.children.create
      ab = a.children.create
      a.reload; b.reload; aa.reload; ab.reload
      aa.parent_id = nil
      aa.save
      a.reload; b.reload; aa.reload; ab.reload
      a.element_order.should == 0
      b.element_order.should == 1
      aa.element_order.should == 2
      ac = a.children.create
      a.reload; b.reload; aa.reload; ab.reload; ac.reload
      a.element_order.should == 0
      b.element_order.should == 1
      aa.element_order.should == 2
      ab.element_order.should == 1
      ac.element_order.should == 2
    end
  end

end

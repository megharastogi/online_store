require 'spec_helper'

describe Image do
  before(:each) do
    @image = Image.new
  end  
  
  it "should validate presence of content_type if filename is not blank" do
    @image = Image.new(:filename => "abc.png")
    @image.should validate_presence_of(:content_type)
  end  
  
  it "should validate presence of size if content_type is not blank" do
    @image = Image.new(:filename => "abc.png" ,:content_type =>"png")
    @image.should validate_presence_of(:size)
  end
  
  it "should belong to record" do
    @image.should belong_to(:record)
  end  
end

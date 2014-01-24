require 'spec_helper'

describe Serving do
  it "is invalid without a name" do
    expect(Serving.new(name: nil)).to have(1).errors_on(:name)
  end

  it "is invalid with negative day_order" do
    expect(Serving.new(day_order: -1)).to have(1).errors_on(:day_order)
  end
end

require 'rails_helper'

describe Collection do
  it { should belong_to :movie }
end
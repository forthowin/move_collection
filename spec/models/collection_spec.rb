require 'rails_helper'

describe Collection do
  it { should belong_to :movie }
  it { should belong_to :user }
end
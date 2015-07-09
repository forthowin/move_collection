require 'rails_helper'

describe Movie do
  it { should validate_presence_of :title }
  it { should validate_presence_of :format }
  it { should validate_presence_of :length }
  it { should validate_presence_of :release_year }

  it { should validate_length_of(:title).is_at_least(1).is_at_most(50) }
  it { should validate_inclusion_of(:format).in_array(%w(VHS DVD Streaming)) }
  it { should validate_inclusion_of(:length).in_range(1..500) }
  it { should validate_inclusion_of(:release_year).in_range(1800..2100) }
end
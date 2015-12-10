require 'rails_helper'

describe Comment do
 
  it { is_expected.to belong_to(:member) }
  it { is_expected.to belong_to(:ad) }

  it { is_expected.to validate_presence_of(:body) }

end

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    it 'returns correct supplied title' do
      expect(helper.full_title('Test Title')).to eq 'Test Title | Floworx SysArch'
    end

    it 'returns correct default title' do
      expect(helper.full_title).to eq 'Floworx SysArch'
    end
  end
end

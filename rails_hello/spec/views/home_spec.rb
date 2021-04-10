require 'rails_helper'

RSpec.describe "Homes", type: :system do
  describe 'GET /index' do
    it '「hello」'do
      get '/'
      expect(page).have_content 'HELLO'
    end
  end
end
require "rails_helper"

describe ListLinkHelpers do
  describe "#list_link_to" do
    it "adds class options" do
      expect(helper.list_link_to(:show, '/dummy', class: 'test')).to have_css('a.test')
    end
  end
end

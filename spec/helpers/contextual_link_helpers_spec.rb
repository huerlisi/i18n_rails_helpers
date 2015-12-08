require "rails_helper"

describe ContextualLinkHelpers do
  describe "#icon_link_to" do
    it "adds class options" do
      expect(helper.icon_link_to(:show, '/dummy', class: 'test')).to have_css('a.test')
    end
  end

  describe "#action_to_icon" do
    it "returns the action parameter if no action matches" do
      expect(helper.action_to_icon('unknown action')).to eq 'unknown action'
    end
  end

  describe "#contextual_links" do
    it "should work with block returning nil" do
      expect{
        helper.contextual_links('action') do
          nil
        end
      }.to_not raise_exception
    end
  end
end

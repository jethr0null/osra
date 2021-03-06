require 'rails_helper'

RSpec.describe 'layouts/_navigation.html.erb', type: :view do
  describe 'nav button count' do
    before :each do
      allow(view).to receive_message_chain(:request, :path, :=~).and_return(nil)
      allow(view).to receive_message_chain(:request, :path, :=~).
                  with(HqController::NAVIGATION_BUTTONS.sample[:path_regex]).
                  and_return(true)
      render
    end

    specify 'one higlighted' do
      assert_select 'div.no-horiz-padding>ul>li.active', {count: 1}
      assert_select 'div.no-horiz-padding>ul>li.dormant',
                    {count: (HqController::NAVIGATION_BUTTONS.count - 1)}
    end
  end

  describe 'buttons' do
    specify 'has glyph icon' do
      stub_const('HqController::NAVIGATION_BUTTONS', [
        { text: 'foobar', href: '"/pathname/file.extension"', path_regex: /baz/, glyph: 'lorem_ipsum' } ])
      render

      assert_select 'li' do
        assert_select 'span.glyphicon'
        assert_select 'span.lorem_ipsum'
      end
    end

    specify 'generates link from href code' do
      stub_const('HqController::NAVIGATION_BUTTONS', [
        { text: 'foobar', href: '"/pathname/file.extension".reverse', path_regex: /baz/, glyph: 'lorem_ipsum' } ])
      render

      assert_select 'a', href: 'noisnetxe.elif/emanhtap/', text: 'foobar'
    end
  end
end

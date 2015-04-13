require 'rails_helper'

feature 'Main page' do

  let(:today) { Date.today.strftime '%Y-%m-%d' }

  scenario 'visiting the main page' do
    visit '/'
    expect(page).to have_text(today)
  end
end

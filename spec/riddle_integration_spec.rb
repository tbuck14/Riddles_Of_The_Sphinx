require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create a riddle path', {:type => :feature}) do
  it('creates a riddle and then goes to the riddle page') do
    visit('/riddles')
    click_on('Add a new riddle')
    fill_in('name', :with => 'a clock ticks')
    fill_in('riddle', :with => 'how many times per minute does a clock tick?')
    fill_in('answer', :with => '6')
    click_on('Go!')
    expect(page).to have_content('a clock ticks')
    click_on('a clock ticks')
    expect(page).to have_content('how many times per minute does a clock tick?')
    expect(page).to have_content('6')
  end
end
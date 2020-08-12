copy_file "test/test_helper.rb", force: true
copy_file "test/support/capybara.rb"
copy_file "test/support/circleci.rb"
copy_file "test/support/mailer.rb"
copy_file "test/support/rails.rb"
copy_file "test/support/sidekiq.rb"
copy_file "test/support/shoulda_matchers.rb"
copy_file "test/system/layout_helper_test.rb"
empty_directory_with_keep_file "test/mailers"
empty_directory_with_keep_file "test/unit"
empty_directory_with_keep_file "test/unit/lib"
empty_directory_with_keep_file "test/unit/lib/tasks"

gsub_file "test/application_system_test_case.rb",
          ":chrome",
          '(ENV["HEADLESS_CHROME"] ? :headless_chrome : :chrome)'

insert_into_file "test/application_system_test_case.rb", <<RUBY, before: /^end/

  def setup
    Capybara.server = :puma, { Silent: true }
    super
  end
RUBY

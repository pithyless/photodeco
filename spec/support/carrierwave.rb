RSpec.configure do |config|
  config.after(:all) do
    # Get rid of uploaded images
    if Rails.env.test? || Rails.env.cucumber?
      FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/test"])
      FileUtils.rm_rf(Dir["#{Rails.root}/tmp/uploads/test"])
    end
  end
end

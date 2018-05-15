namespace :db do

  desc 'Truncate all tables, except schema_migrations (customizable)'
  task :truncate, [ :tables ] => 'db:load_config' do |t, args|
    args.with_defaults(tables: 'schema_migrations')

    skipped = args[:tables].split(' ')
    config  = ActiveRecord::Base.configurations[::Rails.env]

    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE #{table}") unless skipped.include?(table)
    end
  end

end

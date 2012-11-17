namespace :import do
  require 'csv'

  desc "Imports a CSV file into an ActiveRecord table"
  task :csv_model_import, [:filename, :model] => [:environment] do |task,args|
    infile = File.new(args[:filename]).read
    n, keys = 0, []

    CSV.parse(infile) do |line|
      n += 1
      if n == 1
        keys = line
        next
      end
      attributes = Hash[keys.zip line]
      puts Module.const_get(args[:model]).where(:id => attributes["id"]).first_or_create(attributes, :without_protection => true)
    end
  end
end
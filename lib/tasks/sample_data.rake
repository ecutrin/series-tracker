namespace :db do
    desc 'Prepare dev environment with test data'
    task test_data: [:drop, :create, :migrate, :seed, :populate_sample_data] do
	puts 'Test data is ready!'
    end

    desc 'Populate random TV series'
    task populate_sample_data: :environment do
	10.times do |iter| 
	   Serie.create!(title: "Title #{iter}", picture: "Picture #{iter}")
	end
    end
end

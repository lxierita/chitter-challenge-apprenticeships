require "pg"

class Peep 
	attr_reader :message, :date
	def initialize(message, date = '')
		@message = message
		@date = date
	end
	def self.all 
		if (ENV["ENVIRONMENT"] == 'test')
			connection = PG.connect(dbname: 'chitter')
		else 
			connection = PG.connect(dbname: 'chitter_test')
		end
		result = connection.exec("SELECT * FROM peeps;")
		result.map { |peep| Peep.new(message: peep['message']) }
	end
end
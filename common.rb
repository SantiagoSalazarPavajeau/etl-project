require 'csv'
require 'awesome_print'

class CSVSource
    def initialize(filename:)
        @filename = filename
    end

    def each
        csv = CSV.open(@filename, headers: true)
        csv.each do |row| # load into kiba row by row
            yield(row.to_hash)
        end
        csv.close
    end

end

def add_years!
    transform do |row|
        ap row
        row
    end
end    

def limit(x)
    x = Integer(x || -1)
    return if x == -1
    transform do |row|
        @counter ||= 0
        @counter += 1
        abort("Stopping...") if @counter > x
        row
    end
end
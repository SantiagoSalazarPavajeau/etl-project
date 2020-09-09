

source CSVSource, filename: 'income-statement.csv'

transform AggregateCosts do |row|
    row[:revenue].delete
end

destination InsertToDatabase, db_config, table: 'income-statement'

# bundle exec kiba etl-kaigi.etl

require 'csv'

class CSVSource
    def initialize(filename:)
        @filename = filename
    end

    def each
        csv = CSV.open(@filename, headers: true)
        csv.each do |row|
            yield(row.to_hash)
        end
        csv.close
    end

end

class AggregateCosts

    def initialize(from:, to:, format:)
        @from, @to = from, to
        @format = format
    end

    def process(row)
        row[@to] = Date.strptime(row[@from], @format)
        row
    end

end


class InsertToDatabase

    def initialize(output_file)
        @csv = CSV.open(output_file, 'w')
        @headers_written = false
    end

    def write(row)
        unless @headers_written
            @headers_written = true
            @csv << row.keys
        end
        @csv << row.values
    end

    def close
        @csv.close
    end

end
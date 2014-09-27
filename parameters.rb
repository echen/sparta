module Parameters
    def Parameters.values
        [
            {
                "name" => "start_date",
                "type" => "date",
                "default" => 2.weeks.ago.to_date.to_s,
                "props" => {:max => 1.day.ago.to_date.to_s},
            },
            {
                "name" => "end_date",
                "type" => "date",
                "default" => 1.day.ago.to_date.to_s,
                "props" => {:max => 1.day.ago.to_date.to_s},
            }
        ]
    end

    def Parameters.defaults
        Hash[values.map { |param| [param["name"], param["default"]] }]
    end
end

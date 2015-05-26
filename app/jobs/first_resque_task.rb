class FirstResqueTask
  @queue = :simple

  def self.perform( input_path, output_path, substr )
    File.open( output_path , 'w') do | new_file |
      File.foreach( input_path ) do | str | 
        new_file.write( str ) if str.include? substr
      end
    end
    puts "Done!"
  end

end

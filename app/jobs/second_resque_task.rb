class SecondResqueTask
  include Resque::Plugins::Status

  def perform
    File.open(options['output_path'] , 'w') do |new_file|
      File.foreach(options['input_path']) do |str| 
        new_file.write(str) if str.include? options['substr']
      end
    end
    sleep 10 
    puts "Done! with status"
  end

end

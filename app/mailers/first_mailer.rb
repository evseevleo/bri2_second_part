class FirstMailer < ActionMailer::Base
  default from: "resque@rails.tasks"

  def mail_last_task( e_addr, result_file_path, initial_file_path = nil  )
    @e_addr = e_addr
    attachments['last_task_results.txt'] = File.read( result_file_path )
    attachments['last_task_initial_file.txt'] = File.read( initial_file_path ) unless initial_file_path.nil?

    mail to: 'misterfishy0@gmail.com', subject: 'Task was completed'
  end

end

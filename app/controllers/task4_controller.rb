# encoding: UTF-8

require 'csv'

class Task4Controller < ApplicationController

  def index
  end

  # Используется в заданиях 4 и 5
  def ask
   return Rubric.
      joins(:products).
      select('rubrics.title, count(*) AS products_count'  ).
      where("products.name LIKE '%Молоко%' AND rubrics.id IS NOT NULL").
      group('rubrics.title').
      order('products_count DESC')
  end

  #Задание 4 - исполнение sql средствами ActiveRecord
  def show
    @result = ask
  end


  # Задание 5 - отправка результатов sql запроса в виде csv файла клиенту
  def ask_file

    @query_result = ask
    CSV.open("tmp/task6.csv", "wb") do |csv|
      @query_result.each do | row |
        csv << [ row.title.to_s, row.products_count.to_s ]
      end
    end
    send_file("tmp/task6.csv",
              filename: "task6.csv",
              type: "text/csv")
  end

  # задание 6 - формируется джоб для рескью, отправляется письмо с результатом
  def ask_file_resque
    @input_file = '/home/yevseyev/resc1_initial.txt'
    @output_file = "#{Rails.root}/tmp/resc1_result.txt"

    #4 args - job, input_path, output_path and string(what we try to find)
    Resque.enqueue FirstResqueTask, @input_file, @output_file, 'blahblah'
    sleep 3
    FirstMailer.mail_last_task( 'johnduckdoe@gmail.ru', @output_file, @input_file  ).deliver
    File.delete( @output_file )
    redirect_to :back
  end


  # Экшн для допзадания - пока не работает, как надо
  def ask_file_resque_with_status
    @input_file = '/home/yevseyev/resc1_initial.txt'
    @output_file = "#{Rails.root}/tmp/resc1_result.txt"

    @job_id =  SecondResqueTask.create( 
      input_path: @input_file, 
      output_path: @output_file, 
      substr: 'blahblah')


    FirstMailer.mail_last_task( 'evseevleo@rambler.ru', @output_file, @input_file  ).deliver

    redirect_to :back
  end

end

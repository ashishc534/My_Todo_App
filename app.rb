require 'sinatra'

class Todo
	attr_accessor :task , :done , :urgent , :important 

	def initialize (task_name,urgent,important)
		@task = task_name
		@done = false
		@urgent = urgent
		@important = important
	end
end

array = []

get '/' do
	data = Hash.new
	data[:array] = array

	erb :default_page , locals: data
end

post '/add' do
	task_name = params['task']
	urgent = params['urgent']
	important = params['important']

	obj = Todo.new(task_name,urgent,important)
	array.push(obj)

	return redirect '/'
end

post '/done' do
	task_name = params['task']
	array.each do|val|
		if task_name==val.task
			val.done = !val.done
		end
	end
	return redirect '/'
end

post '/remove' do
	task_name = params['task']
	array.each do|val|
		if task_name == val.task
			val.task = nil
		end
	end
	return redirect '/'
end
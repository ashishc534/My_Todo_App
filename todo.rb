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
count = []

get '/' do
	data = Hash.new
	data[:array] = array

	erb :homepage , locals: data
end

post '/add' do
	task_name = params['task']
	urgent = params['urgent']
	important = params['important']

	if count.include?(task_name) == false
		obj = Todo.new(task_name,urgent,important)
		array.push(obj)
		count.push(task_name)
		return redirect '/'
	else
		return redirect '/'
	end
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
			count.delete(task_name)
		end
	end
	return redirect '/'
end

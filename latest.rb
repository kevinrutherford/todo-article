
class TodoList
  def initialize
    @tasks = []
    @skip_counts = []
    @current_task_index = 0
  end

  def append_task(description)
    @tasks << description
    @skip_counts << 0
  end

  def current_task_description
    @tasks[@current_task_index]
  end

  def delete_current_task
    edit_task_list do
      @tasks.delete_at(@current_task_index)
      @skip_counts.delete_at(@current_task_index)
    end
  end

  def empty?
    @tasks.length == 0
  end

  def skip_current
    edit_task_list do
      @skip_counts[@current_task_index] = @skip_counts[@current_task_index] + 1
      if (@skip_counts[@current_task_index] == 3)
        puts "Too many skips; deleting - " + current_task_description
        delete_current_task
      else
        @current_task_index = @current_task_index + 1
      end
    end
  end

  def to_s
    @tasks.join("\n")
  end

private
  def edit_task_list(&blk)
    blk.call unless @tasks.empty?
    @current_task_index = 0 if @current_task_index >= @tasks.length
  end
end

TODO_LIST = TodoList.new

def next_command
  print "TODO> "
  STDOUT.flush
  return gets.chomp
end

def execute(command, arg)
  case command
  when '', nil
    # do nothing
  when 'quit'
    return false
  when 'todo'
    TODO_LIST.append_task(arg)
  when 'done'
    TODO_LIST.delete_current_task
  when 'skip'
    TODO_LIST.skip_current
  when 'list'
    puts TODO_LIST
    puts unless TODO_LIST.empty?
  else
    puts "Unknown command. Commands: todo, done, skip, list, or quit"
  end
  return true
end

loop do
  line = next_command
  words = line.split(' ', 2)
  execute(words[0], words[1]) or break
  puts ("Current: " + TODO_LIST.current_task_description) unless TODO_LIST.empty?
end

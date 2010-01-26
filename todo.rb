
t = []          # tasks
skp = []        # skip count for each task
c = 0           # index of current task

print "TODO> "
STDOUT.flush
line = gets.chomp

while (!(line == "quit"))
  rest = line.sub(/[^ ]+ /, '')   # remove command from front of line

  case line
  when /^todo/
    t << rest
    skp << 0

  when /^done/
    if (t.length > 0)
      t.delete_at(c)
      skp.delete_at(c)
      c = 0 if c >= t.length      
    end
    
  when /^skip/
    if (t.length > 0)
      skp[c] = skp[c] + 1
      
      if (skp[c] == 3) 
        puts "Too many skips; deleting - " + t[c]
        t.delete_at(c)
        skp.delete_at(c)
        c = 0 if c >= t.length
      else
        c = (c + 1).modulo t.length  
      end
      
    end
    
  when /^list/
    puts t
    puts
    
  when /^$/
    # do nothing
    
  else
    puts "Unknown command. Commands: todo, done, skip, list, or quit"
  end 
  
  if (t.length > 0)
    puts "Current: " + t[c]
  end
  
  print "TODO> "
  STDOUT.flush
  line = gets.chomp
end


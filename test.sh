ruby todo.rb <empty_test.in >empty_test.out
diff empty_test.out empty_test.master
ruby todo.rb <todo_test.in >todo_test.out
diff todo_test.out todo_test.master

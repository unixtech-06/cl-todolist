;; Define global variables for todo-list and task details
(defvar *todo-list* '())
(defvar *title* nil)
(defvar *date* nil)
(defvar *description* nil)

;; Define a type for tasks using Common Lisp's type system
(deftype task ()
  '(cons (string :title)
         (string :date)
         (string :description)))

;; Function to add a task to the todo list
(defun add-task (title date description)
  "Add a task to the todo list."
  (push (list title date description) *todo-list*))

;; Function to save the todo list to a file
(defun save-todo-list ()
  "Save the todo list to a file."
  (with-open-file (stream "~/.config/common-lisp-todo.txt"
                           :direction :output
                           :if-exists :supersede)
    (dolist (task *todo-list*)
      (format stream "~A - ~A - ~A~%"
              (first task) (second task) (third task)))))

;; Function to add a task to the todo list based on user input
(defun add-task-from-user-input ()
  "Prompt the user for task information and add it to the todo list."
  (format t "Enter task title: ")
  (force-output)
  (setf *title* (read-line))
  (format t "Enter task date: ")
  (force-output)
  (setf *date* (read-line))
  (format t "Enter task description: ")
  (force-output)
  (setf *description* (read-line))
  ;; Add the task to the todo list and save
  (add-task *title* *date* *description*)
  (save-todo-list))

;; Main entry point for the program
(defun main ()
  "Main entry point for the program."
  (format t "Adding a task to the todo list.~%")
  ;; Accept user input and add task to the list
  (add-task-from-user-input)
  (format t "Task added to the todo list and saved.~%"))

;; Call the main function to set initial data
;; (main) -- Commented out to avoid immediate execution during build


(defvar *todo-list* '())

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
                           :if-exists :append  ; Use :append to append to an existing file
                           :if-does-not-exist :create)  ; Ensure the directory and file are created
    (dolist (task *todo-list*)
      (format stream "~A - ~A - ~A~%"
              (first task) (second task) (third task)))
    (terpri stream)))  ; Add a newline at the end of the file

;; Function to add a task to the todo list based on user input
(defun add-task-from-user-input ()
  "Prompt the user for task information and add it to the todo list."
  (format t "Enter task title: ")
  (force-output)
  (let ((title (read-line)))
    (format t "Enter task date: ")
    (force-output)
    (let ((date (read-line)))
      (format t "Enter task description: ")
      (force-output)
      (let ((description (read-line)))
        ;; Add the task to the todo list
        (add-task title date description)))))

;; Main entry point for the program
(defun main ()
  "Main entry point for the program."
  (format t "Adding a task to the todo list.~%")
  ;; Accept user input and add task to the list
  (add-task-from-user-input)
  ;; Save the todo list and append to the file
  (save-todo-list)
  (format t "Task added to the todo list and saved.~%"))

;; Call the main function to set initial data
;;(main)


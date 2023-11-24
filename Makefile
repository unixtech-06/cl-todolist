CC = sbcl
SRC_DIR = src
BIN_DIR = ./bin
OUT_FILE = $(BIN_DIR)/todo-list

all: $(OUT_FILE)

$(OUT_FILE): $(SRC_DIR)/main.lisp | $(BIN_DIR)
	$(CC) --noinform --no-sysinit --no-userinit \
		--eval "(load \"$<\")" \
		--eval "(sb-ext:save-lisp-and-die \"$@\" :toplevel #'main :executable t)"

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

clean:
	rm -rf $(BIN_DIR)


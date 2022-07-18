在 Linux 上编译，用的 stable-gnu 工具链，如果在 Windows 或其他系统编译，
则把 test.el 里面的 module-load 路径改一下。

用 Emacs 打开 test.el，执行里面的函数定义后，调用三个测试函数，分别是

1. `test-dymod-wait3-builtin` 会立刻插入函数名，等待3秒后在 minibuffer 中输出函数名，期间光标可以自由移动。这个函数调用的是内置的 sleep-for。
2. `test-dymod-wait3-common` 会立刻插入函数名，等待3秒后在 minibuffer 中输出函数名，期间光标不能移动。这个函数调用了 Rust 中的 `wait3` 函数。
3. `test-dymod-wait3-thread` 会立刻插入函数名 + in emacs 字样，等待3秒插入函数名 + in rust字样，同时 minibuffer 中输出函数名，期间光标不能移动。这个函数调用了 Rust 中的 `wait3_thread` 函数。由于 `wait3_thread` 里面 sleep 是在一个子线程里执行的，按照预期 函数名 + in rust 字样也应当立刻被插入。

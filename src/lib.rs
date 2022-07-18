use emacs::{defun, IntoLisp};

emacs::plugin_is_GPL_compatible!();

#[emacs::module(name = "example-dymod")]
fn init(_: &emacs::Env) -> emacs::Result<()> {
    Ok(())
}

#[defun(name = "-wait3")]
fn wait3(env: &emacs::Env) -> emacs::Result<()> {
    use std::time::Duration;
    use std::thread::sleep;
    sleep(Duration::from_secs(3));
    Ok(())
}


#[defun(name = "-wait3-thread")]
fn wait3_thread(env: &emacs::Env) -> emacs::Result<()> {
    use std::time::Duration;
    use std::thread::{spawn, sleep};
    let t = spawn(|| sleep(Duration::from_secs(3)));
    env.call("insert", ("test-dymod-wait3-thread in rust",));
    t.join().unwrap();
    Ok(())
}

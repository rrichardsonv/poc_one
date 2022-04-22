use deno_core::v8;
use deno_core::serde_v8;
use deno_core::JsRuntime;
use deno_core::RuntimeOptions;
use rustler::{Env, NifResult, Term};
use serde_rustler::{to_term};

#[rustler::nif]
fn js<'a>(
    env: Env<'a>,
    code: &str
) -> NifResult<Term<'a>> {
  let mut context = JsRuntime::new(RuntimeOptions::default());
  let global_var = context.execute_script("<anon>", code).expect("Error in script");
  let mut scope = context.handle_scope();
  let value = global_var.open(&mut scope);
  let value_str = value.to_rust_string_lossy(&mut scope);
  to_term(env, value_str).map_err(|err| err.into())
}


rustler::init!("Elixir.PocOne.Deno", [js]);

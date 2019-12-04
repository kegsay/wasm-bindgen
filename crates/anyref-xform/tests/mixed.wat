;; @xform import "" "a" (other anyref_borrowed other anyref_owned other)

(module
  (import "" "a" (func $a (param f32 i32 i64 i32 i32)))
  (func (export "foo")
    f32.const 1
    i32.const 2
    i64.const 3
    i32.const 4
    i32.const 5
    call $a)
  (func $alloc (export "__anyref_table_alloc") (result i32)
    i32.const 0)
  (func $dealloc (export "__anyref_table_dealloc") (param i32))
)

(; CHECK-ALL:
(module
  (type (;0;) (func))
  (type (;1;) (func (param i32)))
  (type (;2;) (func (param f32 i32 i64 i32 i32)))
  (type (;3;) (func (param f32 anyref i64 anyref i32)))
  (import "" "a" (func $a (type 3)))
  (func $a anyref shim (type 2) (param f32 i32 i64 i32 i32)
    local.get 0
    local.get 1
    table.get 0
    local.get 2
    local.get 3
    table.get 0
    local.get 3
    call $dealloc
    local.get 4
    call $a)
  (func (;2;) (type 0)
    f32.const 0x1p+0 (;=1;)
    i32.const 2
    i64.const 3
    i32.const 4
    i32.const 5
    call $a anyref shim)
  (func $dealloc (type 1) (param i32))
  (table (;0;) 32 anyref)
  (export "foo" (func 2)))
;)

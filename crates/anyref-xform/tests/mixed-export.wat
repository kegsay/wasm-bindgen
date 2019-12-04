;; @xform export "a" (other anyref_borrowed other anyref_owned other)

(module
  (func $a (export "a") (param f32 i32 i64 i32 i32))
  (func $alloc (export "__anyref_table_alloc") (result i32)
    i32.const 0)
  (func $dealloc (export "__anyref_table_dealloc") (param i32))
)

(; CHECK-ALL:
(module
  (type (;0;) (func (result i32)))
  (type (;1;) (func (param f32 i32 i64 i32 i32)))
  (type (;2;) (func (param f32 anyref i64 anyref i32)))
  (func $a anyref shim (type 2) (param f32 anyref i64 anyref i32)
    (local i32 i32)
    global.get 0
    i32.const 1
    i32.sub
    local.tee 5
    global.set 0
    local.get 0
    local.get 5
    local.get 1
    table.set 0
    local.get 5
    local.get 2
    call $alloc
    local.tee 6
    local.get 3
    table.set 0
    local.get 6
    local.get 4
    call $a
    local.get 5
    ref.null
    table.set 0
    local.get 5
    i32.const 1
    i32.add
    global.set 0)
  (func $alloc (type 0) (result i32)
    i32.const 0)
  (func $a (type 1) (param f32 i32 i64 i32 i32))
  (table (;0;) 32 anyref)
  (global (;0;) (mut i32) (i32.const 32))
  (export "a" (func $a anyref shim)))
;)

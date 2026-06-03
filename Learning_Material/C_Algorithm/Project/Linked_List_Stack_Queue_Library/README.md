# Project 4：Linked List / Stack / Queue Library

## Scope

實作 linked list、stack、queue，強化 node ownership、empty list、single node、pointer-to-pointer 與 API design。

## Expected Modules

```text
src/list.c
src/stack.c
src/queue.c
include/list.h
include/stack.h
include/queue.h
test/test_list.c
test/test_stack_queue.c
```

## Validation

empty、single-node、multi-node、invalid input、repeated push/pop cases pass；valgrind 無 leak。

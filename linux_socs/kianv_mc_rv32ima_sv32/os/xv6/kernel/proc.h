// Saved registers for kernel context switches.
struct context {
  uint32 ra;
  uint32 sp;

  // callee-saved
  uint32 s0;
  uint32 s1;
  uint32 s2;
  uint32 s3;
  uint32 s4;
  uint32 s5;
  uint32 s6;
  uint32 s7;
  uint32 s8;
  uint32 s9;
  uint32 s10;
  uint32 s11;
};

// Per-CPU state.
struct cpu {
  struct proc *proc;          // The process running on this cpu, or null.
  struct context context;     // swtch() here to enter scheduler().
  int noff;                   // Depth of push_off() nesting.
  int intena;                 // Were interrupts enabled before push_off()?
};

extern struct cpu cpus[NCPU];

// per-process data for the trap handling code in trampoline.S.
// sits in a page by itself just under the trampoline page in the
// user page table. not specially mapped in the kernel page table.
// uservec in trampoline.S saves user registers in the trapframe,
// then initializes registers from the trapframe's
// kernel_sp, kernel_hartid, kernel_satp, and jumps to kernel_trap.
// usertrapret() and userret in trampoline.S set up
// the trapframe's kernel_*, restore user registers from the
// trapframe, switch to the user page table, and enter user space.
// the trapframe includes callee-saved user registers like s0-s11 because the
// return-to-user path via usertrapret() doesn't return through
// the entire kernel call stack.
struct trapframe {
  /*   0 */ uint32 kernel_satp;   // kernel page table
  /*   8 */ uint32 kernel_sp;     // top of process's kernel stack
  /*  16 */ uint32 kernel_trap;   // usertrap()
  /*  24 */ uint32 epc;           // saved user program counter
  /*  32 */ uint32 kernel_hartid; // saved kernel tp
  /*  40 */ uint32 ra;
  /*  48 */ uint32 sp;
  /*  56 */ uint32 gp;
  /*  64 */ uint32 tp;
  /*  72 */ uint32 t0;
  /*  80 */ uint32 t1;
  /*  88 */ uint32 t2;
  /*  96 */ uint32 s0;
  /* 104 */ uint32 s1;
  /* 112 */ uint32 a0;
  /* 120 */ uint32 a1;
  /* 128 */ uint32 a2;
  /* 136 */ uint32 a3;
  /* 144 */ uint32 a4;
  /* 152 */ uint32 a5;
  /* 160 */ uint32 a6;
  /* 168 */ uint32 a7;
  /* 176 */ uint32 s2;
  /* 184 */ uint32 s3;
  /* 192 */ uint32 s4;
  /* 200 */ uint32 s5;
  /* 208 */ uint32 s6;
  /* 216 */ uint32 s7;
  /* 224 */ uint32 s8;
  /* 232 */ uint32 s9;
  /* 240 */ uint32 s10;
  /* 248 */ uint32 s11;
  /* 256 */ uint32 t3;
  /* 264 */ uint32 t4;
  /* 272 */ uint32 t5;
  /* 280 */ uint32 t6;
};

enum procstate { UNUSED, USED, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };

// Per-process state
struct proc {
  struct spinlock lock;

  // p->lock must be held when using these:
  enum procstate state;        // Process state
  void *chan;                  // If non-zero, sleeping on chan
  int killed;                  // If non-zero, have been killed
  int xstate;                  // Exit status to be returned to parent's wait
  int pid;                     // Process ID

  // wait_lock must be held when using this:
  struct proc *parent;         // Parent process

  // these are private to the process, so p->lock need not be held.
  uint32 kstack;               // Virtual address of kernel stack
  uint32 sz;                   // Size of process memory (bytes)
  pagetable_t pagetable;       // User page table
  struct trapframe *trapframe; // data page for trampoline.S
  struct context context;      // swtch() here to run process
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;           // Current directory
  char name[16];               // Process name (debugging)
};

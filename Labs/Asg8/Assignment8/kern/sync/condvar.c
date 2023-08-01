#include <stdio.h>
#include <condvar.h>
#include <kmalloc.h>
#include <assert.h>

void     
cond_init (condvar_t *cvp) {
//================your code=====================
    sem_init(&(cvp->sem),0);

}

// Unlock one of threads waiting on the condition variable. 
void 
cond_signal (condvar_t *cvp) {
//================your code=====================
    up(&(cvp->sem));
    
}

void
cond_wait (condvar_t *cvp,semaphore_t *mutex) {
//================your code=====================
    up(mutex);
    down(&(cvp->sem));
    down(mutex);

}

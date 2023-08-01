#include <stdio.h>
#include <unistd.h>

int main(){
int pid;
pid=fork();
if (pid>0){
   printf("Parent PID=%d, Child PID=%d\n", getpid(), pid);
   while(1){
   }
}
else{
   
}
return 0;
}

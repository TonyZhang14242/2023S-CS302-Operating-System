/*dad_mem_mutex.c*/
#include <string.h>
#include <fcntl.h>
#include <time.h> 
#include <sys/stat.h>

#include <pthread.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

int fd = 0;
int cond_signal = 0;
int milk;

int you_drink = 0;
int dad_drink = 0;

int check_fridge(){
	fd=open("fridge", O_CREAT|O_RDWR|O_APPEND, 0777);
	milk = lseek(fd,0,SEEK_END);
	//printf("checked:%d\n", milk);
	close(fd);
	return milk;
}

void take_milk(){
	fd = open("fridge", O_CREAT|O_RDWR|O_TRUNC , 0777);
	close(fd);
	fd= open("fridge", O_CREAT|O_RDWR|O_APPEND, 0777);
	write(fd, "milk", milk-1);
	milk--;
	close(fd);
}

void buy_milk(char who[]){
	printf("%s is going to buy milk.\n", who);
	fd=open("fridge", O_CREAT|O_RDWR|O_APPEND, 0777);
	write(fd, "milk", 5);
	milk = 5;
	close(fd);
}

void *mom(){
	sleep(rand()%2+1);
	while (1){
		pthread_mutex_lock(&mutex);
		while(check_fridge()>0){
			pthread_cond_wait(&cond, &mutex);//wait for cond_signal and unlock mutex
		}//question 2
		buy_milk("mom");
		pthread_mutex_unlock(&mutex);
	}
}

void *sister(){
	sleep(rand()%2+1);
	while (1){
		pthread_mutex_lock(&mutex);
		while(check_fridge()>0){
			pthread_cond_wait(&cond, &mutex);//wait for cond_signal and unlock mutex
		}//question 2
		buy_milk("sister");
		pthread_mutex_unlock(&mutex);
	}
}

void *you(){
	sleep(rand()%2+1);
	while (1){
		pthread_mutex_lock(&mutex);
		int num=check_fridge();
		
		if(num > 0){
			take_milk();
			you_drink++;
			printf("You takes milk for %d times\n", you_drink);
			if(you_drink>=30){
			exit(0);}
		}
		else{
			pthread_cond_signal(&cond);
		}
		pthread_mutex_unlock(&mutex);
	}
}

void *dad(){
	sleep(rand()%2+1);
	while (1){
		pthread_mutex_lock(&mutex);
		int num=check_fridge();
		
		if(num > 0){
			take_milk();
			dad_drink++;
			printf("Dad takes milk for %d times\n", dad_drink);
			if(dad_drink>=30){
			exit(0);}
		}
		else{
			pthread_cond_signal(&cond);
		}
		pthread_mutex_unlock(&mutex);
	}
}

int main(int argc, char * argv[]){
    srand(time(0));
    pthread_t p1, p2, p3, p4;
    int fd = open("fridge", O_CREAT|O_RDWR|O_TRUNC , 0777);  //empty the fridge
    close(fd);
    // Create two threads (both run func)  
    pthread_create(&p1, NULL, mom, NULL); 
    pthread_create(&p2, NULL, dad, NULL); 
    pthread_create(&p3, NULL, you, NULL); 
    pthread_create(&p4, NULL, sister, NULL); 
  
  
    // Wait for the threads to end. 
    pthread_join(p1, NULL); 
    pthread_join(p2, NULL); 
     pthread_join(p3, NULL); 
    pthread_join(p4, NULL); 


}






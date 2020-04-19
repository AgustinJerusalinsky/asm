#include<sys/syscall.h>
#include <unistd.h>
int main(){
	unsigned char string[8];
	string[0]='h';
	string[1]='i';
	string[2]=0;
	syscall(SYS_write, 1, string, 3);

}

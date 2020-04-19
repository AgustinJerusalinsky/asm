void exit();
int intToString(char * buffer, int numero);
int print(const char * buffer);
void nprint(char * buffer, int size);
int strlen(char * buffer);
int factorial(int num);
void swap( void * dir1, void * dir2, int size);
void integerRecursiveBubbleSort(int * arr, int size);

//flags
#define	O_RDONLY	0x0000		/* open for reading only */
#define	O_WRONLY	0x0001		/* open for writing only */
#define	O_RDWR		0x0002		/* open for reading and writing */
#define	O_APPEND	0x400		/* set append mode */
#define	O_CREAT		0x40		/* create if nonexistant */
#define	O_EXCL		0x80	/* error if already exists */

int fopen(char * path, int flags);
int fclose(int fd);
int fread(int fd, void *buf, int count);
int fwrite(int fd, void *buf, int count);
int fprintf(int fd, int buffSize, char * format,...);
int printf(char * format,...);

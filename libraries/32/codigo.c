//flags
#define	O_WRONLY	0x0001		/* open for writing only */
#define	O_APPEND	0x0008		/* set append mode */

int strlen(char * buffer);
int fopen(char * path, int flags);
int fclose(int fd);
int fwrite(int fd, void *buf, int count);



int main(){
    int fd = fopen("file.txt",O_WRONLY | O_APPEND);
    fwrite(fd,"esta es la linea nueva",strlen("esta es la linea nueva"));
    fclose(fd);
    return 0;
}
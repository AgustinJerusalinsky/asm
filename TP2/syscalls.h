
//Cerrar un programa
unsigned int sys_close(unsigned int fd);
//Leer de un file descriptor
unsigned int sys_read(unsigned int fd, char * buffer, size_t count);
//Escribir a un file descriptor (ya implementado)
unsigned int sys_write(unsigned int fd, const char * buffer, size_t count);
//Abrir un archivo y cerrarlo
unsigned int sys_open(unsigned int fd, int flags, int mode);


#include "Driver.h"

//void tester(int para);
extern "C" void tester(int para);
//void movMem32(int dest,char val);
extern "C" void movMem32(int dest,char val);

extern int test_func();
int io_load_eflags();
void io_store_eflags(int eflags);


void sys_main();

extern void init_pic(void);

void sys_main()//Entry Point
{
	mov_32b((void*)0xb8000,'*');
	for(int j=0;j<MAX_COLS;j++)
		print_char(j,j,3,0);
	for(int i=0;i<MAX_COLS;i++)
		print_char(i+'A',i,8,0);
	init_pic();
	int tmp=test_func();
	//io_hlt();
	return;
}

void testing_func()
{
	char* vm=(char*)0xb8000;
	*vm='L';
	return;
}

int paintX(int para1)//For Test Purpose
{
char* video_memory = (char*)0xb8000;
*video_memory = 'X';
//io_hlt();
tester(para1);
movMem32(0x4500,0xef);
return 0xabcd;
}





#include "libasm.h"
#include "libasm_tester.h"

static void    test_speed(ssize_t (*f)(int, void *, size_t))
{
	struct	timespec	start_time, end_time;
	double	elapsed_time, average_elapsed_time;
	double	total_elapsed_time = 0.00;

    int     fd = -1;
    char    buffer[4096];
    bzero(buffer, sizeof(buffer));

    fd = open("Makefile", O_RDONLY);
    if (fd == -1) return ;

	for (int i = 0; i < 1000; ++i)
		f(fd, buffer, sizeof(buffer) - 1);

    close(fd);
    fd = open("Makefile", O_RDONLY);
    if (fd == -1) return ;

	for (int i = 0; i < 5000; ++i)
	{
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		f(fd, buffer, sizeof(buffer) - 1);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;
	}

    close(fd);

	average_elapsed_time = total_elapsed_time / 500;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
}

void    test_ft_read()
{
    printf("%sTest_ft_read%s\n", YELLOW, RESET_COLOR);

    test_speed(read);
    test_speed(ft_read);

    printf("\n");
}
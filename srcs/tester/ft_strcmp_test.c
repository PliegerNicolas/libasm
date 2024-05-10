#include "libasm.h"
#include "libasm_tester.h"

static void    test_speed(const char *s1, const char *s2, int (*f)(const char *, const char *))
{
	struct	timespec	start_time, end_time;
	double	elapsed_time, average_elapsed_time;
	double	total_elapsed_time = 0.00;

	for (int i = 0; i < 500; ++i)
		f(s1, s2);

	for (int i = 0; i < 1000; ++i)
	{
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		f(s1, s2);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;
	}

	average_elapsed_time = total_elapsed_time / 500;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
}

void    test_ft_strcmp()
{
    printf("%sTest_ft_strcmp%s\n", YELLOW, RESET_COLOR);

    test_speed("Skrattar du, förlorar du, mannen !", "abc", strcmp);
    test_speed("Skrattar du, förlorar du, mannen !", "abc", ft_strcmp);

    printf("\n");
}
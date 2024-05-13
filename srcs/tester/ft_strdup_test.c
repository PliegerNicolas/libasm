#include "libasm.h"
#include "libasm_tester.h"

static void    ft_test_speed(const char *s, char *(*f)(const char *))
{
	struct	timespec	start_time, end_time;
	double	elapsed_time, average_elapsed_time;
	double	total_elapsed_time = 0.00;

	char	*s_ret = NULL;

	for (int i = 0; i < 500; ++i)
	{
		s_ret = f(s);
		if (!s_ret)
			return ;
		free(s_ret);
		s_ret = NULL;
	}

	for (int i = 0; i < 5000; ++i)
	{
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		s_ret = f(s);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;

		if (!s_ret)
			return ;
		free(s_ret);
		s_ret = NULL;
	}

	average_elapsed_time = total_elapsed_time / 500;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
}

static void	test_speed_comparisons()
{
	char	*s_src = NULL;

	printf("%sTest_speed_comparisons%s\n", GREEN, RESET_COLOR);

	printf("%sEmpty%s\n", BLUE, RESET_COLOR);
	s_src = "";
	ft_test_speed(s_src, strdup);
	ft_test_speed(s_src, ft_strdup);

	printf("%sReally short%s\n", BLUE, RESET_COLOR);
	s_src = ".";
	ft_test_speed(s_src, strdup);
	ft_test_speed(s_src, ft_strdup);

	printf("%sShort%s\n", BLUE, RESET_COLOR);
	s_src = "A short string.";
	ft_test_speed(s_src, strdup);
	ft_test_speed(s_src, ft_strdup);

	printf("%sMedium%s\n", BLUE, RESET_COLOR);
	s_src = "A Medium using SSE loop once.";
	ft_test_speed(s_src, strdup);
	ft_test_speed(s_src, ft_strdup);

	printf("%sLong%s\n", BLUE, RESET_COLOR);
	s_src = "With such long strings normally SSE loop should be utilized more than once and provide good performance. Let's see if it's true ...";
	ft_test_speed(s_src, strdup);
	ft_test_speed(s_src, ft_strdup);

	printf("%sreally Long%s\n", BLUE, RESET_COLOR);
	s_src = "Well. I don't know what I should write to get to 256 bytes but guess we're almost there ? Oh no. That was 90, we're gonna have to fill this in with random things again. 169 now ? Nice. Pity we're not planning to reach 420. We're aiming for 256 and hop !!!";
	ft_test_speed(s_src, strdup);
	ft_test_speed(s_src, ft_strdup);
}

void    test_ft_strdup()
{
    printf("%sTest_ft_strdup%s\n", YELLOW, RESET_COLOR);

	test_speed_comparisons();

    printf("\n");
}
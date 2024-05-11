#include "libasm.h"
#include "libasm_tester.h"

static void    ft_test_speed(const char *s, size_t (*f)(const char *))
{
	struct	timespec	start_time, end_time;
	double	elapsed_time, average_elapsed_time;
	double	total_elapsed_time = 0.00;

	for (int i = 0; i < 100; ++i)
		f(s);

	for (int i = 0; i < 5000; ++i)
	{
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		f(s);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;
	}

	average_elapsed_time = total_elapsed_time / 500;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
}

static void	test_speed()
{
	printf("%sTest_speed%s\n", GREEN, RESET_COLOR);

	ft_test_speed("Skrattar du, förlorar du, mannen !", strlen);
	ft_test_speed("Skrattar du, förlorar du, mannen !", ft_strlen);
}

static void	test_empty_string()
{
	printf("%sTest_empty_string%s\n", GREEN, RESET_COLOR);

	printf("%ld\n", strlen(""));
	printf("%ld\n", ft_strlen(""));
}

static void	test_one_character()
{
	printf("%sTest_one_character%s\n", GREEN, RESET_COLOR);

	printf("%ld\n", strlen("a"));
	printf("%ld\n", ft_strlen("a"));
}

static void	test_hellow_world()
{
	printf("%sTest_hello_world%s\n", GREEN, RESET_COLOR);

	printf("%ld\n", strlen("a"));
	printf("%ld\n", ft_strlen("a"));
}

static void	test_middle_null_char()
{
	printf("%sTest_middle_null_char%s\n", GREEN, RESET_COLOR);

	printf("%ld\n", strlen("Hello\0world"));
	printf("%ld\n", ft_strlen("Hello\0world"));
}

static void	test_end_null_char()
{
	printf("%sTest_end_null_char%s\n", GREEN, RESET_COLOR);

	printf("%ld\n", strlen("This is a test\0"));
	printf("%ld\n", ft_strlen("This is a test\0"));
}

static void	test_special_characters()
{
	printf("%sTest_special_characters%s\n", GREEN, RESET_COLOR);

	printf("%ld\n", strlen("Special characters: !@#$%^&*()"));
	printf("%ld\n", ft_strlen("Special characters: !@#$%^&*()"));
}

static void	test_long_string()
{
	printf("%sTest_long_string%s\n", GREEN, RESET_COLOR);

	printf("%ld\n", strlen("This is a very long string to test the efficiency of the strlen function. It should return the correct length regardless of the string's length."));
	printf("%ld\n", ft_strlen("This is a very long string to test the efficiency of the strlen function. It should return the correct length regardless of the string's length."));
}

void    test_ft_strlen()
{
	printf("%sTest_ft_strlen%s\n", YELLOW, RESET_COLOR);

	test_speed();
	test_empty_string();
	test_one_character();
	test_hellow_world();
	test_middle_null_char();
	test_end_null_char();
	test_special_characters();
	test_long_string();

	printf("\n");
}
#include "libasm.h"
#include "libasm_tester.h"

static void ft_test_speed(const char *s2, const size_t buffer_size, char *(*f)(char *, const char *))
{
	struct	timespec	start_time, end_time;
	double				elapsed_time, average_elapsed_time;
	double				total_elapsed_time = 0.00;

	char				*s1 = NULL;
	s1 = malloc((buffer_size + 1) * sizeof(*s1));

	bzero(s1, buffer_size);

	for (int i = 0; i < 500; ++i)
		f(s1, s2);

	for (int i = 0; i < 5000; ++i)
	{
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		f(s1, s2);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;
	}

	average_elapsed_time = total_elapsed_time / 500;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
	free(s1);
}

static void	test_string_len_speed()
{
	char	*s = NULL;
	printf("%stest_string_len_speed%s\n", GREEN, RESET_COLOR);

	printf("%sempty%s\n", BLUE, RESET_COLOR);
	s = "";
	ft_test_speed(s, strlen(s) + 1, strcpy);
	ft_test_speed(s, strlen(s) + 1, ft_strcpy);

	printf("%sshort%s\n", BLUE, RESET_COLOR);
	s = "Short";
	ft_test_speed(s, strlen(s) + 1, strcpy);
	ft_test_speed(s, strlen(s) + 1, ft_strcpy);

	printf("%smedium%s\n", BLUE, RESET_COLOR);
	s = "A string longer than 16 chars.";
	ft_test_speed(s, strlen(s) + 1, strcpy);
	ft_test_speed(s, strlen(s) + 1, ft_strcpy);

	printf("%slong%s\n", BLUE, RESET_COLOR);
	s = "A long and repetitive string. A long and repetitive string. A long and repetitive string. A long and repetitive string. A long and repetitive string. A long and repetitive string. A long and repetitive string. A long and repetitive string. A long and repetitive string. A long and repetitive string.";
	ft_test_speed(s, strlen(s) + 1, strcpy);
	ft_test_speed(s, strlen(s) + 1, ft_strcpy);

	printf("%sreally long%s\n", BLUE, RESET_COLOR);
	s = "A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string. A really long and repetitive string.";
	ft_test_speed(s, strlen(s) + 1, strcpy);
	ft_test_speed(s, strlen(s) + 1, ft_strcpy);
}

static void	test_copy_empty_to_empty()
{
	char		s1[1] = { 0 };
	const char	*s2 = "";

	printf("%sTest_copy_empty_to_empty%s\n", GREEN, RESET_COLOR);

	printf("%s | ", strcpy(s1, s2));
	printf("%s\n", ft_strcpy(s1, s2));
}

static void	test_copy_limit_bytes()
{
	char	s1[17] = { 0 };
	char	*s2 = NULL;

	printf("%sTest_copy_limit_bytes%s\n", GREEN, RESET_COLOR);

	s2 = "abcdefghijklmn";

	printf("%s | ", strcpy(s1, s2));
	printf("%s\n", ft_strcpy(s1, s2));

	s2 = "abcdefghijklmno";

	printf("%s | ", strcpy(s1, s2));
	printf("%s\n", ft_strcpy(s1, s2));

	s2 = "abcdefghijklmnop";

	printf("%s | ", strcpy(s1, s2));
	printf("%s\n", ft_strcpy(s1, s2));
}

static void	test_copy_multi_null_byte()
{
	char	s1[10] = { 0 };
	char	*s2 = "Multi\0null\0bytes\0used\0in\0string\0";

	printf("%sTest_copy_limit_null_bytes%s\n", GREEN, RESET_COLOR);

	printf("%s | ", strcpy(s1, s2));
	printf("%s\n", ft_strcpy(s1, s2));
}

void test_ft_strcpy()
{
	printf("%sTest_ft_strcpy%s\n", YELLOW, RESET_COLOR);

	test_string_len_speed();
	test_copy_empty_to_empty();
	test_copy_limit_bytes();
	test_copy_multi_null_byte();

 printf("\n");
}
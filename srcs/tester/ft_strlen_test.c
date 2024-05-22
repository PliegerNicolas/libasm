/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlen_test.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:55:56 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:55:57 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include "libasm_tester.h"

static void    ft_test_speed(const char *s, size_t (*f)(const char *))
{
	struct	timespec	start_time, end_time;
	double	elapsed_time, average_elapsed_time;
	double	total_elapsed_time = 0.00;
	int		count = 5000;

	for (int i = 0; i < (count / 10); ++i)
		f(s);

	for (int i = 0; i < count; ++i)
	{
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		f(s);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;
	}

	average_elapsed_time = total_elapsed_time / count;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
}

static void	test_speed_comparisons()
{
	printf("%sTest_speed_comparisons%s\n", GREEN, RESET_COLOR);

	printf("%sC: %s", BLUE, RESET_COLOR);
	ft_test_speed("Skrattar du, förlorar du, mannen !", strlen);
	printf("%sASM: %s", BLUE, RESET_COLOR);
	ft_test_speed("Skrattar du, förlorar du, mannen !", ft_strlen);
}

static void	test_empty_string()
{
	printf("%sTest_empty_string%s\n", GREEN, RESET_COLOR);
	const char	*s = "";

	printf("%ld | ", strlen(s));
	printf("%ld\n", ft_strlen(s));
}

static void	test_lessthan16bytes_nullterm_string()
{
	printf("%sTest_lessthan16bytes_nullterm_string%s\n", GREEN, RESET_COLOR);
	const char	*s = "Hello";

	printf("%ld | ", strlen(s));
	printf("%ld\n", ft_strlen(s));
}

static void	test_16bytes_nullterm_string()
{
	printf("%sTest_16bytes_nullterm_string%s\n", GREEN, RESET_COLOR);
	const char	*s = "Here, 16 bytes!";

	printf("%ld | ", strlen(s));
	printf("%ld\n", ft_strlen(s));
}

static void	test_17bytes_nullterm_string()
{
	printf("%sTest_17bytes_nullterm_string%s\n", GREEN, RESET_COLOR);
	const char *s = "Here, 17 bytes !";

	printf("%ld | ", strlen(s));
	printf("%ld\n", ft_strlen(s));
}

static void	test_long_nullterm_string()
{
	printf("%sTest_long_nullterm_string%s\n", GREEN, RESET_COLOR);
	const char *s = "This is a quite long string. It could be longer if I had the energy to write more characters ... Well. Okay. Sure. I can go on. But it's just because I have too dude. Are you sure it's okay to write this much data ? Wouldn't my file become too heavy ? It might already weight 2GB. Dunno. Haven't checked.";

	printf("%ld | ", strlen(s));
	printf("%ld\n", ft_strlen(s));
}

static void	test_non_nullterm_string()
{
	printf("%sTest_non_nullterm_string (buffer of size 1024)%s\n", GREEN, RESET_COLOR);
	char	s[1024];

	memset(s, '$', sizeof(s));

	printf("%ld | ", strlen(s));
	printf("%ld\n", ft_strlen(s));
}

void    test_ft_strlen()
{
	printf("%sTest_ft_strlen%s\n", YELLOW, RESET_COLOR);

	test_speed_comparisons();
	test_empty_string();
	test_lessthan16bytes_nullterm_string();
	test_16bytes_nullterm_string();
	test_17bytes_nullterm_string();
	test_long_nullterm_string();
	(void)test_non_nullterm_string;	// This makes valgrind unhappy. Kinda expected.

	printf("\n");
}

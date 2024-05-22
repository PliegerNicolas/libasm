/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strcpy_test.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:55:52 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:55:53 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include "libasm_tester.h"

static void    ft_test_speed(const char *s2, char *(*f)(char *, const char *))
{
	struct	timespec	start_time, end_time;
	double	elapsed_time, average_elapsed_time;
	double	total_elapsed_time = 0.00;
	int		count = 5000;

	char	s1[256];

	for (int i = 0; i < (count / 10); ++i)
	{
		bzero(s1, sizeof(s1));
		f(s1, s2);
	}

	for (int i = 0; i < count; ++i)
	{
		bzero(s1, sizeof(s1));
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		f(s1, s2);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;
	}

	average_elapsed_time = total_elapsed_time / count;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
}

static void	test_speed_comparisons()
{
	char	*s = NULL;

	printf("%sTest_speed_comparisons%s\n", GREEN, RESET_COLOR);

	printf("%sEmpty%s\n", BLUE, RESET_COLOR);
	s = "";
	printf("%sC: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, strcpy);
	printf("%sASM: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, ft_strcpy);

	printf("%sReally short%s\n", BLUE, RESET_COLOR);
	s = ".";
	printf("%sC: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, strcpy);
	printf("%sASM: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, ft_strcpy);

	printf("%sShort%s\n", BLUE, RESET_COLOR);
	s = "A short string.";
	printf("%sC: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, strcpy);
	printf("%sASM: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, ft_strcpy);

	printf("%sMedium%s\n", BLUE, RESET_COLOR);
	s = "Medium using SSE loop once.";
	printf("%sC: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, strcpy);
	printf("%sASM: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, ft_strcpy);

	printf("%sLong%s\n", BLUE, RESET_COLOR);
	s = "With such long strings normally SSE loop should be utilized more than once and provide good performance. Let's see if it's true ...";
	printf("%sC: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, strcpy);
	printf("%sASM: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, ft_strcpy);

	printf("%sreally Long%s\n", BLUE, RESET_COLOR);
	s = "Well. I don't know what I should write to get to 256 bytes but guess we're almost there ? Oh no. That was 90, we're gonna have to fill this in with random things again. 169 now ? Nice. Pity we're not planning to reach 420. We're aiming for 256 and hop !!!";
	printf("%sC: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, strcpy);
	printf("%sASM: %s", BLUE, RESET_COLOR);
	ft_test_speed(s, ft_strcpy);
}

static void	test_empty_string()
{
	char	s1[256];
	char	*s2 = "";
	
	printf("%sTest_empty_string%s\n", GREEN, RESET_COLOR);

	bzero(s1, sizeof(s1));
	printf("%s\n", strcpy(s1, s2));
	bzero(s1, sizeof(s1));
	printf("%s\n", ft_strcpy(s1, s2));
}

static void	test_lessthan_16bytes_string()
{
	char	s1[256];
	char	*s2 = "8 bytes";
	
	printf("%sTest_lessthan_16bytes_string%s\n", GREEN, RESET_COLOR);

	bzero(s1, sizeof(s1));
	printf("%s\n", strcpy(s1, s2));
	bzero(s1, sizeof(s1));
	printf("%s\n", ft_strcpy(s1, s2));
}

static void	test_16bytes_string()
{
	char	s1[256];
	char	*s2 = "There, 16 bytes";
	
	printf("%sTest_16bytes_string%s\n", GREEN, RESET_COLOR);

	bzero(s1, sizeof(s1));
	printf("%s\n", strcpy(s1, s2));
	bzero(s1, sizeof(s1));
	printf("%s\n", ft_strcpy(s1, s2));
}

static void	test_17bytes_string()
{
	char	s1[256];
	char	*s2 = "There, 17 bytes!";
	
	printf("%sTest_17bytes_string%s\n", GREEN, RESET_COLOR);

	bzero(s1, sizeof(s1));
	printf("%s\n", strcpy(s1, s2));
	bzero(s1, sizeof(s1));
	printf("%s\n", ft_strcpy(s1, s2));
}

static void	test_32bytes_string()
{
	char	s1[256];
	char	*s2 = "Well that's much, 32 bytes, no?";
	
	printf("%sTest_32bytes_string%s\n", GREEN, RESET_COLOR);

	bzero(s1, sizeof(s1));
	printf("%s\n", strcpy(s1, s2));
	bzero(s1, sizeof(s1));
	printf("%s\n", ft_strcpy(s1, s2));
}

static void	test_42bytes_string()
{
	char	s1[256];
	char	*s2 = "Well that's much, 42 bytes, aren't there?";
	
	printf("%sTest_42bytes_string%s\n", GREEN, RESET_COLOR);

	bzero(s1, sizeof(s1));
	printf("%s\n", strcpy(s1, s2));
	bzero(s1, sizeof(s1));
	printf("%s\n", ft_strcpy(s1, s2));
}

static void	test_256bytes_string()
{
	char	s1[256];
	char	*s2 = "I have to fill this string with 256 characters but this is hard to do. I don't know what to write about so I'll talk about nothing. What is nothing ? Nothing isn't empty. Otherwise it would be the same word and we wouldn't say I'm talking about nothing :)";
	
	printf("%sTest_256bytes_string%s\n", GREEN, RESET_COLOR);

	bzero(s1, sizeof(s1));
	printf("%s\n", strcpy(s1, s2));
	bzero(s1, sizeof(s1));
	printf("%s\n", ft_strcpy(s1, s2));
}

static void	test_null_string()
{
	char	s1[256];
	char	*s2 = NULL;
	
	printf("%sTest_null_string%s\n", GREEN, RESET_COLOR);

	bzero(s1, sizeof(s1));
	printf("%s\n", strcpy(s1, s2));
	bzero(s1, sizeof(s1));
	printf("%s\n", ft_strcpy(s1, s2));
}

void test_ft_strcpy()
{
	printf("%sTest_ft_strcpy%s\n", YELLOW, RESET_COLOR);

	test_speed_comparisons();
	test_empty_string();
	test_lessthan_16bytes_string();
	test_16bytes_string();
	test_17bytes_string();
	test_32bytes_string();
	test_42bytes_string();
	test_256bytes_string();
	(void)test_null_string;

	printf("\n");
}

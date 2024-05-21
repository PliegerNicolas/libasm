/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strdup_test.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:55:45 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:55:46 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include "libasm_tester.h"

static void    ft_test_speed(const char *s, char *(*f)(const char *))
{
	struct	timespec	start_time, end_time;
	double	elapsed_time, average_elapsed_time;
	double	total_elapsed_time = 0.00;
	int		count = 5000;

	char	*s_ret = NULL;

	for (int i = 0; i < (count / 10); ++i)
	{
		s_ret = f(s);
		if (!s_ret)
			return ;
		free(s_ret);
		s_ret = NULL;
	}

	for (int i = 0; i < count; ++i)
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

	average_elapsed_time = total_elapsed_time / count;
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

static void	test_empty_string()
{
	char	*s1 = NULL;
	char	*s2 = "";
	
	printf("%sTest_empty_string%s\n", GREEN, RESET_COLOR);

	s1 = strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
	s1 = ft_strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
}

static void	test_lessthan_16bytes_string()
{
	char	*s1 = NULL;
	char	*s2 = "8 bytes";
	
	printf("%sTest_lessthan_16bytes_string%s\n", GREEN, RESET_COLOR);

	s1 = strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
	s1 = ft_strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
}

static void	test_16bytes_string()
{
	char	*s1 = NULL;
	char	*s2 = "There, 16 bytes";
	
	printf("%sTest_16bytes_string%s\n", GREEN, RESET_COLOR);

	s1 = strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
	s1 = ft_strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
}

static void	test_17bytes_string()
{
	char	*s1 = NULL;
	char	*s2 = "There, 17 bytes!";
	
	printf("%sTest_17bytes_string%s\n", GREEN, RESET_COLOR);

	s1 = strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
	s1 = ft_strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
}

static void	test_32bytes_string()
{
	char	*s1 = NULL;
	char	*s2 = "Well that's much, 32 bytes, no?";
	
	printf("%sTest_32bytes_string%s\n", GREEN, RESET_COLOR);

	s1 = strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
	s1 = ft_strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
}

static void	test_42bytes_string()
{
	char	*s1 = NULL;
	char	*s2 = "Well that's much, 42 bytes, aren't there?";
	
	printf("%sTest_42bytes_string%s\n", GREEN, RESET_COLOR);

	s1 = strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
	s1 = ft_strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
}

static void	test_256bytes_string()
{
	char	*s1 = NULL;
	char	*s2 = "I have to fill this string with 256 characters but this is hard to do. I don't know what to write about so I'll talk about nothing. What is nothing ? Nothing isn't empty. Otherwise it would be the same word and we wouldn't say I'm talking about nothing :)";
	
	printf("%sTest_256bytes_string%s\n", GREEN, RESET_COLOR);

	s1 = strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
	s1 = ft_strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
}

static void	test_null_string()
{
	char	*s1 = NULL;
	char	*s2 = NULL;
	
	printf("%sTest_null_string%s\n", GREEN, RESET_COLOR);

	s1 = strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
	s1 = ft_strdup(s2);
	printf("%s (errno: %s)\n", s1, strerror(errno));
	free(s1);
}

void    test_ft_strdup()
{
    printf("%sTest_ft_strdup%s\n", YELLOW, RESET_COLOR);

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

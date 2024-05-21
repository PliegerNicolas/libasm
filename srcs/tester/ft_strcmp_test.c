/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strcmp_test.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:55:39 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:55:40 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include "libasm_tester.h"

static void    ft_test_speed(const char *s1, const char *s2, int (*f)(const char *, const char *))
{
	struct	timespec	start_time, end_time;
	double	elapsed_time, average_elapsed_time;
	double	total_elapsed_time = 0.00;
	int		count = 5000;

	for (int i = 0; i < (count / 10); ++i)
		f(s1, s2);

	for (int i = 0; i < count; ++i)
	{
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		f(s1, s2);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;
	}

	average_elapsed_time = total_elapsed_time / count;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
}

static void	test_empty_equal_strings()
{
	printf("%sTest_empty_equal_strings%s\n", GREEN, RESET_COLOR);

	printf("%d | ", strcmp("", ""));										// 0
	printf("%d\n", ft_strcmp("", ""));										// 0
}

static void	test_charlimits_equal_strings()
{
	// Needed because we test 16 bytes per 16 bytes.
	printf("%sTest_charlimits_equal_strings%s\n", GREEN, RESET_COLOR);

	// 15 chars
	printf("%d | ", strcmp("abcdefghijklmn", "abcdefghijklmn"));			// 15
	printf("%d\n", ft_strcmp("abcdefghijklmn", "abcdefghijklmn"));			// 15

	// 16 chars
	printf("%d | ", strcmp("abcdefghijklmno", "abcdefghijklmno"));			// 16
	printf("%d\n", ft_strcmp("abcdefghijklmno", "abcdefghijklmno"));		// 16

	// 17 chars
	printf("%d | ", strcmp("abcdefghijklmnop", "abcdefghijklmnop"));		// 16 + 1
	printf("%d\n", ft_strcmp("abcdefghijklmnop", "abcdefghijklmnop"));		// 16 + 1
}

static void	test_charlimits_unequal_strings()
{
	// Needed because we test 16 bytes per 16 bytes.
	printf("%sTest_charlimits_unequal_strings%s\n", GREEN, RESET_COLOR);

	// 15 chars
	printf("%d | ", strcmp("abcdefghijklmn", "abcdefghijklma"));			// 14
	printf("%d\n", ft_strcmp("abcdefghijklmn", "abcdefghijklma"));			// 14

	// 16 chars
	printf("%d | ", strcmp("abcdefghijklmno", "abcdefghijklmna"));			// 15
	printf("%d\n", ft_strcmp("abcdefghijklmno", "abcdefghijklmna"));		// 15

	// 17 chars
	printf("%d | ", strcmp("abcdefghijklmnop", "abcdefghijklmnoa"));		// 16
	printf("%d\n", ft_strcmp("abcdefghijklmnop", "abcdefghijklmnoa"));		// 16

	// 19 chars
	printf("%d | ", strcmp("abcdefghijklmnopqr", "abcdefghijklmnopqa"));	// 16 + 1
	printf("%d\n", ft_strcmp("abcdefghijklmnopqr", "abcdefghijklmnopqa"));	// 16 + 1
}

static void	test_diff_size_unequal_strings()
{
	printf("%sTest_diff_Size_unequal_strings%s\n", GREEN, RESET_COLOR);

	printf("%d | ", strcmp("Hello, world!", "Hello!"));						// 5
	printf("%d\n", ft_strcmp("Hello, world!", "Hello!"));					// 5

	printf("%d | ", strcmp("Hello!", "Hello, world!"));						// 5
	printf("%d\n", ft_strcmp("Hello!", "Hello, world!"));					// 5

	printf("%d | ", strcmp("Hello, woooooooooooooooooooooorld!", "Yo dude..."));	// 0
	printf("%d\n", ft_strcmp("Hello, woooooooooooooooooooooorld!", "Yo dude..."));	// 0

	printf("%d | ", strcmp("Yo dude...", "Hello, woooooooooooooooooooooorld!"));	// 0
	printf("%d\n", ft_strcmp("Yo dude...", "Hello, woooooooooooooooooooooorld!"));	// 0
}

static void	test_non_ascii_chars()
{
	printf("%sTest_non_ascii_chars%s\n", GREEN, RESET_COLOR);

	printf("%d | ", strcmp("Special characters: !@#$%^&*()", "Special characters: !@#$%^&*()"));
	printf("%d\n", ft_strcmp("Special characters: !@#$%^&*()", "Special characters: !@#$%^&*()"));

	printf("%d | ", strcmp("Special characters: !@#$%^&*()", "Special characters: !@#$%"));
	printf("%d\n", ft_strcmp("Special characters: !@#$%^&*()", "Special characters: !@#$%"));

	printf("%d | ", strcmp("Special characters: !@#$%^&*()", "Special characters: ()*&^%$#@!"));
	printf("%d\n", ft_strcmp("Special characters: !@#$%^&*()", "Special characters: ()*&^%$#@!"));
}

void    test_ft_strcmp()
{
    printf("%sTest_ft_strcmp%s\n", YELLOW, RESET_COLOR);

    ft_test_speed("Skrattar du, förlorar du, mannen !", "abcde", strcmp);
    ft_test_speed("Skrattar du, förlorar du, mannen !", "abcde", ft_strcmp);

	test_empty_equal_strings();
	test_charlimits_equal_strings();
	test_charlimits_unequal_strings();
	test_diff_size_unequal_strings();
	test_non_ascii_chars();

    printf("\n");
}

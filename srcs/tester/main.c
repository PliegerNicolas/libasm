/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/07 10:13:28 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/07 12:11:25 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"

#define EXPECTED_COLOR "\x1b[32m"
#define TEST_COLOR "\x1b[33m"
#define RESET_COLOR "\x1b[0m"

void	test_strlen()
{
	char	*str;
	
	str = "A not so random test string.";
	printf("Test_strlen nº1: %s\n", str);
	printf("%sExpecting: %ld%s\n", EXPECTED_COLOR, strlen(str), RESET_COLOR);
	printf("%sResult: %ld%s\n", TEST_COLOR, ft_strlen(str), RESET_COLOR);

	str = "";
	printf("Test_strlen nº2: %s\n", str);
	printf("%sExpecting: %ld%s\n", EXPECTED_COLOR, strlen(str), RESET_COLOR);
	printf("%sResult: %ld%s\n", TEST_COLOR, ft_strlen(str), RESET_COLOR);

	str = "Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages.";;
	printf("Test_strlen nº3: Commented out. Text too long to be displayed.\n");
	printf("%sExpecting: %ld%s\n", EXPECTED_COLOR, strlen(str), RESET_COLOR);
	printf("%sResult: %ld%s\n", TEST_COLOR, ft_strlen(str), RESET_COLOR);

	str = NULL;
	printf("Test_strlen nº4: No output here. Causes segfault as expected (UB)\n");
	//printf("%sExpecting: %ld\n%s", EXPECTED_COLOR, strlen(str), RESET_COLOR);
	//printf("%sResult: %ld\n%s", TEST_COLOR, ft_strlen(str), RESET_COLOR);

	printf("\n");
}

void	test_write()
{
	char		*str;
	int			fd;
	long int	o;
	
	str = "A not so random test string.";
	fd = 1;
	errno = 0;
	printf("Test_write nº1: %s\n", str);
	(void)write(fd, "Output: ", 8);
	o = write(fd, str, strlen(str));
	printf("%sExpecting: %ld, %s%s\n", EXPECTED_COLOR, o, strerror(errno), RESET_COLOR);
	errno = 0;
	(void)write(fd, "Output: ", 8);
	o = ft_write(fd, str, strlen(str));
	printf("%sResult: %ld, %s%s\n", TEST_COLOR, o, strerror(errno), RESET_COLOR);

	str = "A not so random test string.";
	fd = -5;
	errno = 0;
	printf("Test_write nº1: %s\n", str);
	(void)write(fd, "Output: ", 8);
	o = write(fd, str, strlen(str));
	printf("%sExpecting: %ld, %s%s\n", EXPECTED_COLOR, o, strerror(errno), RESET_COLOR);
	errno = 0;
	(void)write(fd, "Output: ", 8);
	o = ft_write(fd, str, strlen(str));
	printf("%sResult: %ld, %s%s\n", TEST_COLOR, o, strerror(errno), RESET_COLOR);

	str = "A not so random test string.";
	fd = 1;
	errno = 0;
	printf("Test_write nº1: %s\n", str);
	(void)write(fd, "Output: ", 8);
	o = write(fd, str, 0);
	printf("%sExpecting: %ld, %s%s\n", EXPECTED_COLOR, o, strerror(errno), RESET_COLOR);
	errno = 0;
	(void)write(fd, "Output: ", 8);
	o = ft_write(fd, str, 0);
	printf("%sResult: %ld, %s%s\n", TEST_COLOR, o, strerror(errno), RESET_COLOR);

	// GCC compiler prevents this.

	//str = "";
	//fd = 1;
	//errno = 0;
	//printf("Test_write nº1: %s\n", str);
	//(void)write(fd, "Output: ", 8);
	//o = write(fd, str, 10);
	//printf("%sExpecting: %ld, %s%s\n", EXPECTED_COLOR, o, strerror(errno), RESET_COLOR);
	//errno = 0;
	//(void)write(fd, "Output: ", 8);
	//o = ft_write(fd, str, 10);
	//printf("%sResult: %ld, %s%s\n", TEST_COLOR, o, strerror(errno), RESET_COLOR);

	str = "A not so random test string.";
	fd = 5;
	errno = 0;
	printf("Test_write nº1: %s\n", str);
	(void)write(fd, "Output: ", 8);
	o = write(fd, str, strlen(str));
	printf("%sExpecting: %ld, %s%s\n", EXPECTED_COLOR, o, strerror(errno), RESET_COLOR);
	errno = 0;
	(void)write(fd, "Output: ", 8);
	o = ft_write(fd, str, strlen(str));
	printf("%sResult: %ld, %s%s\n", TEST_COLOR, o, strerror(errno), RESET_COLOR);

	str = NULL;
	fd = 1;
	errno = 0;
	printf("Test_write nº1: %s\n", str);
	(void)write(fd, "Output: ", 8);
	o = write(fd, str, 5);
	printf("%sExpecting: %ld, %s%s\n", EXPECTED_COLOR, o, strerror(errno), RESET_COLOR);
	errno = 0;
	(void)write(fd, "Output: ", 8);
	o = ft_write(fd, str, 5);
	printf("%sResult: %ld, %s%s\n", TEST_COLOR, o, strerror(errno), RESET_COLOR);

	// Commented out but successful. Too much text it got annoying.

	//str = "Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages. Here is some really mindless text that will go on and on and on, for pages and pages and pages.";;
	//fd = 1;
	//errno = 0;
	//printf("Test_write nº1: %s\n", str);
	//(void)write(fd, "Output: ", 8);
	//o = write(fd, str, strlen(str));
	//printf("%sExpecting: %ld, %s%s\n", EXPECTED_COLOR, o, strerror(errno), RESET_COLOR);
	//errno = 0;
	//(void)write(fd, "Output: ", 8);
	//o = ft_write(fd, str, strlen(str));
	//printf("%sResult: %ld, %s%s\n", TEST_COLOR, o, strerror(errno), RESET_COLOR);

	printf("\n");
}

void	test_read()
{
	char		buffer[1024] = { 0 };
	int			fd_file1 = 0;
	int			fd_file2 = 0;
	long int	o1 = 0;
	long int	o2 = 0;

	// Read from STDIN. Commented out because annoying but works.
	/*
	errno = 0;
	printf("Test_read nº1: from fd %d (console)\n", fd_file1);
	o1 = read(fd_file1, buffer, sizeof(buffer) - 1);
	printf("%sResult of read: %ld, %s%s\n", EXPECTED_COLOR, o1, strerror(errno), RESET_COLOR);
	bzero(buffer, sizeof(buffer));
	errno = 0;
	o1 = ft_read(fd_file1, buffer, sizeof(buffer) - 1);
	printf("%sResult of ft_read: %ld, %s%s\n", TEST_COLOR, o1, strerror(errno), RESET_COLOR);
	bzero(buffer, sizeof(buffer));
	*/

	// Read from invalid fd
	fd_file1 = -1;
	errno = 0;
	printf("Test_read nº2: from fd %d (console)\n", fd_file1);
	o1 = read(fd_file1, buffer, sizeof(buffer) - 1);
	printf("%sResult of read: %ld, %s%s\n", EXPECTED_COLOR, o1, strerror(errno), RESET_COLOR);
	bzero(buffer, sizeof(buffer));
	errno = 0;
	o1 = ft_read(fd_file1, buffer, sizeof(buffer) - 1);
	printf("%sResult of ft_read: %ld, %s%s\n", TEST_COLOR, o1, strerror(errno), RESET_COLOR);
	bzero(buffer, sizeof(buffer));

	// Read entire file in parallel.
	fd_file1 = open("Makefile", O_RDONLY);
	fd_file2 = open("Makefile", O_RDONLY);
	o1 = 1;
	o2 = 1;
	printf("Test_read nº3: read total file simultaneously with fds %d and %d\n", fd_file1, fd_file2);
	while (o1 && o2)
	{
		errno = 0;
		o1 = read(fd_file1, buffer, sizeof(buffer) - 1);
		printf("%sResult of read: %ld: %s, %s%s\n", EXPECTED_COLOR, o1, buffer, strerror(errno), RESET_COLOR);
		bzero(buffer, sizeof(buffer));
		errno = 0;
		o2 = ft_read(fd_file2, buffer, sizeof(buffer) - 1);
		printf("%sResult of ft_read: %ld: %s, %s%s\n", TEST_COLOR, o2, buffer, strerror(errno), RESET_COLOR);
		bzero(buffer, sizeof(buffer));
	}
	close(fd_file1);
	close(fd_file2);
	fd_file1 = 0;
	fd_file2 = 0;

	printf("\n");
}

void	test_strcmp()
{
	char	*str1 = NULL;
	char	*str2 = NULL;

	str1 = "abc";
	str2 = "abc";
	printf("Test_strcmp nº1: str1: '%s' with str2: '%s'\n", str1, str2);
	printf("%sExpecting: %d%s\n", EXPECTED_COLOR, strcmp(str1, str2), RESET_COLOR);
	printf("%sResult: %d%s\n", TEST_COLOR, ft_strcmp(str1, str2), RESET_COLOR);

	str1 = "";
	str2 = "";
	printf("Test_strcmp nº2: str1: '%s' with str2: '%s'\n", str1, str2);
	printf("%sExpecting: %d%s\n", EXPECTED_COLOR, strcmp(str1, str2), RESET_COLOR);
	printf("%sResult: %d%s\n", TEST_COLOR, ft_strcmp(str1, str2), RESET_COLOR);

	str1 = "abc";
	str2 = "abcd";
	printf("Test_strcmp nº3: str1: '%s' with str2: '%s'\n", str1, str2);
	printf("%sExpecting: %d%s\n", EXPECTED_COLOR, strcmp(str1, str2), RESET_COLOR);
	printf("%sResult: %d%s\n", TEST_COLOR, ft_strcmp(str1, str2), RESET_COLOR);

	str1 = "Salut ça va ?";
	str2 = "Plutôt bien mon gars !!!";
	printf("Test_strcmp nº4: str1: '%s' with str2: '%s'\n", str1, str2);
	printf("%sExpecting: %d%s\n", EXPECTED_COLOR, strcmp(str1, str2), RESET_COLOR);
	printf("%sResult: %d%s\n", TEST_COLOR, ft_strcmp(str1, str2), RESET_COLOR);

	// Commented out, because the original and mine result in UB (segfault).
	str1 = NULL;
	str2 = "a";
	//printf("Test_strcmp nº5: str1: '%s' with str2: '%s'\n", str1, str2);
	//printf("%sExpecting: %d%s\n", EXPECTED_COLOR, strcmp(str1, str2), RESET_COLOR);
	//printf("%sResult: %d%s\n", TEST_COLOR, ft_strcmp(str1, str2), RESET_COLOR);

	printf("\n");
}

void	test_strcpy()
{
	char	str1[20] = { 0 };
	char	*str2 = NULL;

	str2 = "Ouistiti";
	printf("Test_strcpy nº1: str1: '%s' with str2: '%s'\n", str1, str2);
	printf("%sExpecting: '%s'%s\n", EXPECTED_COLOR, strcpy(str1, str2), RESET_COLOR);
	printf("%sResult: '%s'%s\n", TEST_COLOR, ft_strcpy(str1, str2), RESET_COLOR);

	printf("\n");
}

 void	test_strcpy_speed()
 {
	struct timespec	start_time, end_time;
	double elapsed_time = 0.0;
	double total_elapsed_time = 0.00;

	char		dest[50];
	const char	*src = "Une banane qui roule par terre.";

	bzero(dest, sizeof(dest));

	// Warmup
	for (int i = 0; i < 100; ++i)
		ft_strcpy(dest, src);

	for (int i = 0; i < 500; ++i)
	{
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		ft_strcpy(dest, src);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;
	}

	double	average_elapsed_time = total_elapsed_time / 500;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
	printf("Dest: %s\n", dest);

	printf("\n");
 }

int	main(void)
{
	test_strlen();
	test_write();
	test_read();
	test_strcmp();
	test_strcpy();

	return (0);
}

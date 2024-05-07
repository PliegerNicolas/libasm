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
}

int	main(void)
{
	test_strlen();
	printf("\n");
	test_write();
	printf("\n");

	return (0);
}
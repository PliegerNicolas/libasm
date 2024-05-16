/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_read_test.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:56:04 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:56:05 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include "libasm_tester.h"

static void    ft_test_speed(int fd, char *buffer, size_t count, ssize_t (*f)(int, void *, size_t))
{
	struct	timespec	start_time, end_time;
	double	elapsed_time, average_elapsed_time;
	double	total_elapsed_time = 0.00;

	for (int i = 0; i < 500; ++i)
		f(fd, buffer, count);

	for (int i = 0; i < 5000; ++i)
	{
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		f(fd, buffer, count);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;
	}

	average_elapsed_time = total_elapsed_time / 500;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
}

static void	test_speed_comparisons()
{
	int		fd = open("/dev/random", O_WRONLY);
	char	buffer[2048] = { 0 };
	size_t	count = 0;

	printf("%sTest_speed_comparisons%s\n", GREEN, RESET_COLOR);

	if (fd == -1)
	{
		printf("%s\n", strerror(errno));
		return ;
	}

	printf("%sEmpty%s\n", BLUE, RESET_COLOR);
	count = 0;
	ft_test_speed(fd, buffer, count, read);
	ft_test_speed(fd, buffer, count, ft_read);

	printf("%sReally short%s\n", BLUE, RESET_COLOR);
	count = 5;
	ft_test_speed(fd, buffer, count, read);
	ft_test_speed(fd, buffer, count, ft_read);

	printf("%sShort%s\n", BLUE, RESET_COLOR);
	count = 16;
	ft_test_speed(fd, buffer, count, read);
	ft_test_speed(fd, buffer, count, ft_read);

	printf("%sMedium%s\n", BLUE, RESET_COLOR);
	count = 128;
	ft_test_speed(fd, buffer, count, read);
	ft_test_speed(fd, buffer, count, ft_read);

	printf("%sLong%s\n", BLUE, RESET_COLOR);
	count = 1024;
	ft_test_speed(fd, buffer, count, read);
	ft_test_speed(fd, buffer, count, ft_read);

	printf("%sreally Long%s\n", BLUE, RESET_COLOR);
	count = 2048;
	ft_test_speed(fd, buffer, count, read);
	ft_test_speed(fd, buffer, count, ft_read);

	close (fd);
}

static void	test_buffer_after_read()
{
	int		fd = open("./Makefile", O_RDONLY);
	char	buffer[2048];
	size_t	count = 0;
	ssize_t	ret = 0;

	printf("%sTest_buffer_after_read%s\n", GREEN, RESET_COLOR);

	if (fd == -1)
	{
		printf("%s\n", strerror(errno));
		return ;
	}

	{
		char	*temp_buffer = NULL;
		
		printf("%sNULL buffer (0 length)%s\n", BLUE, RESET_COLOR);
		temp_buffer = NULL;
		count = 0;
		errno = 0;
		ret = read(fd, temp_buffer, count);
		printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);
		errno = 0;
		ret = ft_read(fd, temp_buffer, count);
		printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);

		printf("%sNULL buffer (negative length)%s\n", BLUE, RESET_COLOR);
		temp_buffer = NULL;
		count = -2;
		errno = 0;
		ret = read(fd, temp_buffer, count);
		printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);
		errno = 0;
		ret = ft_read(fd, temp_buffer, count);
		printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);

		printf("%sNULL buffer (valid length)%s\n", BLUE, RESET_COLOR);
		temp_buffer = NULL;
		count = 10;
		errno = 0;
		ret = read(fd, temp_buffer, count);
		printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);
		errno = 0;
		ret = ft_read(fd, temp_buffer, count);
		printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);
	}

	printf("%s0 length%s\n", BLUE, RESET_COLOR);
	count = 0;
	errno = 0;
	bzero(buffer, sizeof(buffer));
	ret = read(fd, buffer, count);
	printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);
	errno = 0;
	bzero(buffer, sizeof(buffer));
	ret = ft_read(fd, buffer, count);
	printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);

	printf("%sNegative length%s\n", BLUE, RESET_COLOR);
	count = -2;
	errno = 0;
	bzero(buffer, sizeof(buffer));
	ret = read(fd, buffer, count);
	printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);
	errno = 0;
	bzero(buffer, sizeof(buffer));
	ret = ft_read(fd, buffer, count);
	printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);



	printf("%sShort%s\n", BLUE, RESET_COLOR);
	count = 10;
	errno = 0;
	bzero(buffer, sizeof(buffer));
	ret = read(fd, buffer, count);
	printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);
	errno = 0;
	bzero(buffer, sizeof(buffer));
	ft_read(fd, buffer, count);
	printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);

	printf("%sMedium%s\n", BLUE, RESET_COLOR);
	count = 256;
	errno = 0;
	bzero(buffer, sizeof(buffer));
	read(fd, buffer, count);
	printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);
	errno = 0;
	bzero(buffer, sizeof(buffer));
	ret = ft_read(fd, buffer, count);
	printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);

	printf("%sLong%s\n", BLUE, RESET_COLOR);
	count = 2047;
	errno = 0;
	bzero(buffer, sizeof(buffer));
	ret = read(fd, buffer, count);
	printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);
	errno = 0;
	bzero(buffer, sizeof(buffer));
	ret = ft_read(fd, buffer, count);
	printf("'%s'\n%s[%ld] (errno: %s)%s\n", buffer, GRAY, ret, strerror(errno), RESET_COLOR);
}

void    test_ft_read()
{
	printf("%sTest_ft_read%s\n", YELLOW, RESET_COLOR);

	test_speed_comparisons();
	test_buffer_after_read();

	printf("\n");
}

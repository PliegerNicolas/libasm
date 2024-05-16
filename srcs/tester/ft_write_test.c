/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_write_test.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:56:00 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:56:00 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include "libasm_tester.h"

static void    ft_test_speed(int fd, const char *str, size_t length, ssize_t (*f)(int, const void *, size_t))
{
	struct	timespec	start_time, end_time;
	double	elapsed_time, average_elapsed_time;
	double	total_elapsed_time = 0.00;

	for (int i = 0; i < 500; ++i)
		f(fd, str, length);

	for (int i = 0; i < 5000; ++i)
	{
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		f(fd, str, length);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;
	}

	average_elapsed_time = total_elapsed_time / 500;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
}

static void	test_speed_comparisons()
{
	char	*s = NULL;
	int		fd = open("/dev/null", O_WRONLY);

	printf("%sTest_speed_comparisons%s\n", GREEN, RESET_COLOR);

	if (fd == -1)
	{
		printf("%s\n", strerror(errno));
		return ;
	}

	printf("%sEmpty%s\n", BLUE, RESET_COLOR);
	s = "";
	ft_test_speed(fd, s, strlen(s), write);
	ft_test_speed(fd, s, strlen(s), ft_write);

	printf("%sReally short%s\n", BLUE, RESET_COLOR);
	s = ".";
	ft_test_speed(fd, s, strlen(s), write);
	ft_test_speed(fd, s, strlen(s), ft_write);

	printf("%sShort%s\n", BLUE, RESET_COLOR);
	s = "A short string.";
	ft_test_speed(fd, s, strlen(s), write);
	ft_test_speed(fd, s, strlen(s), ft_write);

	printf("%sMedium%s\n", BLUE, RESET_COLOR);
	s = "Medium using SSE loop once.";
	ft_test_speed(fd, s, strlen(s), write);
	ft_test_speed(fd, s, strlen(s), ft_write);

	printf("%sLong%s\n", BLUE, RESET_COLOR);
	s = "With such long strings normally SSE loop should be utilized more than once and provide good performance. Let's see if it's true ...";
	ft_test_speed(fd, s, strlen(s), write);
	ft_test_speed(fd, s, strlen(s), ft_write);

	printf("%sreally Long%s\n", BLUE, RESET_COLOR);
	s = "Well. I don't know what I should write to get to 256 bytes but guess we're almost there ? Oh no. That was 90, we're gonna have to fill this in with random things again. 169 now ? Nice. Pity we're not planning to reach 420. We're aiming for 256 and hop !!!";
	ft_test_speed(fd, s, strlen(s), write);
	ft_test_speed(fd, s, strlen(s), ft_write);

	close (fd);
}

static void	test_write_return_val()
{
	char	*s = NULL;
	int		fd = 0;

	printf("%sTest_write_return_val%s\n", GREEN, RESET_COLOR);

	printf("%sNULL (0 length)%s\n", BLUE, RESET_COLOR);
	s = NULL;
	errno = 0;
	printf("%ld\n", write(fd, s, 0));
	printf("errno: %s\n", strerror(errno));
	errno = 0;
	printf("%ld\n", ft_write(fd, s, 0));
	printf("errno: %s\n", strerror(errno));

	printf("%sNULL (with length)%s\n", BLUE, RESET_COLOR);
	s = NULL;
	errno = 0;
	printf("%ld\n", write(fd, s, 42));
	printf("errno: %s\n", strerror(errno));
	errno = 0;
	printf("%ld\n", ft_write(fd, s, 42));
	printf("errno: %s\n", strerror(errno));

	printf("%sInvalid fd%s\n", BLUE, RESET_COLOR);
	fd = -1;
	s = "A message.";
	errno = 0;
	printf("%ld\n", write(fd, s, strlen(s)));
	printf("errno: %s\n", strerror(errno));
	errno = 0;
	printf("%ld\n", ft_write(fd, s, strlen(s)));
	printf("errno: %s\n", strerror(errno));

	fd = open("/dev/null", O_WRONLY);

	if (fd == -1)
		return ;

	printf("%sEmpty string%s\n", BLUE, RESET_COLOR);
	s = "";
	errno = 0;
	printf("%ld\n", write(fd, s, strlen(s)));
	printf("errno: %s\n", strerror(errno));
	errno = 0;
	printf("%ld\n", ft_write(fd, s, strlen(s)));
	printf("errno: %s\n", strerror(errno));

	printf("%sReally long string%s\n", BLUE, RESET_COLOR);
	s = "A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ? Guess what, it starts again. A really long and repetitive string isn't it ?";
	errno = 0;
	printf("%ld\n", write(fd, s, strlen(s)));
	printf("errno: %s\n", strerror(errno));
	errno = 0;
	printf("%ld\n", ft_write(fd, s, strlen(s)));
	printf("errno: %s\n", strerror(errno));

	close (fd);
}

static void	test_output()
{
	char	*s = NULL;
	int		fd = 0;

	printf("%sTest_output%s\n", GREEN, RESET_COLOR);

	printf("%sEmpty string%s\n", BLUE, RESET_COLOR);
	s = "\n";
	write(fd, s, strlen(s));
	ft_write(fd, s, strlen(s));

	printf("%sString%s\n", BLUE, RESET_COLOR);
	s = "Hello, world!\n";
	write(fd, s, strlen(s));
	ft_write(fd, s, strlen(s));

	printf("%sNew lines%s\n", BLUE, RESET_COLOR);
	s = "H\ne\nl\nl\no\n";
	write(fd, s, strlen(s));
	ft_write(fd, s, strlen(s));

	printf("%sMulti null-bytes%s\n", BLUE, RESET_COLOR);
	s = "This is a message punctuated by null bytes. It shouldn't\0 finish just here \0 for example.\n";
	write(fd, s, strlen(s));
	ft_write(fd, s, strlen(s));
}

void    test_ft_write()
{
    printf("%sTest_ft_write%s\n", YELLOW, RESET_COLOR);

	test_speed_comparisons();
	test_write_return_val();
	test_output();

    printf("\n");
}

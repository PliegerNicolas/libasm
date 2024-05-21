/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_sort_bonus_test.c                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:54:17 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:54:17 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include "libasm_tester.h"

/* Functions to pass as arguments */

static int	cmp(int *data, int *data_ref)
{
	if (!data && !data_ref)
		return (0);
	else if (!data || !data_ref)
		return (-42);
	return (*data - *data_ref);
}

/* Tests */

static void    ft_test_speed(void (*f)(t_list **, int (*)()))
{
	printf("%sTest_speed (5000 * ft_list_sort(rand list of size 100)%s\n", GREEN, RESET_COLOR);

	struct	timespec	start_time, end_time;
	double	elapsed_time, average_elapsed_time;
	double	total_elapsed_time = 0.00;
	int		count = 5000;

	t_list	*list = NULL;

	for (int i = 0; i < (count / 10); ++i)
	{
		list = generate_list(100);
		if (!list)
			return ;
		f(&list, cmp);
		free_list(list);
	}

	for (int i = 0; i < count; ++i)
	{
		list = generate_list(100);
		if (!list)
			return ;
		clock_gettime(CLOCK_MONOTONIC, &start_time);
		f(&list, cmp);
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		free_list(list);
		elapsed_time = (end_time.tv_sec - start_time.tv_sec) * 1000.0 + (end_time.tv_nsec - start_time.tv_nsec) / 1000000.0;
		total_elapsed_time += elapsed_time;
	}

	average_elapsed_time = total_elapsed_time / count;
	printf("Average elapsed time: %f ms\n", average_elapsed_time);
}

void	test_edge_cases()
{
    printf("%sTest_edge_cases%s\n", GREEN, RESET_COLOR);

	t_list	*list = NULL;

	printf("%snull arguments%s\n", BLUE, RESET_COLOR);
	print_list(list);
	ft_list_sort(NULL, NULL);
	printf("%sempty list with 'cmp' function.%s\n", BLUE, RESET_COLOR);
	print_list(list);
	ft_list_sort(&list, cmp);
	printf("%sempty list and null 'cmp' function%s\n", BLUE, RESET_COLOR);
	print_list(list);
	ft_list_sort(&list, NULL);

	list = generate_list(1);
	printf("%ssize 1 list%s\n", BLUE, RESET_COLOR);
	print_list(list);
	ft_list_sort(&list, cmp);
	print_list(list);
	free_list(list);

	list = generate_list(2);
	printf("%ssize 2 list%s\n", BLUE, RESET_COLOR);
	print_list(list);
	ft_list_sort(&list, cmp);
	print_list(list);
	free_list(list);
}

void	test_general()
{
    printf("%sTest_general_cases%s\n", GREEN, RESET_COLOR);

	t_list	*list = NULL;

	list = generate_list(10);
	printf("%ssize 10 (pair) list%s\n", BLUE, RESET_COLOR);
	print_list(list);
	ft_list_sort(&list, cmp);
	print_list(list);
	free_list(list);

	list = generate_list(9);
	printf("%ssize 9 (odd) list%s\n", BLUE, RESET_COLOR);
	print_list(list);
	ft_list_sort(&list, cmp);
	print_list(list);
	free_list(list);

	list = generate_list(250);
	printf("%ssize 250 list (Contains repetitive numbers (data = rand %% 100))%s\n", BLUE, RESET_COLOR);
	print_list(list);
	ft_list_sort(&list, cmp);
	print_list(list);
	free_list(list);
}

void    test_ft_list_sort()
{
	printf("%sTest_ft_list_sort%s\n", YELLOW, RESET_COLOR);

	ft_test_speed(ft_list_sort);
	test_edge_cases();
	test_general();

	printf("\n");
}
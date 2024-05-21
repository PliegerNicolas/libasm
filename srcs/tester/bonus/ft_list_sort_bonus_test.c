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

	test_edge_cases();
	test_general();

	printf("\n");
}
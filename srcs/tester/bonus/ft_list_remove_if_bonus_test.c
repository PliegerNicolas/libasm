/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_remove_if_bonus_test.c                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:54:12 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:54:12 by rishmor          ###   ########.fr       */
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

static void	free_fct(void *data_ptr)
{
	if (data_ptr)
		free(data_ptr);
}

/* Tests */

static int	test_rm_if_general_usage(t_list **head)
{
    printf("%sTest_rn_if_general_usage%s\n", GREEN, RESET_COLOR);

	int	*ref_data = NULL;

    printf("%srm_if null ref_data%s\n", BLUE, RESET_COLOR);
	print_list(*head);
	ft_list_remove_if(head, ref_data, cmp, free_fct);
	print_list(*head);

	printf("%srm_if if node contains -42 (no equality in list)%s\n", BLUE, RESET_COLOR);
	ref_data = generate_data(-42);
	if (!ref_data)
		return (1);
	print_list(*head);
	ft_list_remove_if(head, ref_data, cmp, free_fct);
	print_list(*head);
	free(ref_data);

	printf("%srm_if if node contains 1 (one element, in the middle)%s\n", BLUE, RESET_COLOR);
	ref_data = generate_data(1);
	if (!ref_data)
		return (1);
	print_list(*head);
	ft_list_remove_if(head, ref_data, cmp, free_fct);
	print_list(*head);
	free(ref_data);

	printf("%srm_if if node contains 42 (multiple elements, and some at start)%s\n", BLUE, RESET_COLOR);
	ref_data = generate_data(42);
	if (!ref_data)
		return (1);
	print_list(*head);
	ft_list_remove_if(head, ref_data, cmp, free_fct);
	print_list(*head);
	free(ref_data);

	return (0);
}

static int	test_rm_if_with_nulls()
{
    printf("%sTest_rn_if_with_nulls%s\n", GREEN, RESET_COLOR);

	t_list	*list = NULL;
	int		*ref_data = NULL;

    printf("%srm_if with only null arguments%s\n", BLUE, RESET_COLOR);
	ft_list_remove_if(NULL, ref_data, NULL, NULL);

    printf("%srm_if with empty list and null arguments%s\n", BLUE, RESET_COLOR);
	ft_list_remove_if(&list, ref_data, NULL, NULL);

	ref_data = generate_data(42);
	if (!ref_data)
		return (1);

    printf("%srm_if with null functions ptr only%s\n", BLUE, RESET_COLOR);
	ft_list_remove_if(&list, ref_data, NULL, NULL);

    printf("%srm_if with free_fct null only%s\n", BLUE, RESET_COLOR);
	ft_list_remove_if(&list, ref_data, cmp, NULL);

	free(ref_data);

	return (0);
}

void    test_ft_list_remove_if(t_list **head)
{
	printf("%sTest_ft_list_remove_if%s\n", YELLOW, RESET_COLOR);

	if (test_rm_if_with_nulls())
		return ;
	if (test_rm_if_general_usage(head))
		return ;

	printf("\n");
}
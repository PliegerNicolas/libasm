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

void    test_ft_list_sort(t_list **head)
{
	printf("%sTest_ft_list_sort%s\n", YELLOW, RESET_COLOR);

	print_list(*head);
	printf("%d\n", ft_list_sort(head, cmp));
	print_list(*head);

	printf("\n");
}
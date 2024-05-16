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

//void        ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void*));

int		cmp(int *data, int *data_ref)
{
	return (*data - *data_ref);
}

void	free_fct(void *data_ptr)
{
	if (data_ptr)
		free(data_ptr);
}

void    test_ft_list_remove_if(t_list **head)
{
	printf("%sTest_ft_list_remove_if%s\n", YELLOW, RESET_COLOR);

	int	target_data = 3;
	print_list(*head);
	ft_list_remove_if(head, &target_data, cmp, free_fct);
	print_list(*head);

	printf("\n");
}
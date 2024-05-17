/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_size_bonus_test.c                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:54:27 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:54:27 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include "libasm_tester.h"

void    test_empty_list()
{
    printf("%sTest_empty_list%s\n", GREEN, RESET_COLOR);

    t_list  *list = NULL;

    print_list(list);
    printf("Size: %d\n", ft_list_size(list));
}

void    test_lengthy_list(t_list **head)
{
    printf("%sTest_lengthy_list%s\n", GREEN, RESET_COLOR);

    print_list(*head);
    printf("Size: %d\n", ft_list_size(*head));
}

void    test_ft_list_size(t_list **head)
{
	printf("%sTest_ft_list_size%s\n", YELLOW, RESET_COLOR);

    test_empty_list();
    test_lengthy_list(head);

	printf("\n");
}
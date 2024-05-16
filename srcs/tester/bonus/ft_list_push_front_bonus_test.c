/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_push_front_bonus_test.c                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:54:22 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:54:22 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include "libasm_tester.h"

void    test_ft_list_push_front(t_list **head)
{
	printf("%sTest_ft_list_push_front%s\n", YELLOW, RESET_COLOR);

    int *data = generate_data(42);
    ft_list_push_front(head, data);
    print_list(*head);

	printf("\n");
}
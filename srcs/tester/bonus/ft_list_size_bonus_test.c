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

void    test_ft_list_size(t_list *head)
{
	printf("%sTest_ft_list_size%s\n", YELLOW, RESET_COLOR);

    print_list(head);
    printf("%d\n", ft_list_size(head));

	printf("\n");
}
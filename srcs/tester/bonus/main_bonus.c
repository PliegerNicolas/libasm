/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_bonus.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:40:28 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:40:29 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include "libasm_tester.h"

int	main(void)
{
    // Mandatory
	test_ft_read();
	test_ft_write();
	test_ft_strlen();
	test_ft_strcmp();
	test_ft_strcpy();
	test_ft_strdup();

    // Bonus
	test_ft_atoi_base();
	test_ft_list_push_front();
	test_ft_list_remove_if();
	test_ft_list_size();
	test_ft_list_sort();

	return (0);
}

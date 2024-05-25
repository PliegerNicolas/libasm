/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi_base_bonus_test.c                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/16 11:54:05 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/16 11:54:06 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include "libasm_tester.h"

void    test_ft_atoi_base()
{
	printf("%sTest_ft_atoi_base%s\n", YELLOW, RESET_COLOR);

	char	*s = "  \t\r   +---+Salut";

    //printf("%d\n", ft_atoi_base("-++-a", "0123456789ABCDEF"));
	printf("%s\n", s);
	printf("%d\n", ft_atoi_base(s, "0123"));

	printf("\n");
}

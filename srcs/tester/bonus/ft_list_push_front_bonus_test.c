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

static int  test_push_multiple(t_list **head)
{
    printf("%sTest_push_multiple%s\n", GREEN, RESET_COLOR);

    int     *data = NULL;

	printf("%sPush front: 42%s\n", BLUE, RESET_COLOR);
    data = generate_data(42);
    if (!data)
        return (1);
    ft_list_push_front(head, data);
    print_list(*head);

	printf("%sPush front: -24%s\n", BLUE, RESET_COLOR);
    data = generate_data(-24);
    if (!data)
        return (1);
    ft_list_push_front(head, data);
    print_list(*head);

	printf("%sPush front: 42%s\n", BLUE, RESET_COLOR);
    data = generate_data(42);
    if (!data)
        return (1);
    ft_list_push_front(head, data);
    print_list(*head);

	printf("%sPush front: 42%s\n", BLUE, RESET_COLOR);
    data = generate_data(42);
    if (!data)
        return (1);
    ft_list_push_front(head, data);
    print_list(*head);

    return (0);
}

static int  test_push_with_nulls()
{
    printf("%sTest_push_with_null%s\n", GREEN, RESET_COLOR);

    t_list  *list = NULL;
    int     *data = NULL;

    printf("%sPush-front null to null%s\n", BLUE, RESET_COLOR);
    ft_list_push_front(NULL, NULL);

    printf("%sPush-front 42 to null%s\n", BLUE, RESET_COLOR);
    data = generate_data(42);
    if (!data)
        return (1);
    ft_list_push_front(NULL, data);
    free(data);

    printf("%sPush-front 42 to empty list%s\n", BLUE, RESET_COLOR);
    print_list(list);
    data = generate_data(42);
    if (!data)
        return (1);
    ft_list_push_front(&list, data);
    print_list(list);

    printf("%sPush-front null to list%s\n", BLUE, RESET_COLOR);
    print_list(list);
    ft_list_push_front(&list, NULL);
    print_list(list);

    free_list(list);

    return (0);
}

void    test_ft_list_push_front(t_list **head)
{
	printf("%sTest_ft_list_push_front%s\n", YELLOW, RESET_COLOR);

    if (test_push_multiple(head))
        return ;
    if (test_push_with_nulls())
        return ;

    printf("\n");
}
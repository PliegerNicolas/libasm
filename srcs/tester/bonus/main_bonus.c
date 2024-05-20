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

t_list  *push_node(t_list *head, void *new_data)
{
    t_list  *current_node = head;
    t_list  *new_node;

    new_node = malloc(1 * sizeof(*new_node));
    if (!new_node)
        return (head);

    new_node->data = new_data;
    new_node->next = NULL;

    if (!head)
        head = new_node;
    else
    {
        while (current_node->next)
            current_node = current_node->next;
        current_node->next = new_node;
    }
    return (head);
}

int	*generate_data(int nbr)
{
	int	*data = NULL;
	data = malloc(sizeof(nbr));
	if (!data)
		return (NULL);
	*data = nbr;
	return (data);
}

void	print_list(t_list *head)
{
	t_list	*current_node = head;

	printf("[");
	while (current_node)
	{
		if (current_node->data)
			printf("%d", *((int*)(current_node->data)));
		else
			printf("(null)");
		if (current_node->next)
			printf(", ");
		current_node = current_node->next;
	}
	printf("]\n");
}

t_list  *free_list(t_list *head)
{
    t_list  *current_node = head;
    t_list  *tmp = NULL;

    while (current_node)
    {
        tmp = current_node;
		if (tmp->data)
			free(tmp->data);
        current_node = current_node->next;
        free(tmp);
    }

    return (NULL);
}

int	main(void)
{
    // Mandatory
	//test_ft_read();
	//test_ft_write();
	//test_ft_strlen();
	//test_ft_strcmp();
	//test_ft_strcpy();
	//test_ft_strdup();

	t_list  *list = NULL;
	int		*data = NULL;

	srand(time(NULL));

	for(int i = 0; i < 10; ++i)
	{
		data = generate_data(rand() % 100);
		if (!data)
			return (free_list(list), 1);
		list = push_node(list, data);
	}

	// Bonus
	test_ft_atoi_base(&list);
	test_ft_list_push_front(&list);
	test_ft_list_remove_if(&list);
	test_ft_list_size(&list);
	test_ft_list_sort(&list);

	return (free_list(list), 0);
}

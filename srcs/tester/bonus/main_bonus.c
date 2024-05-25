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

/* Output */

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

void	print_list_ptrs(t_list *head)
{
	t_list	*current_node = head;

	printf("[");
	while (current_node)
	{
		if (current_node->data)
			printf("%p", current_node);
		else
			printf("(null)");
		if (current_node->next)
			printf(", ");
		current_node = current_node->next;
	}
	printf("]\n");
}

/* Creation. */

int	*generate_data(int nbr)
{
	int	*data = NULL;
	data = malloc(sizeof(nbr));
	if (!data)
		return (NULL);
	*data = nbr;
	return (data);
}

t_list	*generate_list(size_t n)
{
	t_list	*new_list = NULL;
	int		*data = NULL;

	srand(time(NULL));

	for(size_t i = 0; i < n; ++i)
	{
		data = generate_data(rand() % 100);
		if (!data)
			return (free_list(new_list), NULL);
		new_list = push_node(new_list, data);
	}

	return (new_list);
}

/* Manipulation */

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

/* Main */

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

/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/07 11:34:04 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/07 12:11:12 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <errno.h>

# include <unistd.h>
# include <fcntl.h>
# include <string.h>
# include <stdlib.h>
# include <stdio.h>

// Mandatory
ssize_t     ft_read(int fd, void *buf, size_t count);
int         ft_strcmp(const char *s1, const char *s2);
char        *ft_strcpy(char *dest, const char *src);
char        *ft_strdup(const char *s);
size_t      ft_strlen(const char *str);
ssize_t     ft_write(int fd, const void *buf, size_t count);

// Bonus

typedef struct  s_list
{
    void            *data;
    struct s_list   *next;
}   t_list;

int         ft_atoi_base(char const *str, char const *base);
void        ft_list_push_front(t_list **begin_list, void *data);
void        ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void*));
int         ft_list_size(t_list *begin_list);
void        ft_list_sort(t_list **begin_list,int (*cmp)());

#endif

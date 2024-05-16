/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm_tester.h                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rishmor <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/10 12:36:52 by rishmor           #+#    #+#             */
/*   Updated: 2024/05/10 12:36:54 by rishmor          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_TESTER_H
# define LIBASM_TESTER_H

# define GREEN "\x1b[32m"
# define YELLOW "\x1b[33m"
# define BLUE "\x1b[34m"
# define GRAY "\x1b[90m"
# define RESET_COLOR "\x1b[0m"

# include <time.h>
# include <bits/time.h>

// Mandatory
void    test_ft_read();
void    test_ft_strcmp();
void    test_ft_strcpy();
void    test_ft_strdup();
void    test_ft_strlen();
void    test_ft_write();

// Bonus
void    test_ft_atoi_base();
void    test_ft_list_push_front();
void    test_ft_list_remove_if();
void    test_ft_list_size();
void    test_ft_list_sort();

#endif

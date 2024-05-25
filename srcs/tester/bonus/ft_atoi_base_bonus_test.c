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

#define DECIMAL_BASE "0123456789"
#define HEX_BASE "0123456789ABCDEF"
#define BINARY_BASE "01"
#define MDR_BASE "mdr"

static void	test_edge_cases()
{
    printf("%sTest_edge_cases%s\n", GREEN, RESET_COLOR);

	char	*s = NULL;
	char	*base = NULL;
	int		res;

	printf("%snull arguments%s\n", BLUE, RESET_COLOR);
	res = ft_atoi_base(s, base);
	printf("Result = %d\n", res);

	printf("%snull base%s\n", BLUE, RESET_COLOR);
	res = ft_atoi_base("Something", base);
	printf("Result = %d\n", res);

	printf("%snull str%s\n", BLUE, RESET_COLOR);
	res = ft_atoi_base(s, "Something");
	printf("Result = %d\n", res);

	printf("%smax_int (overflow permitted by subject)%s\n", BLUE, RESET_COLOR);
	s = "2147483647";
	res = ft_atoi_base(s, DECIMAL_BASE);
	printf("Result = %d\n", res);

	printf("%smin_int (overflow permitted by subject)%s\n", BLUE, RESET_COLOR);
	s = "-2147483648";
	res = ft_atoi_base(s, DECIMAL_BASE);
	printf("Result = %d\n", res);

	printf("%soverflow (UB)%s\n", BLUE, RESET_COLOR);
	s = "21474836471";
	res = ft_atoi_base(s, DECIMAL_BASE);
	printf("Result = %d\n", res);

	printf("%sunderflow (UB)%s\n", BLUE, RESET_COLOR);
	s = "-21474836481";
	res = ft_atoi_base(s, DECIMAL_BASE);
	printf("Result = %d\n", res);
}

static void	test_base_error()
{
    printf("%sTest_base_error%s\n", GREEN, RESET_COLOR);

	char	*s = NULL;
	char	*base = NULL;
	int		res;

	printf("%slen 0%s\n", BLUE, RESET_COLOR);
	s = "42";
	base = "";
	res = ft_atoi_base(s, base);
	printf("Result = %d\n", res);

	printf("%slen 1%s\n", BLUE, RESET_COLOR);
	s = "42";
	base = "0";
	res = ft_atoi_base(s, base);
	printf("Result = %d\n", res);

	printf("%sBase with '-'%s\n", BLUE, RESET_COLOR);
	s = "42";
	base = "0123-456789";
	res = ft_atoi_base(s, base);
	printf("Result = %d\n", res);

	printf("%sBase with '+'%s\n", BLUE, RESET_COLOR);
	s = "42";
	base = "0123456789+";
	res = ft_atoi_base(s, base);
	printf("Result = %d\n", res);

	printf("%sBase with whitespace%s\n", BLUE, RESET_COLOR);
	s = "42";
	base = "012345\r6789";
	res = ft_atoi_base(s, base);
	printf("Result = %d\n", res);

	printf("%sBase with whitespace at start%s\n", BLUE, RESET_COLOR);
	s = "42";
	base = " 0123456789";
	res = ft_atoi_base(s, base);
	printf("Result = %d\n", res);

	printf("%sBase with duplicate char%s\n", BLUE, RESET_COLOR);
	s = "42";
	base = "01234506789";
	res = ft_atoi_base(s, base);
	printf("Result = %d\n", res);

	printf("%sConvert 0 to decimal%s\n", BLUE, RESET_COLOR);
	s = "0";
	base = DECIMAL_BASE;
	res = ft_atoi_base(s, base);
	printf("Result = %d\n", res);
}

static void	test_general()
{
    printf("%sTest_general_cases%s\n", GREEN, RESET_COLOR);

	char	*s = NULL;
	char	*base = NULL;
	int		res;

	printf("%sConvert 42 in decimal%s\n", BLUE, RESET_COLOR);
	s = "42";
	base = DECIMAL_BASE;
	res = ft_atoi_base(s, base);
	printf("42 expected: %d\n", res);

	printf("%sConvert 2A in hex base%s\n", BLUE, RESET_COLOR);
	s = "2A";
	base = HEX_BASE;
	res = ft_atoi_base(s, base);
	printf("42 expected: %d\n", res);

	printf("%sConvert 101010 in binary base%s\n", BLUE, RESET_COLOR);
	s = "101010";
	base = BINARY_BASE;
	res = ft_atoi_base(s, base);
	printf("42 Expected: %d\n", res);

	printf("%sConvert ddrm in mdr base%s\n", BLUE, RESET_COLOR);
	s = "ddrm";
	base = MDR_BASE;
	res = ft_atoi_base(s, base);
	printf("42 Expected: %d\n", res);

	printf("%sConvert ' \r   -+++-ddrm' in mdr base%s\n", BLUE, RESET_COLOR);
	s = " \r   -+++-ddrm";
	base = MDR_BASE;
	res = ft_atoi_base(s, base);
	printf("42 Expected: %d\n", res);

	printf("%sConvert ' \r   -+++--ddrm' in mdr base%s\n", BLUE, RESET_COLOR);
	s = " \r   -+++--ddrm";
	base = MDR_BASE;
	res = ft_atoi_base(s, base);
	printf("-42 Expected: %d\n", res);

	printf("%sConvert '42AB42' in decimal%s\n", BLUE, RESET_COLOR);
	s = "42AB42";
	base = DECIMAL_BASE;
	res = ft_atoi_base(s, base);
	printf("42 expected: %d\n", res);

	printf("%sConvert '42AB42' in hex%s\n", BLUE, RESET_COLOR);
	s = "42AB42";
	base = HEX_BASE;
	res = ft_atoi_base(s, base);
	printf("4369218 expected: %d\n", res);
}

void    test_ft_atoi_base()
{
	printf("%sTest_ft_atoi_base%s\n", YELLOW, RESET_COLOR);

	test_edge_cases();
	test_base_error();
	test_general();
    //printf("%d\n", ft_atoi_base("-A0F", "0123456789ABCDEF"));
	//printf("%d\n", ft_atoi_base("2147483647", "0123456789"));
	//printf("%d\n", ft_atoi_base("-2147483648", "0123456789"));
	//printf("%d\n", ft_atoi_base("2147483648", "0123456789"));
	//printf("%d\n", ft_atoi_base("-2147483649", "0123456789"));
	//printf("%d\n", ft_atoi_base(s, "0123"));

	printf("\n");
}

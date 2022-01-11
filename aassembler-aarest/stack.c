#include "stack.h"
#include <stdio.h>

int push(stack * s, int val) {
	int rc = -1;
	if (s->h < stack_max_height)
		s->s[(s->h)++] = val, rc = 0;
	return rc;
}

int pop(stack * s, int * val) {
	int rc = -1;
	if (s->h > 0)
		*val = s->s[--(s->h)], rc = 0;
	return rc;
}
int tos(stack * s, int * val) {
	int rc = -1;
	if (s->h > 0)
		*val = s->s[s->h], rc = 0;
	return rc;
}
/*
int main() {
	stack ram = {{0}, 0}, pcs = {{0}, 0};
	int rc, val;
	printf("%d\n", push(&ram, 1));
	rc = pop(&ram, &val);
	printf("%d %d\n", rc, val);
	rc = pop(&ram, &val);
	printf("%d %d\n", rc, val);
	return 0;
}
*/

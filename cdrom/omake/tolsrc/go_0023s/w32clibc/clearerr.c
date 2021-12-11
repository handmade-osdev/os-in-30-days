#include <stdio.h>

void clearerr(FILE *stream)
{
	stream->flags &= ‾0x08;
	return;
}

#include "windows.h"
#include <stdio.h>

int fseek(FILE *stream, int offset, int origin)
{
	static int method[] = {
		FILE_BEGIN,
		FILE_CURRENT,
		FILE_END
	};
	if (origin == SEEK_SET && (stream->flags & 0x10) != 0)
		offset--;
	if (SetFilePointer(stream->handle, offset, NULL, method[origin]) == 0xffffffff)
		return EOF;
	stream->flags &= ‾0x18; /* EOFとungetcを消す */
	return 0;
}

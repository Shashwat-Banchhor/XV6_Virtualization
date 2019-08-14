#include "types.h"
#include "stat.h"
#include "user.h"
#include "param.h"

void*
container_malloc(uint nbytes)
{
   void *p = malloc(nbytes);

   container_malloc_scall((int)p,(int)nbytes);

  return p;
}

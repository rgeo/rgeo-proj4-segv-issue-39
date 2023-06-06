#include <ruby.h>
#include <proj.h>

void Init_repro() {
	PJ* myproj;
	PJ_CONTEXT* ctx;
#ifdef NOSEGV
	ctx = proj_context_create();
#else
	ctx = PJ_DEFAULT_CTX;
#endif
	myproj = proj_create(ctx, "EPSG:4055");
	proj_destroy(myproj);
	proj_context_destroy(ctx);
	printf("inited\n");
}

#include <stdio.h>
#include <stdlib.h>

int main() {

    const char* name= "time2";
    FILE* fp;
    fp = fopen("outputCode.txt","wa");
    int i;
    int index[4] = {1,2,3,5};
    fprintf(fp,"%s = [",name);

    for(i = 0; i < 3; i++)
        fprintf(fp, "%s_%d,", name, index[i]);
    fprintf(fp,"%s_%d];", name,index[3]);
    fclose(fp);

    return 0;
}


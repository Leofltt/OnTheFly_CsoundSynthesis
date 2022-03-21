#include <plugin.h>

struct Example : csnd::Plugin<1,1> 
{
    int init() 
    {
        return OK;
    }

    int kperf()
    {
        return OK;
    }

    int aperf()
    {
        csnd::AudioSig input (this, inargs(0));
        csnd::AudioSig output(this, outargs(0));

        for (int i=offset; i < nsmps; i++) 
        {
            output[i] = input[i];
        }

        return OK;
    }   
};

#include <modload.h>

void csnd::on_load(Csound *csound)
{
    csnd::plugin<Example>(csound, "example", "a", "a", csnd::thread::a); 

}
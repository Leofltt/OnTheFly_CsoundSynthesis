#include <plugin.h>

struct Example : csnd::Plugin<1,2> 
{
    MYFLT amp;

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
        amp = inargs[1];
        csnd::AudioSig input(this, inargs(0));
        csnd::AudioSig output(this, outargs(0));
        for (int i=offset; i < nsmps; i++) 
        {
            output[i] = input[i]*amp;
        }
        return OK;
    }   
};

#include <modload.h>

void csnd::on_load(Csound *csound)
{
    csnd::plugin<Example>(csound, "example", "a", "ax", csnd::thread::a); 

}
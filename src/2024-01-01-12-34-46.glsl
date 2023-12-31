#define PI 3.1415926535

float random(vec2 st){
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

mat2 rot(float angle){
    return mat2(cos(angle),-sin(angle),sin(angle),cos(angle));
}

float atan2(float y,float x){
    return x==0.?sign(y)*PI/2.:atan(y,x);
}

vec2 xy2pol(vec2 xy){
    return vec2(atan2(xy.y,xy.x),length(xy));
}

vec2 pol2xy(vec2 pol){
    return pol.y*vec2(cos(pol.x),sin(pol.x));
}

float easeInSine(float x){
    return 1.-cos((x*3.14159265359)/2.);
}

float easeOutSine(float x){
    return sin((x*3.14159265359)/2.);
}

float easeInOutSine(float x){
    return-(cos(3.14159265359*x)-1.)/2.;
}

float easeInQuad(float x){
    return x*x;
}

float easeOutQuad(float x){
    return 1.-(1.-x)*(1.-x);
}

float easeInOutQuad(float x){
    return x<.5?2.*x*x:1.-pow(-2.*x+2.,2.)/2.;
}

float easeInCubic(float x){
    return x*x*x;
}

float easeOutCubic(float x){
    return 1.-pow(1.-x,3.);
}

float easeInOutCubic(float x){
    return x<.5?4.*x*x*x:1.-pow(-2.*x+2.,3.)/2.;
}

float easeInQuart(float x){
    return x*x*x*x;
}

float easeOutQuart(float x){
    return 1.-pow(1.-x,4.);
}

float easeInOutQuart(float x){
    return x<.5?8.*x*x*x*x:1.-pow(-2.*x+2.,4.)/2.;
}

float easeInQuint(float x){
    return x*x*x*x*x;
}

float easeOutQuint(float x){
    return 1.-pow(1.-x,5.);
}

float easeInOutQuint(float x){
    return x<.5?16.*x*x*x*x*x:1.-pow(-2.*x+2.,5.)/2.;
}

float easeInExpo(float x){
    return x==0.?0.:pow(2.,10.*x-10.);
}

float easeOutExpo(float x){
    return x==1.?1.:1.-pow(2.,-10.*x);
}

float easeInOutExpo(float x){
    return x==0.?0.:x==1.?1.:x<.5?pow(2.,20.*x-10.)/2.:(2.-pow(2.,-20.*x+10.))/2.;
}

float easeInCirc(float x){
    return 1.-sqrt(1.-x*x);
}

float easeOutCirc(float x){
    return sqrt(1.-pow(x-1.,2.));
}

float easeInOutCirc(float x){
    return x<.5?(1.-sqrt(1.-pow(2.*x,2.)))/2.:(sqrt(1.-pow(-2.*x+2.,2.))+1.)/2.;
}

float easeOutBack(float x){
    float c1=1.70158;
    float c3=c1+1.;
    return 1.+c3*pow(x-1.,3.)+c1*pow(x-1.,2.);
}

float easeInOutBack(float x){
    float c1=1.70158;
    float c2=c1*1.525;
    return x<.5?(pow(2.*x,2.)*((c2+1.)*2.*x-c2))/2.:(pow(2.*x-2.,2.)*((c2+1.)*(x*2.-2.)+c2)+2.)/2.;
}

// -------------------------

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord/iResolution.xy;
    uv = (uv-.5)*2.;
    vec2 Uv = uv;

    uv = floor(uv*300.)/300.;
    uv = abs(uv)-.5;
    uv=abs(uv)-.5;
    uv=abs(uv)-.5;

    vec3 col=vec3(.1);

    // uv *= rot(iTime/5.);

    uv *= rot(.5);
    col.r += step(abs(sin(uv.y*40.)), .5);
    col.g+=step(abs(sin(uv.y*40.)),.5)*.3;

    uv*=rot(PI/2.);
    col.r+=step(abs(sin(uv.y*10.)),.4)*.3 + step(abs(sin(uv.y*10.)),.8)*.8 + step(abs(sin(uv.y*20.)),.2)*.9;
    col.g+=step(abs(sin(uv.y*10.)),.4)*.2 + step(abs(sin(uv.y*10.)),.8)*.1 + step(abs(sin(uv.y*20.)),.2)*.3;
    col.b+=step(abs(sin(uv.y*10.)),.4)*.7 + step(abs(sin(uv.y*10.)),.8)*.3 + step(abs(sin(uv.y*20.)),.2)*.6;

    uv*=rot(PI/2.);
    col.rgb -= step(abs(sin(uv.y*100.)),.1);

    col.rgb += step(.8, length(Uv));

    fragColor=vec4(col,1.);
}
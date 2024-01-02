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

vec3 edge(vec3 col){
    float gray=length(col);
    return vec3(step(.09,fwidth(gray)));
}

vec2 mirror(vec2 uv){
    return abs(uv-.5);
}

vec2 polarMod(vec2 uv,float n){
    uv=xy2pol(uv);
    float th=mod(uv.x,PI/n*2.);
    th=min(th,PI/n*2.-th);
    uv=uv.y*vec2(cos(th),sin(th));
    return uv;
}

vec2 distortion(vec2 uv){
    return uv*(1.-length(uv));
}

vec3 texBlur(sampler2D tex, vec2 uv){
    vec3 result;
    for(float x=-.01;x<=.01;x+=.01){
        for(float y=-.01;y<=.01;y+=.01){
            vec2 newUv=uv+vec2(x,y);
            vec3 c=texture2D(tex,newUv).rgb;
            result+=c;
        }
    }
    return result/=9.;
}

// -------------------------

#iChannel0"https://66.media.tumblr.com/tumblr_mcmeonhR1e1ridypxo1_500.jpg"
#iChannel1"https://1.bp.blogspot.com/-7OzCCLysaWY/VCOJTY7fF5I/AAAAAAAAmvY/HqoY2F8aEqA/s800/eto_mark05_tatsu.png"

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord/iResolution.xy;

    vec3 result = texBlur(iChannel0, uv);

    vec4 col = vec4(result, 1.);

    fragColor=col;
}
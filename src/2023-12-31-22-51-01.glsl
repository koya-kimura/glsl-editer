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

vec3 rotate(vec3 p,float angle,vec3 axis){
    vec3 a=normalize(axis);
    float s=sin(angle);
    float c=cos(angle);
    float r=1.-c;
    mat3 m=mat3(
        a.x*a.x*r+c,
        a.y*a.x*r+a.z*s,
        a.z*a.x*r-a.y*s,
        a.x*a.y*r-a.z*s,
        a.y*a.y*r+c,
        a.z*a.y*r+a.x*s,
        a.x*a.z*r+a.y*s,
        a.y*a.z*r-a.x*s,
        a.z*a.z*r+c
    );
    return m*p;
}

float sdBox(vec3 p,vec3 b)
{
    vec3 q=abs(p)-b;
    return length(max(q,0.))+min(max(q.x,max(q.y,q.z)),0.);
}

vec3 normal(vec3 pos,float size){
    float v=.001;
    return normalize(vec3(sdBox(pos,vec3(size))-sdBox(vec3(pos.x-v,pos.y,pos.z),vec3(size)),sdBox(pos,vec3(size))-sdBox(vec3(pos.x,pos.y-v,pos.z),vec3(size)),sdBox(pos,vec3(size))-sdBox(vec3(pos.x,pos.y,pos.z-v),vec3(size))));
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    float t=mod(iTime,30.);

    vec2 uv=fragCoord/iResolution.xy;

    uv-=vec2(.5);
    uv.y*=iResolution.y/iResolution.x;

    vec3 cameraPosition=vec3(0.,0.,10.);
    float screenZ=4.;

    vec3 lightDirection=normalize(vec3(sin(iTime),cos(iTime),cos(iTime)));
    vec3 rayDirection=normalize(vec3(uv,screenZ)-cameraPosition);
    vec3 col=vec3(0.);
    float depth=0.;


    for(int i=0;i<99;i++){
        vec3 rayPosition=cameraPosition+rayDirection*depth;
        rayPosition=rotate(rayPosition,iTime,vec3(.5,.5,0.));

        float dist=sdBox(rayPosition,vec3(.2,.2,.2));

        if(dist<.0001){
            vec3 normal=normal(cameraPosition,.2);
            float differ=dot(normal,lightDirection);
            col+=differ*.4;
            break;
        }
        cameraPosition+=rayDirection*dist;
    }

    fragColor=vec4(col,1.);
}
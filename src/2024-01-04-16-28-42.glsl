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

// -------------------------

#iChannel0"../assets/image/night-shibuya.png"

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord/iResolution.xy;

    for(float i=0.;i<30.;++i){
        if(random(vec2(i,i+.1))<uv.x&&uv.x<random(vec2(i,i+.1))+random(vec2(i,i+.2))*.6&&random(vec2(i,i+.3))<uv.y&&uv.y<random(vec2(i,i+.3))+random(vec2(i,i+.4))*.6){
            uv.x-=((mod(i,2.)*2.)-1.)*.02*step(fract(iTime),.8);
            uv.y-=((mod(i,2.)*2.)-1.)*.02*step(fract(iTime+.1), .8);
        }
    }

    vec4 col=texture(iChannel0,uv);

    col.rgb += vec3(random(uv)*.2);

    fragColor=col;
}
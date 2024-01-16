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

vec3 colors[5];

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    colors[0]=vec3(1.,.71,.72);// #FFB4B8
    colors[1]=vec3(.94,.29,.16);// #EF4B28
    colors[2]=vec3(.04,.34,.23);// #0A563A
    colors[3]=vec3(1.,.74,.33);// #FFBC54
    colors[4]=vec3(.93,.91,.88);// #ECE9E0

    vec2 uv=fragCoord/iResolution.xy;
    uv = fract(uv*10.);

    uv = xy2pol((uv-.5)*2.);

    uv.x = min(mod(uv.x, PI/4.), PI/4.-mod(uv.x,PI/4.));
    uv.x += uv.y;

    float gray = 1.;

    gray -= step(uv.x, 1.1);

    gray += step(uv.y,.6)*.1;

    gray += step(uv.x,.7)*.1;

    gray += step(uv.x,.5)*.1;

    vec3 col = colors[int(floor(gray*5.))];

    fragColor=vec4(col, 1.);
}